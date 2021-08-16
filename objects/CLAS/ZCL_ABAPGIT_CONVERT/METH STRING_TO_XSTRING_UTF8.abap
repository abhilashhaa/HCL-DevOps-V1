  METHOD string_to_xstring_utf8.

    TRY.
        IF go_convert_out IS INITIAL.
          go_convert_out = cl_abap_conv_out_ce=>create( encoding = 'UTF-8' ).
        ENDIF.

        go_convert_out->convert(
          EXPORTING data = iv_string
          IMPORTING buffer = rv_xstring ).

      CATCH cx_parameter_invalid_range
            cx_sy_codepage_converter_init
            cx_sy_conversion_codepage
            cx_parameter_invalid_type.                  "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.