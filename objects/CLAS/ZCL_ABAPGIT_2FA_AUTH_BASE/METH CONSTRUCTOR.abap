  METHOD constructor.
    CREATE OBJECT mo_url_regex
      EXPORTING
        pattern     = iv_supported_url_regex
        ignore_case = abap_true.
  ENDMETHOD.