  METHOD if_ngc_core_chr_value_check~check_value.

* This method calls CTCV_SYNTAX_CHECK fm to execute validations on the format of input value.
* If we assign a new value, the FM is called, but if we remove a value assignment, the FM is not called.
* In the method interface the NGCT_VALUATION_DATA_UPD type is used which contains the object state.
* In OBJECT_STATE field we indicate if the row is for a value assignment (CREATE, 'C'), or a deletion ('D').
* This type is used in this special manner in this case, because only object states CREATED and DELETED are used.
* The other object states (Loaded, Updated) are not used in this method.

    DATA:
      lt_charcvalues  TYPE STANDARD TABLE OF strg,
      lr_value_change TYPE REF TO ngcs_valuation_charcvalue_chg,
      lv_subrc        TYPE syst_subrc.

    FIELD-SYMBOLS:
      <ls_value_change> TYPE ngcs_valuation_charcvalue_chg.

    CLEAR: et_message.

    " Execute basic checks
    super->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = is_charc_header
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = cs_charc_value ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    mo_core_util->get_number_separator_signs(
      IMPORTING
        ev_decimal_sign = DATA(lv_decimal_sign) ).

    IF cs_charc_value-charcvalue IS NOT INITIAL.
      mo_core_util->ctcv_syntax_check(
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
          language                  = space
          length                    = is_charc_header-charclength
          lowercase                 = is_charc_header-valueiscasesensitive
          mask                      = is_charc_header-charctemplate
*         MASK_ALLOWED              = ' '
          negativ                   = is_charc_header-negativevalueisallowed
          screen_name               = 'RCTMS-MWERT'
          single_selection          = boolc( is_charc_header-multiplevaluesareallowed = abap_false )
          string                    = cs_charc_value-charcvalue
*         VALUE_SEPERATOR           = ';'
*         CLASSTYPE                 = space
*         T_SEPARATOR               = ' '
*         ERR_NAME                  =
        IMPORTING
*          string_is_masked =
          tstrg                     = lt_charcvalues
          sy_subrc                  = lv_subrc
      ).

      IF lv_subrc <> 0.
        APPEND VALUE #( charcinternalid            = is_charc_header-charcinternalid
                        overwrittencharcinternalid = is_charc_header-overwrittencharcinternalid
                        key_date                   = is_charc_header-key_date
                        msgty                      = sy-msgty
                        msgid                      = sy-msgid
                        msgno                      = sy-msgno
                        msgv1                      = sy-msgv1
                        msgv2                      = sy-msgv2
                        msgv3                      = sy-msgv3
                        msgv4                      = sy-msgv4 ) TO et_message.
        RETURN.
      ENDIF.

      ASSIGN lt_charcvalues[ 1 ] TO FIELD-SYMBOL(<ls_charcvalue>).
      cs_charc_value-charcvalue = <ls_charcvalue>-atwrt.
