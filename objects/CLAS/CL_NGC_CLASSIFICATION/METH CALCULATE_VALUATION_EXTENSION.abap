  METHOD calculate_valuation_extension.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      ls_valuation_data TYPE ngcs_valuation_data.

    CLEAR: eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    me->if_ngc_classification~get_characteristics(
      IMPORTING
        et_characteristic = DATA(lt_characteristic)
        eo_clf_api_result = DATA(lo_clf_api_result_tmp) ).

    lo_clf_api_result->add_messages_from_api_result( lo_clf_api_result_tmp ).

    IF mv_valuation_hash_table IS NOT INITIAL.
      LOOP AT mt_valuation_data_h ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
        READ TABLE lt_characteristic ASSIGNING FIELD-SYMBOL(<ls_characteristic>)
          WITH KEY classtype       = <ls_valuation_data>-classtype
                   charcinternalid = <ls_valuation_data>-charcinternalid.
        IF sy-subrc <> 0.
          IF 1 = 2. ENDIF.
        ENDIF.
        DATA(ls_characteristic_header) = <ls_characteristic>-characteristic_object->get_header( ).
        MOVE-CORRESPONDING <ls_valuation_data> TO ls_valuation_data.
        mo_clf_util_valuation->calculate_valuation_extension(
          EXPORTING
            is_characteristic_header = ls_characteristic_header
          CHANGING
            cs_valuation_data        = ls_valuation_data
        ).
        <ls_valuation_data>-charcfromdecimalvalue = ls_valuation_data-charcfromdecimalvalue.
        <ls_valuation_data>-charctodecimalvalue   = ls_valuation_data-charctodecimalvalue.
        <ls_valuation_data>-charcfromamount       = ls_valuation_data-charcfromamount.
        <ls_valuation_data>-charctoamount         = ls_valuation_data-charctoamount.
        <ls_valuation_data>-charcfromdate         = ls_valuation_data-charcfromdate.
        <ls_valuation_data>-charctodate           = ls_valuation_data-charctodate.
        <ls_valuation_data>-charcfromtime         = ls_valuation_data-charcfromtime.
        <ls_valuation_data>-charctotime           = ls_valuation_data-charctotime.
      ENDLOOP.
    ELSE.
      LOOP AT mt_valuation_data ASSIGNING <ls_valuation_data>.
        READ TABLE lt_characteristic ASSIGNING <ls_characteristic>
          WITH KEY classtype       = <ls_valuation_data>-classtype
                   charcinternalid = <ls_valuation_data>-charcinternalid.
        IF sy-subrc <> 0.
          IF 1 = 2. ENDIF.
        ENDIF.
        ls_characteristic_header = <ls_characteristic>-characteristic_object->get_header( ).
        MOVE-CORRESPONDING <ls_valuation_data> TO ls_valuation_data.
        mo_clf_util_valuation->calculate_valuation_extension(
          EXPORTING
            is_characteristic_header = ls_characteristic_header
          CHANGING
            cs_valuation_data        = ls_valuation_data
        ).
        MOVE-CORRESPONDING ls_valuation_data TO <ls_valuation_data>.
      ENDLOOP.
    ENDIF.

    eo_clf_api_result = lo_clf_api_result.

  ENDMETHOD.