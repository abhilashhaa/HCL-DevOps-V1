  METHOD deserialize_texts.

    DATA: lv_name       TYPE ddobjname,
          ls_dd04v_tmp  TYPE dd04v,
          lt_i18n_langs TYPE TABLE OF langu,
          lt_dd04_texts TYPE tt_dd04_texts.

    FIELD-SYMBOLS: <lv_lang>      LIKE LINE OF lt_i18n_langs,
                   <ls_dd04_text> LIKE LINE OF lt_dd04_texts.


    lv_name = ms_item-obj_name.

    ii_xml->read( EXPORTING iv_name = 'I18N_LANGS'
                  CHANGING  cg_data = lt_i18n_langs ).

    ii_xml->read( EXPORTING iv_name = 'DD04_TEXTS'
                  CHANGING  cg_data = lt_dd04_texts ).

    SORT lt_i18n_langs.
    SORT lt_dd04_texts BY ddlanguage. " Optimization

    LOOP AT lt_i18n_langs ASSIGNING <lv_lang>.

      " Data element description
      ls_dd04v_tmp = is_dd04v.
      READ TABLE lt_dd04_texts ASSIGNING <ls_dd04_text> WITH KEY ddlanguage = <lv_lang>.
      IF sy-subrc > 0.
        zcx_abapgit_exception=>raise( |DD04_TEXTS cannot find lang { <lv_lang> } in XML| ).
      ENDIF.
      MOVE-CORRESPONDING <ls_dd04_text> TO ls_dd04v_tmp.
      CALL FUNCTION 'DDIF_DTEL_PUT'
        EXPORTING
          name              = lv_name
          dd04v_wa          = ls_dd04v_tmp
        EXCEPTIONS
          dtel_not_found    = 1
          name_inconsistent = 2
          dtel_inconsistent = 3
          put_failure       = 4
          put_refused       = 5
          OTHERS            = 6.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |error from DDIF_DTEL_PUT @TEXTS, { sy-subrc }| ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.