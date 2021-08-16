  METHOD serialize_texts.

    DATA: lv_name       TYPE ddobjname,
          lv_index      TYPE i,
          ls_dd01v      TYPE dd01v,
          lt_dd07v      TYPE TABLE OF dd07v,
          lt_i18n_langs TYPE TABLE OF langu,
          lt_dd01_texts TYPE tt_dd01_texts,
          lt_dd07_texts TYPE tt_dd07_texts.

    FIELD-SYMBOLS: <lv_lang>      LIKE LINE OF lt_i18n_langs,
                   <ls_dd07v>     LIKE LINE OF lt_dd07v,
                   <ls_dd07v_tmp> LIKE LINE OF lt_dd07v,
                   <ls_dd01_text> LIKE LINE OF lt_dd01_texts,
                   <ls_dd07_text> LIKE LINE OF lt_dd07_texts.

    IF ii_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      RETURN.
    ENDIF.

    lv_name = ms_item-obj_name.

    " Collect additional languages, skip master lang - it was serialized already
    SELECT DISTINCT ddlanguage AS langu INTO TABLE lt_i18n_langs
      FROM dd01v
      WHERE domname = lv_name
      AND ddlanguage <> mv_language.                      "#EC CI_SUBRC

    LOOP AT lt_i18n_langs ASSIGNING <lv_lang>.
      lv_index = sy-tabix.

      CALL FUNCTION 'DDIF_DOMA_GET'
        EXPORTING
          name          = lv_name
          langu         = <lv_lang>
        IMPORTING
          dd01v_wa      = ls_dd01v
        TABLES
          dd07v_tab     = lt_dd07v
        EXCEPTIONS
          illegal_input = 1
          OTHERS        = 2.
      IF sy-subrc <> 0 OR ls_dd01v-ddlanguage IS INITIAL.
        DELETE lt_i18n_langs INDEX lv_index. " Don't save this lang
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO lt_dd01_texts ASSIGNING <ls_dd01_text>.
      MOVE-CORRESPONDING ls_dd01v TO <ls_dd01_text>.

      " Process master language entries and find corresponding translation
      LOOP AT it_dd07v ASSIGNING <ls_dd07v> WHERE NOT ddlanguage IS INITIAL.
        APPEND INITIAL LINE TO lt_dd07_texts ASSIGNING <ls_dd07_text>.
        READ TABLE lt_dd07v ASSIGNING <ls_dd07v_tmp>
          WITH KEY ddlanguage = <lv_lang> domvalue_l = <ls_dd07v>-domvalue_l domvalue_h = <ls_dd07v>-domvalue_h.
        IF sy-subrc = 0.
          MOVE-CORRESPONDING <ls_dd07v_tmp> TO <ls_dd07_text>.
        ELSE.
          " no translation -> keep entry but clear texts
          <ls_dd07_text>-ddlanguage = <lv_lang>.
          CLEAR: <ls_dd07_text>-ddtext, <ls_dd07_text>-domval_ld, <ls_dd07_text>-domval_hd.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

    SORT lt_i18n_langs ASCENDING.
    SORT lt_dd01_texts BY ddlanguage ASCENDING.
    SORT lt_dd07_texts BY valpos ASCENDING ddlanguage ASCENDING.

    IF lines( lt_i18n_langs ) > 0.
      ii_xml->add( iv_name = 'I18N_LANGS'
                   ig_data = lt_i18n_langs ).

      ii_xml->add( iv_name = 'DD01_TEXTS'
                   ig_data = lt_dd01_texts ).

      ii_xml->add( iv_name = 'DD07_TEXTS'
                   ig_data = lt_dd07_texts ).
    ENDIF.

  ENDMETHOD.