METHOD update.

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.
**********************************************************************
*    lt_core_classification_upd TYPE ngct_core_classification_upd,
*    lt_core_class_key          TYPE ngct_core_class_key.
**********************************************************************

  CLEAR: eo_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

**********************************************************************
*  LOOP AT it_classification_object ASSIGNING FIELD-SYMBOL(<ls_classification_object>).
*
*    APPEND INITIAL LINE TO lt_core_classification_upd ASSIGNING FIELD-SYMBOL(<ls_core_classification_upd>).
*
*    DATA(ls_classification_key) = <ls_classification_object>-classification->get_classification_key( ).
*    <ls_core_classification_upd>-object_key       = ls_classification_key-object_key.
*    <ls_core_classification_upd>-technical_object = ls_classification_key-technical_object.
*    <ls_core_classification_upd>-change_number    = ls_classification_key-change_number.
*    <ls_core_classification_upd>-key_date         = ls_classification_key-key_date.
*
*    <ls_classification_object>-classification->get_updated_data(
*      IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
*                et_valuation_data_upd      = DATA(lt_valuation_data_upd) ).
*
*    <ls_classification_object>-classification->get_characteristics(
*      IMPORTING
*        et_characteristic = DATA(lt_characteristic) ).
*
*    LOOP AT lt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>).
*      APPEND VALUE
*        ngcs_core_class_key(
*          classinternalid = <ls_classification_data_upd>-classinternalid
*          key_date        = <ls_classification_object>-key_date
*        ) TO lt_core_class_key.
*    ENDLOOP.
*
*    LOOP AT lt_classification_data_upd ASSIGNING <ls_classification_data_upd>
*      WHERE object_state <> if_ngc_c=>gc_object_state-loaded.
*      APPEND INITIAL LINE TO <ls_core_classification_upd>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classif_obj_data_upd>).
*      MOVE-CORRESPONDING <ls_classification_data_upd> TO <ls_classif_obj_data_upd>.
*    ENDLOOP.
*
*    LOOP AT lt_valuation_data_upd INTO DATA(ls_valuation_data_upd)
*      WHERE object_state <> if_ngc_c=>gc_object_state-loaded.
*
*      APPEND INITIAL LINE TO <ls_core_classification_upd>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_classif_val_data_upd>).
*      MOVE-CORRESPONDING ls_valuation_data_upd TO <ls_classif_val_data_upd>.
*
*      " because of deletions in valuation data, it is possible that LT_CHARACTERISTIC does not contain the characteristic
*      READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>) WITH KEY charcinternalid = ls_valuation_data_upd-charcinternalid.
*      IF sy-subrc = 0.
*        IF <ls_characteristic>-characteristic_object->get_header( )-charcdatatype <> if_ngc_c=>gc_charcdatatype-char.
*          <ls_classif_val_data_upd>-charcvalue = ''.
*        ENDIF.
*      ENDIF.
*    ENDLOOP.
*
*  ENDLOOP.
*
*  mo_cls_persistency->read_by_internal_key(
*    EXPORTING it_keys                  = lt_core_class_key
*              iv_lock                  = abap_false
*    IMPORTING et_classes               = DATA(lt_core_class)
*              et_message               = DATA(lt_cls_core_message) ).
*
*  cl_ngc_util_message=>convert_msg_corecls_to_coreclf(
*    EXPORTING it_core_class_msg          = lt_cls_core_message
*    IMPORTING et_core_classification_msg = DATA(lt_clf_core_message) ).
*
*  lo_clf_api_result->add_messages_from_core_clf( lt_clf_core_message ).
**********************************************************************

  get_updated_data(
    EXPORTING
      it_classification_object   = it_classification_object
    IMPORTING
      et_core_classification_upd = DATA(lt_core_classification_upd)
      et_core_class              = DATA(lt_core_class)
      et_clf_core_message        = DATA(lt_clf_core_message) ).

  mo_clf_persistency->write(
    EXPORTING it_classification = lt_core_classification_upd
              it_class          = lt_core_class
    IMPORTING et_message        = lt_clf_core_message ).

  lo_clf_api_result->add_messages_from_core_clf( lt_clf_core_message ).

  eo_clf_api_result = lo_clf_api_result.

ENDMETHOD.