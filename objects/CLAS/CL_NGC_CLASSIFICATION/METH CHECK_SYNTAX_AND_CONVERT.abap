  METHOD check_syntax_and_convert.

* This method calls CTCV_SYNTAX_CHECK fm to execute validations on the format of input value.
* If we assign a new value, the FM is called, but if we remove a value assignment, the FM is not called.
* In the method interface the NGCT_VALUATION_DATA_UPD type is used which contains the object state.
* In OBJECT_STATE field we indicate if the row is for a value assignment (CREATE, 'C'), or a deletion ('D').
* This type is used in this special manner in this case, because only object states CREATED and DELETED are used.
* The other object states (Loaded, Updated) are not used in this method.

    DATA:
      lo_clf_api_result TYPE REF TO cl_ngc_clf_api_result,
      lt_charcvalues    TYPE STANDARD TABLE OF strg,
      lr_value_change   TYPE REF TO ngcs_valuation_charcvalue_chg,
      lv_subrc          TYPE syst_subrc.

    FIELD-SYMBOLS:
      <ls_value_change> TYPE ngcs_valuation_charcvalue_chg.

    CLEAR: et_valuation_data, eo_clf_api_result.

    lo_clf_api_result = NEW cl_ngc_clf_api_result( ).

    mo_ngc_util->get_number_separator_signs(
      IMPORTING
        ev_decimal_sign = DATA(lv_decimal_sign) ).

    mo_ngc_util->get_clf_user_params(
      IMPORTING
        es_clf_user_params = DATA(ls_clf_user_params)
    ).

    IF is_value_change-charcvaluenew IS NOT INITIAL.
      mo_ngc_util->ctcv_syntax_check(
        EXPORTING
          attribut                  = is_charc_header-characteristic
          baseunit                  = COND #( WHEN is_charc_header-charcdatatype = if_ngc_c=>gc_charcdatatype-num
                                              THEN is_charc_header-charcvalueunit
                                              ELSE is_charc_header-currency )
          decimals                  = is_charc_header-charcdecimals
          dec_presentation          = lv_decimal_sign
          exponent                  = is_charc_header-charcexponentvalue
          exponent_art              = is_charc_header-charcexponentformat
          format                    = is_charc_header-charcdatatype
          interval                  = is_charc_header-valueintervalisallowed
          language                  = COND #( WHEN ls_clf_user_params-langu IS NOT INITIAL
                                              THEN ls_clf_user_params-langu
                                              ELSE sy-langu )
          length                    = is_charc_header-charclength
          lowercase                 = is_charc_header-valueiscasesensitive
          mask                      = is_charc_header-charctemplate
*         MASK_ALLOWED              = ' '
          negativ                   = is_charc_header-negativevalueisallowed
          screen_name               = 'RCTMS-MWERT'
          single_selection          = boolc( is_charc_header-multiplevaluesareallowed = abap_false )
          string                    = is_value_change-charcvaluenew
*         VALUE_SEPERATOR           = ';'
          classtype                 = is_value_change-classtype
*         T_SEPARATOR               = ' '
*         ERR_NAME                  =
        IMPORTING
*          string_is_masked =
          tstrg                     = lt_charcvalues
          sy_subrc                  = lv_subrc
      ).

      IF lv_subrc <> 0.
        CREATE DATA lr_value_change.
        ASSIGN lr_value_change->* TO <ls_value_change>.

        <ls_value_change> = is_value_change.

        lo_clf_api_result->add_message_from_sy( is_classification_key = me->ms_classification_key
                                                ir_ref_key            = lr_value_change
                                                iv_ref_type           = 'ngcs_valuation_charcvalue_chg' ).
        eo_clf_api_result = lo_clf_api_result.
        RETURN.
      ENDIF.

      ASSERT lines( lt_charcvalues ) = 1.


      LOOP AT lt_charcvalues ASSIGNING FIELD-SYMBOL(<ls_charcvalue>).
        APPEND INITIAL LINE TO et_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
*       <ls_valuation_data>-clfnobjectid              - calculated later, in private API -> TODO: Where?
        <ls_valuation_data>-clfnobjectid              = me->ms_classification_key-object_key.
        <ls_valuation_data>-charcinternalid           = is_charc_header-charcinternalid.
*       <ls_valuation_data>-charcvaluepositionnumber  - calculated later
        <ls_valuation_data>-clfnobjecttype            = if_ngc_c=>gc_clf_object_class_indicator-object.
        <ls_valuation_data>-classtype                 = is_value_change-classtype.
