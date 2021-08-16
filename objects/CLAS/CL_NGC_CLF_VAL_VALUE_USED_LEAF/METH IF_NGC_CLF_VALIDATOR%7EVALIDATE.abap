METHOD if_ngc_clf_validator~validate.

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  io_data_provider->get_classtype_node_or_leaf(
    EXPORTING
      iv_classtype                 = iv_classtype
    IMPORTING
      ev_is_node                   = DATA(lv_is_node)
      et_child_classification_key  = DATA(lt_child_classification_key)
  ).

  IF lv_is_node = abap_false OR lt_child_classification_key IS INITIAL.
    ro_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

  io_classification->get_updated_data(
    IMPORTING
      et_valuation_data_upd = DATA(lt_valuation_data_upd) ).

  " Check if removed value is already used in leaf objects
  LOOP AT lt_valuation_data_upd ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>)
    WHERE classtype    = iv_classtype
      AND object_state = if_ngc_c=>gc_object_state-deleted.
    LOOP AT lt_child_classification_key ASSIGNING FIELD-SYMBOL(<ls_child_classification_key>).
      mo_ngc_api_factory->get_api( )->if_ngc_clf_api_read~read(
        EXPORTING
          it_classification_key    = VALUE #( ( <ls_child_classification_key> ) )
        IMPORTING
          et_classification_object = DATA(lt_child_classification_obj)
          eo_clf_api_result        = DATA(lo_clf_api_result_tmp)
      ).
      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
      READ TABLE lt_child_classification_obj ASSIGNING FIELD-SYMBOL(<ls_child_classification_obj>) INDEX 1.
      <ls_child_classification_obj>-classification->get_assigned_values(
        EXPORTING
          iv_classtype      = iv_classtype
        IMPORTING
          et_valuation_data = DATA(lt_child_valuation_data)
          eo_clf_api_result = lo_clf_api_result_tmp
      ).
      lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
      READ TABLE lt_child_valuation_data WITH KEY charcvalue = <ls_valuation_data_upd>-charcvalue
        ASSIGNING FIELD-SYMBOL(<ls_child_valuation_data>).
      IF sy-subrc = 0.
        <ls_child_classification_obj>-classification->get_characteristics(
          EXPORTING
            iv_classtype       = iv_classtype
            iv_charcinternalid = <ls_child_valuation_data>-charcinternalid
          IMPORTING
            et_characteristic  = DATA(lt_characteristic)
            eo_clf_api_result  = lo_clf_api_result_tmp
        ).
        lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).
        READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>) WITH KEY charcinternalid = <ls_child_valuation_data>-charcinternalid.
        MESSAGE e025(ngc_api_base) WITH <ls_characteristic>-characteristic_object->get_header( )-charcdescription <ls_child_valuation_data>-charcvalue INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy(
          is_classification_key = io_classification->get_classification_key( )
        ).
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.