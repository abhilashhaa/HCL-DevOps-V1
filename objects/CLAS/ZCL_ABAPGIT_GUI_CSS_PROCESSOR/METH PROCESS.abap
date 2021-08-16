  METHOD process.
    DATA:
          lt_contents         TYPE STANDARD TABLE OF string,
          lv_content          TYPE string,
          lt_css_variables    TYPE gty_css_var_tab,
          lt_css_vars_in_file TYPE gty_css_var_tab.
    FIELD-SYMBOLS: <lv_url>          TYPE string,
                   <ls_css_variable> LIKE LINE OF lt_css_vars_in_file,
                   <lv_content>      LIKE LINE OF lt_contents.

    " 1. Determine all variables and their values. Later definitions overwrite previous ones.
    LOOP AT mt_files ASSIGNING <lv_url>.
      lv_content = mi_asset_manager->get_text_asset(
        iv_url = <lv_url>
        iv_assert_subtype = 'css' ).

      lt_css_vars_in_file = get_css_vars_in_string( lv_content ).

      LOOP AT lt_css_vars_in_file ASSIGNING <ls_css_variable>.
        INSERT <ls_css_variable> INTO TABLE lt_css_variables.
        IF sy-subrc <> 0.
          MODIFY TABLE lt_css_variables FROM <ls_css_variable>.
        ENDIF.
      ENDLOOP.

      APPEND lv_content TO lt_contents.
    ENDLOOP.

    " 2. Replace all variable usages in variables
    LOOP AT lt_css_variables ASSIGNING <ls_css_variable> WHERE value CS 'var(--'.
      resolve_var_recursively( EXPORTING iv_variable_name = <ls_css_variable>-name
                               CHANGING  ct_variables     = lt_css_variables ).
    ENDLOOP.

    " 3. Replace all other variable usages by inlining the values.
    LOOP AT lt_contents ASSIGNING <lv_content>.
      LOOP AT lt_css_variables ASSIGNING <ls_css_variable>.
        REPLACE ALL OCCURRENCES OF |var(--{ <ls_css_variable>-name })|
                IN <lv_content>
                WITH <ls_css_variable>-value.
      ENDLOOP.
    ENDLOOP.

    rv_result = concat_lines_of( table = lt_contents
                                 sep = cl_abap_char_utilities=>newline ).
  ENDMETHOD.