  METHOD serialize_longtexts_msag.

    DATA: lv_doku_object_name           TYPE dokhl-object,
          lt_doku_object_names          TYPE STANDARD TABLE OF dokhl-object
                          WITH NON-UNIQUE DEFAULT KEY,
          lt_dokil            TYPE zif_abapgit_definitions=>tty_dokil,
          ls_dokil            LIKE LINE OF lt_dokil,
          lv_master_lang_only TYPE abap_bool.

    FIELD-SYMBOLS: <ls_t100>  TYPE t100.

    IF lines( it_t100 ) = 0.
      RETURN.
    ENDIF.

    LOOP AT it_t100 ASSIGNING <ls_t100>.

      lv_doku_object_name = <ls_t100>-arbgb && <ls_t100>-msgnr.
      INSERT lv_doku_object_name INTO TABLE lt_doku_object_names.

    ENDLOOP.

    lv_master_lang_only = ii_xml->i18n_params( )-serialize_master_lang_only.
    IF lv_master_lang_only = abap_true.
      SELECT * FROM dokil
        INTO TABLE lt_dokil
        FOR ALL ENTRIES IN lt_doku_object_names
        WHERE id = 'NA'
        AND object = lt_doku_object_names-table_line
        AND masterlang = abap_true
        ORDER BY PRIMARY KEY.
    ELSE.
      SELECT * FROM dokil
        INTO TABLE lt_dokil
        FOR ALL ENTRIES IN lt_doku_object_names
        WHERE id = 'NA'
        AND object = lt_doku_object_names-table_line
        ORDER BY PRIMARY KEY.
    ENDIF.

    CLEAR ls_dokil-dokstate.
    MODIFY lt_dokil FROM ls_dokil TRANSPORTING dokstate WHERE dokstate IS NOT INITIAL.

    IF lines( lt_dokil ) > 0.
      serialize_longtexts( ii_xml   = ii_xml
                           it_dokil = lt_dokil ).
    ENDIF.

  ENDMETHOD.