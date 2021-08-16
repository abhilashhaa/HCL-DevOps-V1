  METHOD get_updated_data.

    DATA:
      lt_core_class_key    TYPE ngct_core_class_key,
      lv_save_charc_values TYPE boole_d VALUE abap_true.

    CLEAR: et_core_classification_upd, et_core_class, et_clf_core_message.

    LOOP AT it_classification_object ASSIGNING FIELD-SYMBOL(<ls_classification_object>).

      APPEND INITIAL LINE TO et_core_classification_upd ASSIGNING FIELD-SYMBOL(<ls_core_classification_upd>).

      DATA(ls_classification_key) = <ls_classification_object>-classification->get_classification_key( ).
      <ls_core_classification_upd>-object_key       = ls_classification_key-object_key.
      <ls_core_classification_upd>-technical_object = ls_classification_key-technical_object.
      <ls_core_classification_upd>-change_number    = ls_classification_key-change_number.
      <ls_core_classification_upd>-key_date         = ls_classification_key-key_date.

      <ls_classification_object>-classification->get_updated_data(
        IMPORTING et_classification_data_upd = DATA(lt_classification_data_upd)
                  et_valuation_data_upd      = DATA(lt_valuation_data_upd) ).

      <ls_classification_object>-classification->get_characteristics(
        IMPORTING
          et_characteristic = DATA(lt_characteristic) ).

      LOOP AT lt_classification_data_upd ASSIGNING FIELD-SYMBOL(<ls_classification_data_upd>).
        APPEND VALUE
          ngcs_core_class_key(
            classinternalid = <ls_classification_data_upd>-classinternalid
            key_date        = <ls_classification_object>-key_date
          ) TO lt_core_class_key.
      ENDLOOP.

      LOOP AT lt_classification_data_upd ASSIGNING <ls_classification_data_upd>
        WHERE object_state <> if_ngc_c=>gc_object_state-loaded.
        APPEND INITIAL LINE TO <ls_core_classification_upd>-classification_data ASSIGNING FIELD-SYMBOL(<ls_classif_obj_data_upd>).
        MOVE-CORRESPONDING <ls_classification_data_upd> TO <ls_classif_obj_data_upd>.
      ENDLOOP.

      LOOP AT lt_valuation_data_upd INTO DATA(ls_valuation_data_upd)
        WHERE object_state <> if_ngc_c=>gc_object_state-loaded.

        " Valuation data should not be written to database, if
        " all of the following are true:
        "   1. Redundancy flag is false in customizing.
        "   2. Charc. is ref. charc. according to master data.
        "   3. Charc. is ref. charc. according to classification data
        "      (reference data was set for the same fiels as in the characteristic).
        " Otherwise valuation data should be written to the database.
        " 1. Redundancy flag check.
        DATA(lv_charcredundantstorisallowed) = mo_clf_persistency->read_classtype_objtype_redun(
          iv_classtype       = ls_valuation_data_upd-classtype
          iv_clfnobjecttable = <ls_classification_object>-technical_object
        ).
        IF lv_charcredundantstorisallowed = abap_false.
          " 2. Ref. charc. in master data.
          " Because of deletions in classification data, it is possible that LT_CHARACTERISTIC does not contain the characteristic.
          " (But in this case we need to put the deletions to <ls_core_classification_upd>-valuation_data.)
          ASSIGN lt_characteristic[ charcinternalid = ls_valuation_data_upd-charcinternalid ] TO FIELD-SYMBOL(<ls_characteristic>).
          IF sy-subrc = 0.
            DATA(lt_characteristic_ref) = <ls_characteristic>-characteristic_object->get_characteristic_ref( ).
            IF lt_characteristic_ref IS NOT INITIAL.
              " 3. Ref. charc. according to the classification.
              lv_save_charc_values = abap_true.
              LOOP AT lt_characteristic_ref ASSIGNING FIELD-SYMBOL(<ls_characteristic_ref>).
                DATA(lr_ref_data) = <ls_classification_object>-classification->get_reference_data( <ls_characteristic_ref>-charcreferencetable ).
                IF lr_ref_data IS BOUND.
                  " We need to skip saving of characteristic values.
                  lv_save_charc_values = abap_false.
                  EXIT.
                ENDIF.
              ENDLOOP.
            ENDIF.
          ENDIF.
        ENDIF.

        " In this case we dont fill <ls_core_classification_upd>-valuation_data with the valuation data.
        IF lv_save_charc_values = abap_false.
          CONTINUE.
        ENDIF.

        APPEND INITIAL LINE TO <ls_core_classification_upd>-valuation_data ASSIGNING FIELD-SYMBOL(<ls_classif_val_data_upd>).
        MOVE-CORRESPONDING ls_valuation_data_upd TO <ls_classif_val_data_upd>.

        " Because of deletions in classification data, it is possible that LT_CHARACTERISTIC does not contain the characteristic.
        ASSIGN lt_characteristic[ charcinternalid = ls_valuation_data_upd-charcinternalid ] TO <ls_characteristic>.
        IF sy-subrc = 0.
          IF <ls_characteristic>-characteristic_object->get_header( )-charcdatatype <> if_ngc_c=>gc_charcdatatype-char.
            <ls_classif_val_data_upd>-charcvalue = ''.
          ENDIF.
        ENDIF.
      ENDLOOP.

    ENDLOOP.

    mo_cls_persistency->read_by_internal_key(
      EXPORTING it_keys                  = lt_core_class_key
                iv_lock                  = abap_false
      IMPORTING et_classes               = et_core_class
                et_message               = DATA(lt_cls_core_message) ).

    cl_ngc_util_message=>convert_msg_corecls_to_coreclf(
      EXPORTING it_core_class_msg          = lt_cls_core_message
      IMPORTING et_core_classification_msg = et_clf_core_message ).

  ENDMETHOD.