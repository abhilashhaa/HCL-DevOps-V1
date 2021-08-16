  METHOD get_sotr_4_concept.

    DATA: ls_header  TYPE sotr_head,
          lt_entries TYPE sotr_text_tt.

    FIELD-SYMBOLS: <ls_entry> LIKE LINE OF lt_entries.

    CALL FUNCTION 'SOTR_GET_CONCEPT'
      EXPORTING
        concept        = iv_concept
      IMPORTING
        header         = ls_header
      TABLES
        entries        = lt_entries
      EXCEPTIONS
        no_entry_found = 1
        OTHERS         = 2.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    CLEAR: ls_header-paket,
           ls_header-crea_name,
           ls_header-crea_tstut,
           ls_header-chan_name,
           ls_header-chan_tstut.

    LOOP AT lt_entries ASSIGNING <ls_entry>.
      CLEAR: <ls_entry>-version,
             <ls_entry>-crea_name,
             <ls_entry>-crea_tstut,
             <ls_entry>-chan_name,
             <ls_entry>-chan_tstut.
    ENDLOOP.

    rs_sotr-header  = ls_header.
    rs_sotr-entries = lt_entries.

  ENDMETHOD.