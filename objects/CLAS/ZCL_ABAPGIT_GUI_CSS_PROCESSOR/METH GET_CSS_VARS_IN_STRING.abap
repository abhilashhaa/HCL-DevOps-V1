  METHOD get_css_vars_in_string.
    CONSTANTS: lc_root_pattern     TYPE string VALUE `:root\s*\{([^\}]*)\}`,
               lc_variable_pattern TYPE string VALUE `\-\-([\w\d-]+)\s*:\s*([^\n\r;]*);`.
    DATA: lv_root     TYPE string,
          lo_matcher  TYPE REF TO cl_abap_matcher,
          lo_regex    TYPE REF TO cl_abap_regex,
          ls_variable LIKE LINE OF rt_variables.

    " Only the :root element may define variables for now

    FIND FIRST OCCURRENCE OF REGEX lc_root_pattern IN iv_string SUBMATCHES lv_root.
    IF sy-subrc = 0 AND lv_root IS NOT INITIAL.
      CREATE OBJECT lo_regex
        EXPORTING
          pattern = lc_variable_pattern.
      lo_matcher = lo_regex->create_matcher( text = lv_root ).
      WHILE lo_matcher->find_next( ) = abap_true.
        ls_variable-name = lo_matcher->get_submatch( 1 ).
        ls_variable-value = lo_matcher->get_submatch( 2 ).
        INSERT ls_variable INTO TABLE rt_variables.
        IF sy-subrc <> 0.
          MODIFY TABLE rt_variables FROM ls_variable.
        ENDIF.
      ENDWHILE.
    ENDIF.
  ENDMETHOD.