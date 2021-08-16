  METHOD serialize_texts.

    DATA: lv_name       TYPE ddobjname,
          lv_index      TYPE i,
          ls_dd02v      TYPE dd02v,
          lt_dd02_texts TYPE tt_dd02_texts,
          lt_i18n_langs TYPE TABLE OF langu.

    FIELD-SYMBOLS: <lv_lang>      LIKE LINE OF lt_i18n_langs,
                   <ls_dd02_text> LIKE LINE OF lt_dd02_texts.

    IF io_xml->i18n_params( )-serialize_master_lang_only = abap_true.
      RETURN.
    ENDIF.

    lv_name = ms_item-obj_name.

    " Collect additional languages, skip master lang - it was serialized already
    SELECT DISTINCT ddlanguage AS langu INTO TABLE lt_i18n_langs
      FROM dd02v
      WHERE tabname = lv_name
      AND ddlanguage <> mv_language.                      "#EC CI_SUBRC

    LOOP AT lt_i18n_langs ASSIGNING <lv_lang>.
      lv_index = sy-tabix.
      CALL FUNCTION 'DDIF_TABL_GET'
        EXPORTING
          name          = lv_name
          langu         = <lv_lang>
        IMPORTING
          dd02v_wa      = ls_dd02v
        EXCEPTIONS
          illegal_input = 1
          OTHERS        = 2.
      IF sy-subrc <> 0 OR ls_dd02v-ddlanguage IS INITIAL.
        DELETE lt_i18n_langs INDEX lv_index. " Don't save this lang
        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO lt_dd02_texts ASSIGNING <ls_dd02_text>.
      MOVE-CORRESPONDING ls_dd02v TO <ls_dd02_text>.

    ENDLOOP.

    SORT lt_i18n_langs ASCENDING.
    SORT lt_dd02_texts BY ddlanguage ASCENDING.

    IF lines( lt_i18n_langs ) > 0.
      io_xml->add( iv_name = 'I18N_LANGS'
                   ig_data = lt_i18n_langs ).

      io_xml->add( iv_name = 'DD02_TEXTS'
                   ig_data = lt_dd02_texts ).
    ENDIF.

  ENDMETHOD.