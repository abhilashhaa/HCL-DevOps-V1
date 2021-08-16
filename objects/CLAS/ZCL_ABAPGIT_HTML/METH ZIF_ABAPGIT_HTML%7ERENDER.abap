  METHOD zif_abapgit_html~render.

    DATA: ls_context TYPE ty_indent_context,
          lt_temp    TYPE string_table.

    FIELD-SYMBOLS: <lv_line>   LIKE LINE OF lt_temp,
                   <lv_line_c> LIKE LINE OF lt_temp.

    ls_context-no_indent_jscss = iv_no_indent_jscss.

    LOOP AT mt_buffer ASSIGNING <lv_line>.
      APPEND <lv_line> TO lt_temp ASSIGNING <lv_line_c>.
      indent_line( CHANGING cs_context = ls_context cv_line = <lv_line_c> ).
    ENDLOOP.

    CONCATENATE LINES OF lt_temp INTO rv_html SEPARATED BY cl_abap_char_utilities=>newline.

  ENDMETHOD.