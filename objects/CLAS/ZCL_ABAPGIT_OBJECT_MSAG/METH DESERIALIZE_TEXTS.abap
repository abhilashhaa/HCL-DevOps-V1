  METHOD deserialize_texts.

    DATA: lv_msg_id     TYPE rglif-message_id,
          ls_t100       TYPE t100,
          lt_t100t      TYPE TABLE OF t100t,
          lt_t100_texts TYPE tt_t100_texts,
          lt_t100u      TYPE TABLE OF t100u.

    FIELD-SYMBOLS: <ls_t100_text> TYPE ty_t100_texts.


    lv_msg_id = ms_item-obj_name.

    SELECT * FROM t100u INTO TABLE lt_t100u
      WHERE arbgb = lv_msg_id ORDER BY PRIMARY KEY.     "#EC CI_GENBUFF

    ii_xml->read( EXPORTING iv_name = 'T100_TEXTS'
                  CHANGING  cg_data = lt_t100_texts ).

    ii_xml->read( EXPORTING iv_name = 'T100T'
                  CHANGING  cg_data = lt_t100t ).

    MODIFY t100t FROM TABLE lt_t100t.                     "#EC CI_SUBRC

    LOOP AT lt_t100_texts ASSIGNING <ls_t100_text>.
      "check if message exists
      READ TABLE lt_t100u TRANSPORTING NO FIELDS
        WITH KEY arbgb = lv_msg_id msgnr = <ls_t100_text>-msgnr BINARY SEARCH.
      CHECK sy-subrc = 0. "if original message doesn't exist no translations added

      MOVE-CORRESPONDING <ls_t100_text> TO ls_t100.
      ls_t100-arbgb = lv_msg_id.
      MODIFY t100 FROM ls_t100.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( 'MSAG: Table T100 modify failed' ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.