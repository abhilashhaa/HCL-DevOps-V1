METHOD if_ngc_clf_validator~validate.

**********************************************************************
* This validation is about checking MULTIPLECLASSISALLOWED field of class type
* customizing (data type MEHRFACHKL).
* Documentation:
* Indicator: multiple classification
* Indicator defining that objects can be allocated to several classes within a class type
* Only class assignments (creations) are checked.
**********************************************************************

  DATA:
    lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
    lv_assigned_class TYPE boole_d,
    lv_new_class      TYPE clint,
    lt_new_class      TYPE STANDARD TABLE OF clint,
    lr_class_key      TYPE REF TO ngcs_class_key.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  DATA(ls_classification_key) = io_classification->get_classification_key( ).

* This check is only relevant if multiple classification is disabled
  DATA(ls_classtype) = mo_clf_persistency->read_classtype( iv_clfnobjecttable = ls_classification_key-technical_object
                                                           iv_classtype       = iv_classtype ).
  IF ls_classtype-multipleclassisallowed = abap_true.
    ro_clf_api_result = lo_clf_api_result.
    RETURN.
  ENDIF.

* Get updated data from validation data provider
  io_classification->get_updated_data( IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                                                 et_assigned_class_upd      = DATA(lt_assigned_classes_upd) ).

* Get the number of all the assigned classes for this class type
  LOOP AT lt_assigned_classes_upd ASSIGNING FIELD-SYMBOL(<ls_assigned_classes_upd>).

    " Class header is needed to get the class type
    DATA(ls_class_header) = <ls_assigned_classes_upd>-class_object->get_header( ).

    " Check only the supplied class type
    IF ls_class_header-classtype <> iv_classtype.
      CONTINUE.
    ENDIF.

    IF <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-loaded.
      lv_assigned_class = abap_true.
    ELSEIF  <ls_assigned_classes_upd>-object_state = if_ngc_c=>gc_object_state-created.
      IF lv_new_class IS INITIAL.
        lv_new_class = <ls_assigned_classes_upd>-classinternalid.
      ELSE.
        APPEND <ls_assigned_classes_upd>-classinternalid TO lt_new_class.
      ENDIF.
    ENDIF.
  ENDLOOP.

  IF lv_assigned_class = abap_true AND lv_new_class IS NOT INITIAL.
    APPEND lv_new_class TO lt_new_class.
  ENDIF.

  IF lt_new_class IS NOT INITIAL.

    " Remove those surpluss classes which were newly assigned - these should not be there
    LOOP AT lt_new_class INTO lv_new_class.

      " Fill class key as dynamic field and add to API results
      CREATE DATA lr_class_key.
      ASSIGN lr_class_key->* TO FIELD-SYMBOL(<ls_class_key>).
      <ls_class_key>-classinternalid = lv_new_class.

      " Error handling: Multiple classification is not allowed for class type &1
      MESSAGE e005(ngc_api_base) WITH iv_classtype INTO DATA(lv_msg) ##NEEDED.
      lo_clf_api_result->add_message_from_sy( is_classification_key = ls_classification_key
                                              ir_ref_key            = lr_class_key
                                              iv_ref_type           = 'ngcs_class_key' ).

      " remove data from updated data list
      DELETE lt_assigned_classes_upd  WHERE classinternalid = lv_new_class."INDEX lv_class_idx.
      DELETE lt_classification_data_upd WHERE classinternalid = lv_new_class.."INDEX lv_class_idx.

    ENDLOOP.

    " Set the updated data
    io_data_provider->set_updated_data( it_classification_data_upd = lt_classification_data_upd
                                        it_assigned_class_upd      = lt_assigned_classes_upd ).
  ENDIF.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.