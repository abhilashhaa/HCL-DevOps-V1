  METHOD xstring_to_string_utf8.

    TRY.
        IF go_convert_in IS INITIAL.
          go_convert_in = cl_abap_conv_in_ce=>create( encoding = 'UTF-8' ).
        ENDIF.

        go_convert_in->convert(
          EXPORTING
            input = iv_data
            n     = xstrlen( iv_data )
          IMPORTING
            data  = rv_string ).

      CATCH cx_parameter_invalid_range
            cx_sy_codepage_converter_init
            cx_sy_conversion_codepage
            cx_parameter_invalid_type.                  "#EC NO_HANDLER
    ENDTRY.

  ENDMETHOD.