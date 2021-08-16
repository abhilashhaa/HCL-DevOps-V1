  METHOD serialize_texts.

    DATA: lv_name       TYPE ddobjname,
          lv_index      TYPE i,
          ls_dd04v      TYPE dd04v,
          lt_dd04_texts TYPE tt_dd04_texts,
          lt_i18n_langs TYPE TABLE OF langu.

    FIELD-SYMBOLS: <lv_lang>      LIKE LINE OF lt_i18n_langs,
                   <ls_dd04_text> LIKE LINE OF lt_dd04_texts.

    IF ii_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      RETURN.
    ENDIF.

    lv_name = ms_item-obj_name.

    " Collect additional languages, skip master lang - it was serialized already
    SELECT DISTINCT ddlanguage AS langu INTO TABLE lt_i18n_langs
      FROM dd04v
      WHERE rollname = lv_name
      AND ddlanguage <> mv_language.                      "#EC CI_SUBRC

    LOOP AT lt_i18n_langs ASSIGNING <lv_lang>.
      lv_index = sy-tabix.
      CALL FUNCTION 'DDIF_DTEL_GET'
        EXPORTING
          name          = lv_name
          langu         = <lv_lang>
        IMPORTING
          dd04v_wa      = ls_dd04v
        EXCEPTIONS
          illegal_input = 1
          OTHERS        = 2.
      IF sy-subrc <> 0 OR ls_dd04v-ddlanguage IS INITIAL.
        DELETE lt_i18n_langs INDEX lv_index. " Don't save this lang
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO lt_dd04_texts ASSIGNING <ls_dd04_text>.
      MOVE-CORRESPONDING ls_dd04v TO <ls_dd04_text>.

    ENDLOOP.

    SORT lt_i18n_langs ASCENDING.
    SORT lt_dd04_texts BY ddlanguage ASCENDING.

    IF lines( lt_i18n_langs ) > 0.
      ii_xml->add( iv_name = 'I18N_LANGS'
                   ig_data = lt_i18n_langs ).

      ii_xml->add( iv_name = 'DD04_TEXTS'
                   ig_data = lt_dd04_texts ).
    ENDIF.

  ENDMETHOD.