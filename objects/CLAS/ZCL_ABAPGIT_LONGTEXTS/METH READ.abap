  METHOD read.

    DATA: ls_longtext TYPE ty_longtext,
          lt_dokil    TYPE zif_abapgit_definitions=>tty_dokil.

    FIELD-SYMBOLS: <ls_dokil> LIKE LINE OF lt_dokil.

    IF lines( it_dokil ) > 0.

      lt_dokil = it_dokil.

    ELSEIF iv_longtext_id IS NOT INITIAL.
      IF iv_master_lang_only = abap_true.
        SELECT * FROM dokil
                 INTO TABLE lt_dokil
                 WHERE id     = iv_longtext_id
                 AND object = iv_object_name
                 AND masterlang = abap_true
                 ORDER BY PRIMARY KEY.
      ELSE.
        SELECT * FROM dokil
                 INTO TABLE lt_dokil
                 WHERE id     = iv_longtext_id
                 AND object = iv_object_name
                 ORDER BY PRIMARY KEY.
      ENDIF.
    ELSE.

      zcx_abapgit_exception=>raise( |serialize_longtexts parameter error| ).

    ENDIF.

    LOOP AT lt_dokil ASSIGNING <ls_dokil>
                     WHERE txtlines > 0.

      CLEAR: ls_longtext.

      ls_longtext-dokil = <ls_dokil>.

      CALL FUNCTION 'DOCU_READ'
        EXPORTING
          id      = <ls_dokil>-id
          langu   = <ls_dokil>-langu
          object  = <ls_dokil>-object
          typ     = <ls_dokil>-typ
          version = <ls_dokil>-version
        IMPORTING
          head    = ls_longtext-head
        TABLES
          line    = ls_longtext-lines.

      CLEAR: ls_longtext-head-tdfuser,
             ls_longtext-head-tdfreles,
             ls_longtext-head-tdfdate,
             ls_longtext-head-tdftime,
             ls_longtext-head-tdluser,
             ls_longtext-head-tdlreles,
             ls_longtext-head-tdldate,
             ls_longtext-head-tdltime.

      INSERT ls_longtext INTO TABLE rt_longtexts.

    ENDLOOP.

  ENDMETHOD.