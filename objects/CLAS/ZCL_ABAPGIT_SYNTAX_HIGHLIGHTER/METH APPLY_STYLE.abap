  METHOD apply_style.

    DATA lv_escaped TYPE string.

    lv_escaped = escape( val = iv_line
                         format = cl_abap_format=>e_html_attr ).
    IF iv_class IS NOT INITIAL.
      rv_line = |<span class="{ iv_class }">{ lv_escaped }</span>|.
    ELSE.
      rv_line = lv_escaped.
    ENDIF.

  ENDMETHOD.