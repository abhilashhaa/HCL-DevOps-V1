  METHOD string_to_tab.

    CALL FUNCTION 'SCMS_STRING_TO_FTEXT'
      EXPORTING
        text      = iv_str
      IMPORTING
        length    = ev_size
      TABLES
        ftext_tab = et_tab
      EXCEPTIONS
        OTHERS    = 1.
    ASSERT sy-subrc = 0.

  ENDMETHOD.