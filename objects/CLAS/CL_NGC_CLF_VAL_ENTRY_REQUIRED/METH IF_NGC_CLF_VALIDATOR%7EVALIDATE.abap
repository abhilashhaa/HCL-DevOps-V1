METHOD if_ngc_clf_validator~validate.

*--------------------------------------------------------------------*
* Checking whether the valuation of the characteristic is required
* Warning message issued
*--------------------------------------------------------------------*

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  " Get updated data from validation data provider
  io_classification->get_updated_data(
    IMPORTING
      et_valuation_data_upd      = DATA(lt_valuation_data_upd)
      et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

  LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>).
    <ls_assigned_classes_upd>-class_object->get_characteristics(
      IMPORTING
        et_characteristic          = DATA(lt_characteristic)
    ).
    LOOP AT lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>).
      DATA(ls_characteristic_header) = <ls_characteristic>-characteristic_object->get_header( ).
      IF ls_characteristic_header-entryisrequired EQ abap_true.
        READ TABLE lt_valuation_data_upd TRANSPORTING NO FIELDS
        WITH KEY charcinternalid = ls_characteristic_header-charcinternalid.
        IF sy-subrc NE 0.
          " Warning message: No value was assigned to "&"
          MESSAGE w015(ngc_api_base) WITH ls_characteristic_header-charcdescription INTO DATA(lv_msg) ##NEEDED.
          lo_clf_api_result->add_message_from_sy(
            is_classification_key = io_classification->get_classification_key( )
          ).
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDLOOP.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.