*       <ls_valuation_data>-timeintervalnumber        - calculated later
        <ls_valuation_data>-charcvalue                = <ls_charcvalue>-atwrt.
        <ls_valuation_data>-charcvaluedependency      = <ls_charcvalue>-atcod.

        " this is needed because CTCV_SYNTAX_CHECK returns the value in ATFLV even if the
        " relational sign is < or <=, which means the value should be in ATFLB !
        " (Discovered in include LCTMSF27, line 148 - 155.)
        IF <ls_valuation_data>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt    " <
          OR <ls_valuation_data>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le. " <=
          <ls_valuation_data>-charcfromnumericvalue     = <ls_charcvalue>-atflb.
          <ls_valuation_data>-charcfromnumericvalueunit = <ls_charcvalue>-awe2i.
          <ls_valuation_data>-charctonumericvalue       = <ls_charcvalue>-atflv.
          <ls_valuation_data>-charctonumericvalueunit   = <ls_charcvalue>-awe1i.
        ELSE.
          <ls_valuation_data>-charcfromnumericvalue     = <ls_charcvalue>-atflv.
          <ls_valuation_data>-charcfromnumericvalueunit = <ls_charcvalue>-awe1i.
          <ls_valuation_data>-charctonumericvalue       = <ls_charcvalue>-atflb.
          <ls_valuation_data>-charctonumericvalueunit   = <ls_charcvalue>-awe2i.
        ENDIF.

        <ls_valuation_data>-characteristicauthor      = <ls_charcvalue>-ataut.
*       <ls_valuation_data>-changenumber              - change numbers are not supported yet
*       <ls_valuation_data>-validitystartdate         - leave it empty, we modify only without CN
        <ls_valuation_data>-ismarkedfordeletion       = abap_false.
        <ls_valuation_data>-validityenddate           = if_ngc_c=>gc_date_max.
*       <ls_valuation_data>-charcfromdecimalvalue     - calculated by BAdI
*       <ls_valuation_data>-charctodecimalvalue       - calculated by BAdI
*       <ls_valuation_data>-charcfromamount           - calculated by BAdI
*       <ls_valuation_data>-charctoamount             - calculated by BAdI
*       <ls_valuation_data>-currency                  - calculated by BAdI
*       <ls_valuation_data>-charcfromdate             - calculated by BAdI
*       <ls_valuation_data>-charctodate               - calculated by BAdI
*       <ls_valuation_data>-charcfromtime             - calculated by BAdI
*       <ls_valuation_data>-charctotime               - calculated by BAdI
      ENDLOOP.
    ELSE.
      APPEND INITIAL LINE TO et_valuation_data ASSIGNING <ls_valuation_data>.
*     <ls_valuation_data>-clfnobjectid              - calculated later, in private API -> TODO: Where?
      <ls_valuation_data>-clfnobjectid              = me->ms_classification_key-object_key.
      <ls_valuation_data>-charcinternalid           = is_charc_header-charcinternalid.
*     <ls_valuation_data>-charcvaluepositionnumber  - calculated later
      <ls_valuation_data>-clfnobjecttype            = if_ngc_c=>gc_clf_object_class_indicator-object.
      <ls_valuation_data>-classtype                 = is_value_change-classtype.
*     <ls_valuation_data>-timeintervalnumber        - calculated later
*     <ls_valuation_data>-charcvalue                - not needed here (initial)
*     <ls_valuation_data>-charcfromnumericvalue     - not needed here
*     <ls_valuation_data>-charcfromnumericvalueunit - not needed here
*     <ls_valuation_data>-charctonumericvalue       - not needed here
*     <ls_valuation_data>-charctonumericvalueunit   - not needed here
*     <ls_valuation_data>-charcvaluedependency      - not needed here
*     <ls_valuation_data>-characteristicauthor      - not needed here
*     <ls_valuation_data>-changenumber              - change numbers are not supported yet
*     <ls_valuation_data>-validitystartdate         - leave it empty, we modify only without CN
      <ls_valuation_data>-ismarkedfordeletion       = abap_false.
      <ls_valuation_data>-validityenddate           = if_ngc_c=>gc_date_max.
*     <ls_valuation_data>-charcfromdecimalvalue     - calculated by BAdI
*     <ls_valuation_data>-charctodecimalvalue       - calculated by BAdI
*     <ls_valuation_data>-charcfromamount           - calculated by BAdI
*     <ls_valuation_data>-charctoamount             - calculated by BAdI
*     <ls_valuation_data>-currency                  - calculated by BAdI
*     <ls_valuation_data>-charcfromdate             - calculated by BAdI
*     <ls_valuation_data>-charctodate               - calculated by BAdI
*     <ls_valuation_data>-charcfromtime             - calculated by BAdI
*     <ls_valuation_data>-charctotime               - calculated by BAdI
    ENDIF.

  ENDMETHOD.