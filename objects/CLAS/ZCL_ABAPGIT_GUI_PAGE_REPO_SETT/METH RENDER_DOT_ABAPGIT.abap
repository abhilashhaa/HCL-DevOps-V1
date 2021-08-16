  METHOD render_dot_abapgit.

    DATA: ls_dot          TYPE zif_abapgit_dot_abapgit=>ty_dot_abapgit,
          lv_select_html  TYPE string,
          lv_selected     TYPE string,
          lv_language     TYPE t002t-sptxt,
          lv_ignore       TYPE string,
          lt_folder_logic TYPE string_table.

    FIELD-SYMBOLS: <lv_folder_logic> TYPE LINE OF string_table,
                   <lv_ignore>       TYPE string.

    ls_dot = mo_repo->get_dot_abapgit( )->get_data( ).

    APPEND zif_abapgit_dot_abapgit=>c_folder_logic-full TO lt_folder_logic.
    APPEND zif_abapgit_dot_abapgit=>c_folder_logic-prefix TO lt_folder_logic.

    ii_html->add( '<h2>.abapgit.xml</h2>' ).
    ii_html->add( '<table class="settings">' ).

    SELECT SINGLE sptxt INTO lv_language FROM t002t
      WHERE spras = sy-langu AND sprsl = ls_dot-master_language.
    IF sy-subrc <> 0.
      lv_language = 'Unknown language. Check your settings.'.
    ENDIF.

    ii_html->add( render_table_row(
      iv_name  = 'Master Language'
      iv_value = |{ ls_dot-master_language } ({ lv_language })|
    ) ).

    lv_select_html = '<select name="folder_logic">'.
    LOOP AT lt_folder_logic ASSIGNING <lv_folder_logic>.

      IF ls_dot-folder_logic = <lv_folder_logic>.
        lv_selected = ' selected'.
      ELSE.
        CLEAR: lv_selected.
      ENDIF.

      lv_select_html = lv_select_html
        && |<option value="{ <lv_folder_logic> }"{ lv_selected }>{ <lv_folder_logic> }</option>|.

    ENDLOOP.
    lv_select_html = lv_select_html && '</select>'.

    ii_html->add( render_table_row(
      iv_name  = 'Folder Logic'
      iv_value = lv_select_html
    ) ).

    ii_html->add( render_table_row(
      iv_name  = 'Starting Folder'
      iv_value = |<input name="starting_folder" type="text" size="10" value="{ ls_dot-starting_folder }">|
    ) ).

    LOOP AT ls_dot-ignore ASSIGNING <lv_ignore>.
      lv_ignore = lv_ignore && <lv_ignore> && zif_abapgit_definitions=>c_newline.
    ENDLOOP.

    ii_html->add( render_table_row(
      iv_name  = 'Ignore Files'
      iv_value = |<textarea name="ignore_files" rows="{ lines( ls_dot-ignore )
                 }" cols="50">{ lv_ignore }</textarea>|
    ) ).

    ii_html->add( '</table>' ).

    render_dot_abapgit_reqs(
      it_requirements = ls_dot-requirements
      ii_html         = ii_html ).


  ENDMETHOD.