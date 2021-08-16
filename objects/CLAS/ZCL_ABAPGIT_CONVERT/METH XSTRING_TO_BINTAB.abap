  METHOD xstring_to_bintab.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = iv_xstr
      IMPORTING
        output_length = ev_size
      TABLES
        binary_tab    = et_bintab.

  ENDMETHOD.