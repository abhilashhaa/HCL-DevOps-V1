  METHOD bintab_to_xstring.

    CALL FUNCTION 'SCMS_BINARY_TO_XSTRING'
      EXPORTING
        input_length = iv_size
      IMPORTING
        buffer       = rv_xstr
      TABLES
        binary_tab   = it_bintab
      EXCEPTIONS
        failed       = 1 ##FM_SUBRC_OK.
    ASSERT sy-subrc = 0.

  ENDMETHOD.