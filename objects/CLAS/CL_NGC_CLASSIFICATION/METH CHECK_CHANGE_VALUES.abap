  METHOD check_change_values.

    DATA:
      lo_clf_api_result      TYPE REF TO cl_ngc_clf_api_result,
      lt_charchassinglevalue TYPE ngct_clf_characteristic_key,
      lt_charcmultivalue     TYPE ngct_valuation_charcvalue_chgi.

    CLEAR: et_success_index, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    " check if charc is assigned
    me->if_ngc_classification~get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_assigned_characteristic)
        eo_clf_api_result = DATA(lo_clf_api_result_tmp) ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    LOOP AT ct_change_value_i ASSIGNING FIELD-SYMBOL(<ls_change_value>).

      DATA(lv_index) = sy-tabix.

*--------------------------------------------------------------------*

      READ TABLE lt_assigned_characteristic ASSIGNING FIELD-SYMBOL(<ls_assigned_characteristic>)
        WITH KEY classtype       = <ls_change_value>-classtype
                 charcinternalid = <ls_change_value>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.
      IF sy-subrc <> 0.
        " Error: Characteristic & not found or not valid
        " (Similar to C1/003)
        MESSAGE e010(ngc_api_base) WITH <ls_change_value>-charcinternalid INTO DATA(lv_msg) ##NEEDED.
        lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
        DELETE ct_change_value_i INDEX lv_index.
        CONTINUE.
      ENDIF.

*--------------------------------------------------------------------*

      DATA(ls_charc_header) = <ls_assigned_characteristic>-characteristic_object->get_header( ).

      " Check multiple value assignment
      IF ls_charc_header-multiplevaluesareallowed = abap_false.
        DATA(lv_error) = abap_false.
        READ TABLE lt_charchassinglevalue TRANSPORTING NO FIELDS
        WITH KEY classtype       = <ls_change_value>-classtype
                 charcinternalid = <ls_change_value>-charcinternalid
                 key_date        = me->ms_classification_key-key_date.
        IF sy-subrc <> 0.
          lt_charcmultivalue = ct_change_value_i.
          DELETE lt_charcmultivalue
          WHERE NOT ( classtype = <ls_change_value>-classtype
          AND   charcinternalid = <ls_change_value>-charcinternalid ).
          IF lines( lt_charcmultivalue ) > 1.
            " add charcteristic entry to track further values
            DATA(ls_charchassinglevalue) = VALUE ngcs_clf_characteristic_key( classtype       = <ls_change_value>-classtype
                                                                              charcinternalid = <ls_change_value>-charcinternalid
                                                                              key_date        = me->ms_classification_key-key_date ).
            APPEND ls_charchassinglevalue TO lt_charchassinglevalue.
            " issue error message and skip
            lv_error = abap_true.
          ENDIF.
        ELSE.
          " in case of further values: issue error message and skip
          lv_error = abap_true.
        ENDIF.
        IF lv_error EQ abap_true.
          " issue error message: Only one value allowed for "&"
          MESSAGE e017(ngc_api_base) WITH ls_charc_header-characteristic INTO lv_msg ##NEEDED.
          lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
          DELETE ct_change_value_i INDEX lv_index.
          CONTINUE.
        ENDIF.
      ENDIF.

      IF mv_skip_checks_for_ref_charc = abap_false.
        " Check whether the characteristic is readonly
        IF ls_charc_header-charcisreadonly = abap_true.
          MESSAGE e013(ngc_api_base) WITH ls_charc_header-characteristic INTO lv_msg ##NEEDED.
          lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
          DELETE ct_change_value_i INDEX lv_index.
          CONTINUE.
        ENDIF.

        " Check whether it is a reference characteristic
        IF ls_charc_header-charcreferencetable IS NOT INITIAL
        AND  ls_charc_header-charcreferencetablefield IS NOT INITIAL.
          READ TABLE mt_reference_data TRANSPORTING NO FIELDS
          WITH KEY charcreferencetable = ls_charc_header-charcreferencetable.
          IF sy-subrc = 0.
            MESSAGE e020(ngc_api_base) WITH ls_charc_header-characteristic INTO lv_msg ##NEEDED.
            lo_clf_api_result->add_message_from_sy( me->ms_classification_key ).
            DELETE ct_change_value_i INDEX lv_index.
            CONTINUE.
          ENDIF.
        ENDIF.
      ENDIF.

      APPEND lv_index TO et_success_index.

    ENDLOOP.

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.