*
*      ASSERT lines( lt_charcvalues ) = 1.
*
*
*      LOOP AT lt_charcvalues ASSIGNING FIELD-SYMBOL(<ls_charcvalue>).
*        APPEND INITIAL LINE TO et_valuation_data ASSIGNING FIELD-SYMBOL(<ls_valuation_data>).
**       <ls_valuation_data>-clfnobjectid              - calculated later, in private API
*        <ls_valuation_data>-charcinternalid           = is_charc_header-charcinternalid.
**       <ls_valuation_data>-charcvaluepositionnumber  - calculated later
*        <ls_valuation_data>-clfnobjecttype            = if_ngc_c=>gc_clf_object_class_indicator-object.
*        <ls_valuation_data>-classtype                 = is_value_change-classtype.
**       <ls_valuation_data>-timeintervalnumber        - calculated later
*        <ls_valuation_data>-charcvalue                = <ls_charcvalue>-atwrt.
*        <ls_valuation_data>-charcvaluedependency      = <ls_charcvalue>-atcod.
*
*        " this is needed because CTCV_SYNTAX_CHECK returns the value in ATFLV even if the
*        " relational sign is < or <=, which means the value should be in ATFLB !
*        " (Discovered in include LCTMSF27, line 148 - 155.)
*        IF <ls_valuation_data>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt    " <
*          OR <ls_valuation_data>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le. " <=
*          <ls_valuation_data>-charcfromnumericvalue     = <ls_charcvalue>-atflb.
*          <ls_valuation_data>-charcfromnumericvalueunit = <ls_charcvalue>-awe2i.
*          <ls_valuation_data>-charctonumericvalue       = <ls_charcvalue>-atflv.
*          <ls_valuation_data>-charctonumericvalueunit   = <ls_charcvalue>-awe1i.
*        ELSE.
*          <ls_valuation_data>-charcfromnumericvalue     = <ls_charcvalue>-atflv.
*          <ls_valuation_data>-charcfromnumericvalueunit = <ls_charcvalue>-awe1i.
*          <ls_valuation_data>-charctonumericvalue       = <ls_charcvalue>-atflb.
*          <ls_valuation_data>-charctonumericvalueunit   = <ls_charcvalue>-awe2i.
*        ENDIF.
*
*        <ls_valuation_data>-characteristicauthor      = <ls_charcvalue>-ataut.
**       <ls_valuation_data>-changenumber              - change numbers are not supported yet
**       <ls_valuation_data>-validitystartdate         - leave it empty, we modify only without CN
*        <ls_valuation_data>-ismarkedfordeletion       = abap_false.
*        <ls_valuation_data>-validityenddate           = if_ngc_c=>gc_date_max.
**       <ls_valuation_data>-charcfromdecimalvalue     - calculated by BAdI
**       <ls_valuation_data>-charctodecimalvalue       - calculated by BAdI
**       <ls_valuation_data>-charcfromamount           - calculated by BAdI
**       <ls_valuation_data>-charctoamount             - calculated by BAdI
**       <ls_valuation_data>-currency                  - calculated by BAdI
**       <ls_valuation_data>-charcfromdate             - calculated by BAdI
**       <ls_valuation_data>-charctodate               - calculated by BAdI
**       <ls_valuation_data>-charcfromtime             - calculated by BAdI
**       <ls_valuation_data>-charctotime               - calculated by BAdI
*      ENDLOOP.
*    ELSE.
*      APPEND INITIAL LINE TO et_valuation_data ASSIGNING <ls_valuation_data>.
**     <ls_valuation_data>-clfnobjectid              - calculated later, in private API
*      <ls_valuation_data>-charcinternalid           = is_charc_header-charcinternalid.
**     <ls_valuation_data>-charcvaluepositionnumber  - calculated later
*      <ls_valuation_data>-clfnobjecttype            = if_ngc_c=>gc_clf_object_class_indicator-object.
*      <ls_valuation_data>-classtype                 = is_value_change-classtype.
**     <ls_valuation_data>-timeintervalnumber        - calculated later
**     <ls_valuation_data>-charcvalue                - not needed here (initial)
**     <ls_valuation_data>-charcfromnumericvalue     - not needed here
**     <ls_valuation_data>-charcfromnumericvalueunit - not needed here
**     <ls_valuation_data>-charctonumericvalue       - not needed here
**     <ls_valuation_data>-charctonumericvalueunit   - not needed here
**     <ls_valuation_data>-charcvaluedependency      - not needed here
**     <ls_valuation_data>-characteristicauthor      - not needed here
**     <ls_valuation_data>-changenumber              - change numbers are not supported yet
**     <ls_valuation_data>-validitystartdate         - leave it empty, we modify only without CN
*      <ls_valuation_data>-ismarkedfordeletion       = abap_false.
*      <ls_valuation_data>-validityenddate           = if_ngc_c=>gc_date_max.
**     <ls_valuation_data>-charcfromdecimalvalue     - calculated by BAdI
**     <ls_valuation_data>-charctodecimalvalue       - calculated by BAdI
**     <ls_valuation_data>-charcfromamount           - calculated by BAdI
**     <ls_valuation_data>-charctoamount             - calculated by BAdI
**     <ls_valuation_data>-currency                  - calculated by BAdI
**     <ls_valuation_data>-charcfromdate             - calculated by BAdI
**     <ls_valuation_data>-charctodate               - calculated by BAdI
**     <ls_valuation_data>-charcfromtime             - calculated by BAdI
**     <ls_valuation_data>-charctotime               - calculated by BAdI
    ENDIF.

  ENDMETHOD.