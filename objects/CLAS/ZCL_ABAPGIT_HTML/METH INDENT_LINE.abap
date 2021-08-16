  METHOD indent_line.

    DATA: ls_study TYPE ty_study_result,
          lv_x_str TYPE string.

    ls_study = study_line(
      is_context = cs_context
      iv_line    = cv_line ).

    " First closing tag - shift back exceptionally
    IF ( ls_study-script_close = abap_true
        OR ls_study-style_close = abap_true
        OR ls_study-curly_close = abap_true
        OR ls_study-tag_close = abap_true )
        AND cs_context-indent > 0.
      lv_x_str = repeat( val = ` `
                         occ = ( cs_context-indent - 1 ) * c_indent_size ).
      cv_line  = lv_x_str && cv_line.
    ELSE.
      cv_line = cs_context-indent_str && cv_line.
    ENDIF.

    " Context status update
    CASE abap_true.
      WHEN ls_study-script_open.
        cs_context-within_js    = abap_true.
        cs_context-within_style = abap_false.
      WHEN ls_study-style_open.
        cs_context-within_js    = abap_false.
        cs_context-within_style = abap_true.
      WHEN ls_study-script_close OR ls_study-style_close.
        cs_context-within_js    = abap_false.
        cs_context-within_style = abap_false.
        ls_study-closings       = ls_study-closings + 1.
    ENDCASE.

    " More-less logic chosen due to possible double tags in a line '<a><b>'
    IF ls_study-openings <> ls_study-closings.
      IF ls_study-openings > ls_study-closings.
        cs_context-indent = cs_context-indent + 1.
      ELSEIF cs_context-indent > 0. " AND ls_study-openings < ls_study-closings
        cs_context-indent = cs_context-indent - 1.
      ENDIF.
      cs_context-indent_str = repeat( val = ` `
                                      occ = cs_context-indent * c_indent_size ).
    ENDIF.

  ENDMETHOD.