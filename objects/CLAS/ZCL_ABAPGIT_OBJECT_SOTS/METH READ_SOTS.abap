  METHOD read_sots.

    DATA: lt_sotr_head TYPE STANDARD TABLE OF sotr_headu,
          ls_sots      LIKE LINE OF rt_sots.

    FIELD-SYMBOLS: <ls_sotr_head> TYPE sotr_head,
                   <ls_entry>     LIKE LINE OF ls_sots-entries.


    SELECT * FROM sotr_headu
             INTO TABLE lt_sotr_head
             WHERE paket = ms_item-obj_name
             ORDER BY PRIMARY KEY.

    LOOP AT lt_sotr_head ASSIGNING <ls_sotr_head>.

      CLEAR: ls_sots.

      CALL FUNCTION 'SOTR_STRING_GET_CONCEPT'
        EXPORTING
          concept        = <ls_sotr_head>-concept
        IMPORTING
          header         = ls_sots-header
          entries        = ls_sots-entries
        EXCEPTIONS
          no_entry_found = 1
          OTHERS         = 2.

      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      CLEAR:
        ls_sots-header-paket,
        ls_sots-header-crea_name,
        ls_sots-header-crea_tstut,
        ls_sots-header-chan_name,
        ls_sots-header-chan_tstut.

      LOOP AT ls_sots-entries ASSIGNING <ls_entry>.
        CLEAR: <ls_entry>-version,
               <ls_entry>-crea_name,
               <ls_entry>-crea_tstut,
               <ls_entry>-chan_name,
               <ls_entry>-chan_tstut.
      ENDLOOP.

      INSERT ls_sots INTO TABLE rt_sots.

    ENDLOOP.

  ENDMETHOD.