  METHOD zif_abapgit_object~deserialize.
* fm RPY_MESSAGE_ID_INSERT almost works, but not in older versions

    DATA: ls_t100a  TYPE t100a,
          ls_t100t  TYPE t100t,
          ls_t100u  TYPE t100u,
          lt_t100   TYPE TABLE OF t100,
          lt_before TYPE TABLE OF t100u.

    FIELD-SYMBOLS: <ls_t100> LIKE LINE OF lt_t100.


    io_xml->read( EXPORTING iv_name = 'T100A'
                  CHANGING cg_data = ls_t100a ).
    io_xml->read( EXPORTING iv_name = 'T100'
                  CHANGING cg_data = lt_t100 ).

    corr_insert( iv_package ).

    SELECT * FROM t100u INTO TABLE lt_before
      WHERE arbgb = ls_t100a-arbgb ORDER BY msgnr. "#EC CI_GENBUFF "#EC CI_BYPASS

    LOOP AT lt_t100 ASSIGNING <ls_t100>.
      DELETE lt_before WHERE msgnr = <ls_t100>-msgnr.
      MODIFY t100 FROM <ls_t100>.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'MSAG: Table T100 modify failed' ).
      ENDIF.
      CLEAR ls_t100u.
      MOVE-CORRESPONDING <ls_t100> TO ls_t100u ##enh_ok.
      ls_t100u-name    = sy-uname.
      ls_t100u-datum   = sy-datum.
      ls_t100u-selfdef = '3'.
      MODIFY t100u FROM ls_t100u.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'MSAG: Table T100U modify failed' ).
      ENDIF.
    ENDLOOP.

    ls_t100a-masterlang = mv_language.
    ls_t100a-lastuser = sy-uname.
    ls_t100a-respuser = sy-uname.
    ls_t100a-ldate = sy-datum.
    ls_t100a-ltime = sy-uzeit.
    MODIFY t100a FROM ls_t100a.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'MSAG: Table T100A modify failed' ).
    ENDIF.

    ls_t100t-sprsl = mv_language.
    ls_t100t-arbgb = ls_t100a-arbgb.
    ls_t100t-stext = ls_t100a-stext.
    MODIFY t100t FROM ls_t100t.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'MSAG: Table T100T modify failed' ).
    ENDIF.

    LOOP AT lt_before INTO ls_t100u.
      DELETE FROM t100 WHERE arbgb = ls_t100u-arbgb
        AND msgnr = ls_t100u-msgnr.                       "#EC CI_SUBRC

      DELETE FROM t100u WHERE arbgb = ls_t100u-arbgb
        AND msgnr = ls_t100u-msgnr.                       "#EC CI_SUBRC
    ENDLOOP.

    deserialize_longtexts( io_xml ).

    deserialize_texts( io_xml ).

  ENDMETHOD.