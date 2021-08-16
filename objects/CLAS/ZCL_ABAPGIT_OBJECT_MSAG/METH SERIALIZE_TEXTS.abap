  METHOD serialize_texts.

    DATA: lv_msg_id     TYPE rglif-message_id,
          lt_t100_texts TYPE tt_t100_texts,
          lt_t100t      TYPE TABLE OF t100t,
          lt_i18n_langs TYPE TABLE OF langu.

    lv_msg_id = ms_item-obj_name.

    IF ii_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      RETURN. " skip
    ENDIF.

    " Collect additional languages
    " Skip master lang - it has been already serialized
    SELECT DISTINCT sprsl AS langu INTO TABLE lt_i18n_langs
      FROM t100t
      WHERE arbgb = lv_msg_id
      AND sprsl <> mv_language.          "#EC CI_BYPASS "#EC CI_GENBUFF

    SORT lt_i18n_langs ASCENDING.

    IF lines( lt_i18n_langs ) > 0.

      SELECT * FROM t100t INTO CORRESPONDING FIELDS OF TABLE lt_t100t
        WHERE sprsl <> mv_language
        AND arbgb = lv_msg_id.                          "#EC CI_GENBUFF

      SELECT * FROM t100 INTO CORRESPONDING FIELDS OF TABLE lt_t100_texts
        FOR ALL ENTRIES IN lt_i18n_langs
        WHERE sprsl = lt_i18n_langs-table_line
        AND arbgb = lv_msg_id
        ORDER BY PRIMARY KEY.             "#EC CI_SUBRC "#EC CI_GENBUFF

      SORT lt_t100t BY sprsl ASCENDING.
      SORT lt_t100_texts BY sprsl msgnr ASCENDING.

      ii_xml->add( iv_name = 'I18N_LANGS'
                   ig_data = lt_i18n_langs ).

      ii_xml->add( iv_name = 'T100T'
                   ig_data = lt_t100t ).

      ii_xml->add( iv_name = 'T100_TEXTS'
                   ig_data = lt_t100_texts ).

    ENDIF.

  ENDMETHOD.