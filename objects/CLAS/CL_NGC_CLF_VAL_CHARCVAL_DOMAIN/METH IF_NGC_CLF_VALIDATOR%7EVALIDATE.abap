METHOD if_ngc_clf_validator~validate.

*--------------------------------------------------------------------*
* Check if assigned characteristic value is
* in the list of valid domain values
*--------------------------------------------------------------------*

  DATA:
    lo_clf_api_result          TYPE REF TO cl_ngc_clf_api_result,
    lv_state                   TYPE string,
    ls_charc_header            TYPE ngcs_characteristic,
    lr_clf_charc_key           TYPE REF TO ngcs_clf_characteristic_key,
    lv_was_error               TYPE boole_d VALUE abap_false,
    lt_valuation_data_upd_proc TYPE ngct_valuation_data_upd, " processed valuation data
    lv_subrc                   TYPE subrc VALUE 4.

  FIELD-SYMBOLS:
    <ls_clf_charc_key> TYPE ngcs_clf_characteristic_key.

  lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

  " loaded, updated or created
  lv_state = if_ngc_c=>gc_object_state-loaded && if_ngc_c=>gc_object_state-updated && if_ngc_c=>gc_object_state-created.

  " Get updated data from validation data provider
  " Assumption: lt_valuation_data_upd is sorted by
  " clfnobjectid classtype charcinternalid charcvaluepositionnumber timeintervalnumber
  " (this is done by CL_NGC_CLASSIFICATION)
  io_classification->get_updated_data(
    IMPORTING
      et_classification_data_upd = DATA(lt_classification_data_upd)
      et_assigned_class_upd      = DATA(lt_assigned_classes_upd)
      et_valuation_data_upd      = DATA(lt_valuation_data_upd)
      et_valuation_data_prev     = DATA(lt_valuation_data_prev) ).

  io_classification->get_characteristics(
    EXPORTING
      iv_classtype       = iv_classtype
    IMPORTING
      et_characteristic  = DATA(lt_characteristic)
      eo_clf_api_result  = DATA(lo_clf_api_result_tmp)
  ).

  lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

  " Todo: check if this sort is really needed
  SORT lt_characteristic ASCENDING BY classtype charcinternalid key_date.

  " process assigned values
  " We only need those valuations which are related to this class type
  " and are with loaded, updated or created state
  LOOP AT lt_valuation_data_upd ASSIGNING FIELD-SYMBOL(<ls_valuation_data_upd>)
    WHERE classtype = iv_classtype AND object_state CA lv_state.

    " reset subrc
    lv_subrc = 4.

    " refresh ls_charc_header if needed
    IF ls_charc_header-charcinternalid <> <ls_valuation_data_upd>-charcinternalid.
      READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
        WITH KEY classtype       = iv_classtype
                 charcinternalid = <ls_valuation_data_upd>-charcinternalid
                 BINARY SEARCH.
      ASSERT sy-subrc = 0.
      ls_charc_header = <ls_characteristic>-characteristic_object->get_header( ).
    ENDIF.

    " Characteristics with values coming from:
    "  - function module
    "  - check table
    "  - catalog
    " are not checked.
    " Also if additional values are allowed, the characteristic is not checked.
    IF ls_charc_header-charccheckfunctionmodule IS NOT INITIAL OR
       ls_charc_header-charcchecktable IS NOT INITIAL OR
       ( ls_charc_header-charcselectedset IS NOT INITIAL AND
         ls_charc_header-plant IS INITIAL ) OR
       ls_charc_header-additionalvalueisallowed = abap_true.
      CONTINUE.
    ENDIF.

    " get domain values
    io_classification->get_domain_values(
      EXPORTING
        iv_classtype       = iv_classtype
        iv_charcinternalid = ls_charc_header-charcinternalid
      IMPORTING
        et_domain_value    = DATA(lt_domain_value) ).

    IF lt_domain_value IS INITIAL.
      CONTINUE.
    ENDIF.

    " for character type, the value should be one of the domain values
    IF ls_charc_header-charcdatatype = if_ngc_core_c=>gc_charcdatatype-char.
      READ TABLE lt_domain_value TRANSPORTING NO FIELDS
        WITH KEY charcvalue = <ls_valuation_data_upd>-charcvalue.
      IF sy-subrc = 0.
        lv_subrc = 0.
      ENDIF.
    ELSE.
      " for other types, check value inclusion
      check_value_inclusion(
        EXPORTING
          it_domain_value       = lt_domain_value
          is_valuation_data_upd = <ls_valuation_data_upd>
        CHANGING
          cv_subrc              = lv_subrc
      ).
    ENDIF.

    " the value is not valid -> return an error
    IF lv_subrc <> 0.
      " Fill assigned characteristic key as dynamic field and add to API results
      CREATE DATA lr_clf_charc_key.
      ASSIGN lr_clf_charc_key->* TO <ls_clf_charc_key>.
      <ls_clf_charc_key>-classtype       = iv_classtype.
      <ls_clf_charc_key>-charcinternalid = ls_charc_header-charcinternalid.

      " Error handling: Characteristic &1, value "&2" is not found
      MESSAGE e012(ngc_api_base) WITH ls_charc_header-charcdescription <ls_valuation_data_upd>-charcvalue INTO DATA(lv_msg).
      lo_clf_api_result->add_message_from_sy(
        is_classification_key = io_classification->get_classification_key( )
        ir_ref_key            = lr_clf_charc_key
        iv_ref_type           = 'ngcs_clf_characteristic_key' ).

      " change back the valuation data
      IF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-created.
        " this valuation was newly created, we can remove it
        " so we remove all the values from the resulting lt_valuation_data_upd_proc table
        " which values correspond to this characteristic and class type
        " we also delete the values of this characteristic we process from
        " the lt_valuation_data_upd table, so we won't process the values for the
        " same characteristic further
        DELETE lt_valuation_data_upd_proc
          WHERE clfnobjectid    = <ls_valuation_data_upd>-clfnobjectid
            AND charcinternalid = <ls_valuation_data_upd>-charcinternalid
            AND classtype       = <ls_valuation_data_upd>-classtype.

        DELETE lt_valuation_data_upd
          WHERE clfnobjectid    = <ls_valuation_data_upd>-clfnobjectid
            AND charcinternalid = <ls_valuation_data_upd>-charcinternalid
            AND classtype       = <ls_valuation_data_upd>-classtype.

        " we just set the error indicator
        lv_was_error = abap_true.

      ELSEIF <ls_valuation_data_upd>-object_state = if_ngc_c=>gc_object_state-updated.
        " We need to set back the value to the original one for this characteristic
        DELETE lt_valuation_data_upd_proc
          WHERE clfnobjectid    = <ls_valuation_data_upd>-clfnobjectid
            AND charcinternalid = <ls_valuation_data_upd>-charcinternalid
            AND classtype       = <ls_valuation_data_upd>-classtype.

        LOOP AT lt_valuation_data_prev ASSIGNING FIELD-SYMBOL(<ls_valuation_data_prev>)
          WHERE clfnobjectid    = <ls_valuation_data_upd>-clfnobjectid
            AND charcinternalid = <ls_valuation_data_upd>-charcinternalid
            AND classtype       = <ls_valuation_data_upd>-classtype.

          APPEND <ls_valuation_data_prev> TO lt_valuation_data_upd_proc.

        ENDLOOP.

        DELETE lt_valuation_data_upd
          WHERE clfnobjectid    = <ls_valuation_data_upd>-clfnobjectid
            AND charcinternalid = <ls_valuation_data_upd>-charcinternalid
            AND classtype       = <ls_valuation_data_upd>-classtype.

        " we set the error indicator
        lv_was_error = abap_true.
      ENDIF.

      " process next valuation
      CONTINUE.

    ELSE.
      APPEND <ls_valuation_data_upd> TO lt_valuation_data_upd_proc.
    ENDIF.
  ENDLOOP.

  " update valuation data if needed
  IF lv_was_error = abap_true.
    io_data_provider->set_updated_data( it_assigned_values = lt_valuation_data_upd_proc ).
  ENDIF.

  ro_clf_api_result = lo_clf_api_result.

ENDMETHOD.