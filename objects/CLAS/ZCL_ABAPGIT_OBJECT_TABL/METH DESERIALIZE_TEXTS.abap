  METHOD deserialize_texts.

    DATA: lv_name       TYPE ddobjname,
          ls_dd02v_tmp  TYPE dd02v,
          lt_i18n_langs TYPE TABLE OF langu,
          lt_dd02_texts TYPE tt_dd02_texts.

    FIELD-SYMBOLS: <lv_lang>      LIKE LINE OF lt_i18n_langs,
                   <ls_dd02_text> LIKE LINE OF lt_dd02_texts.

    lv_name = ms_item-obj_name.

    io_xml->read( EXPORTING iv_name = 'I18N_LANGS'
                  CHANGING  cg_data = lt_i18n_langs ).

    io_xml->read( EXPORTING iv_name = 'DD02_TEXTS'
                  CHANGING  cg_data = lt_dd02_texts ).

    SORT lt_i18n_langs.
    SORT lt_dd02_texts BY ddlanguage. " Optimization

    LOOP AT lt_i18n_langs ASSIGNING <lv_lang>.

      " Table description
      ls_dd02v_tmp = is_dd02v.
      READ TABLE lt_dd02_texts ASSIGNING <ls_dd02_text> WITH KEY ddlanguage = <lv_lang>.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |DD02_TEXTS cannot find lang { <lv_lang> } in XML| ).
      ENDIF.
      MOVE-CORRESPONDING <ls_dd02_text> TO ls_dd02v_tmp.
      CALL FUNCTION 'DDIF_TABL_PUT'
        EXPORTING
          name              = lv_name
          dd02v_wa          = ls_dd02v_tmp
        EXCEPTIONS
          tabl_not_found    = 1
          name_inconsistent = 2
          tabl_inconsistent = 3
          put_failure       = 4
          put_refused       = 5
          OTHERS            = 6.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |error from DDIF_TABL_PUT @TEXTS, { sy-subrc }| ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.