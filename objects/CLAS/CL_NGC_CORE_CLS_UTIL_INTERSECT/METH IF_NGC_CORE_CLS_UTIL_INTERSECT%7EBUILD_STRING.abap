METHOD if_ngc_core_cls_util_intersect~build_string.

*------------------------ --------------------------------------------*
* The call of CTCV_PREPARE_VALUES_TO_DISPLAY function module builds
* a string value out of the numeric values of the charc. value.
* The fields of CABN and CAWN which are left initial
* are not used in the underlying function module.
*--------------------------------------------------------------------*

  DATA:
    lv_string_too_long TYPE c LENGTH 1,
    ls_cabn            TYPE cabn,
    ls_cawn            TYPE cawn,
    ls_charc_value     TYPE ngcs_core_charc_value_data.

  CLEAR: et_core_message.

  IF cs_charc_value-charcvalue IS NOT INITIAL.
    RETURN.
  ENDIF.

  IF iv_simplify_value = abap_true.
    ls_charc_value = me->simplify_value( is_char_value = cs_charc_value ).
  ELSE.
    ls_charc_value = cs_charc_value.
  ENDIF.

  ls_cabn-mandt = sy-mandt.
  ls_cabn-atinn = iv_charcinternalid.
  ls_cabn-adzhl = is_charc_head-timeintervalnumber.
  ls_cabn-atnam = is_charc_head-characteristic.
* ls_cabn-ATIDN = IS_CHARC_HEAD- .
  ls_cabn-atfor = is_charc_head-charcdatatype.
  ls_cabn-anzst = is_charc_head-charclength.
  ls_cabn-anzdz = is_charc_head-charcdecimals.
  ls_cabn-atvor = is_charc_head-negativevalueisallowed.
  ls_cabn-atsch = is_charc_head-charctemplate.
  ls_cabn-atkle = is_charc_head-valueiscasesensitive.
* ls_cabn-ATKON = IS_CHARC_HEAD- .
  ls_cabn-atend = is_charc_head-charcisaggregating.
* ls_cabn-ATAEN = IS_CHARC_HEAD- .
  ls_cabn-atkla = is_charc_head-charcgroup.
  ls_cabn-aterf = is_charc_head-entryisrequired.
  ls_cabn-atein = COND #( WHEN is_charc_head-multiplevaluesareallowed = abap_true THEN abap_false ELSE abap_true ).
* ls_cabn-ATAME = IS_CHARC_HEAD- .
* ls_cabn-ATWME = IS_CHARC_HEAD- .
  ls_cabn-msehi = COND #( WHEN is_charc_head-charcdatatype = if_ngc_c=>gc_charcdatatype-curr THEN is_charc_head-currency ELSE is_charc_head-charcvalueunit ).
  ls_cabn-atdim = is_charc_head-charcexponentvalue.
* ls_cabn-ATGLO = IS_CHARC_HEAD- .
* ls_cabn-ATGLA = IS_CHARC_HEAD- .
  ls_cabn-atint = is_charc_head-valueintervalisallowed.
* ls_cabn-ATUNS = IS_CHARC_HEAD- .
  ls_cabn-atson = is_charc_head-additionalvalueisallowed.
  ls_cabn-attab = is_charc_head-charcreferencetable.
  ls_cabn-atfel = is_charc_head-charcreferencetablefield.
* ls_cabn-ATTEI = IS_CHARC_HEAD- .
  ls_cabn-atprt = is_charc_head-charcchecktable.
* ls_cabn-ATPRR = IS_CHARC_HEAD- .
  ls_cabn-atprf = is_charc_head-charccheckfunctionmodule.
* ls_cabn-ATWRD = IS_CHARC_HEAD- .
  ls_cabn-atfod = is_charc_head-charcentryisnotformatctrld.
* ls_cabn-ATHIE = IS_CHARC_HEAD- .
  ls_cabn-atdex = is_charc_head-charcexponentformat.
* ls_cabn-ATFGA = IS_CHARC_HEAD- .
  ls_cabn-atvsc = is_charc_head-charctemplateisdisplayed.
  ls_cabn-aname = is_charc_head-createdbyuser.
  ls_cabn-adatu = is_charc_head-creationdate.
  ls_cabn-vname = is_charc_head-lastchangedbyuser.
  ls_cabn-vdatu = is_charc_head-lastchangedate.
* ls_cabn-ATXAC = IS_CHARC_HEAD- .
* ls_cabn-ATYAC = IS_CHARC_HEAD- .
  ls_cabn-atmst = is_charc_head-charcstatus.
* ls_cabn-ATWSO = IS_CHARC_HEAD- .
* ls_cabn-ATBSO = IS_CHARC_HEAD- .
  ls_cabn-datuv = is_charc_head-validitystartdate.
* ls_cabn-TECHV = IS_CHARC_HEAD- .
  ls_cabn-aennr = is_charc_head-changenumber.
  ls_cabn-lkenz = is_charc_head-ismarkedfordeletion.
* ls_cabn-ATWRI = IS_CHARC_HEAD- .
  ls_cabn-dokar = is_charc_head-documentinforecorddoctype.
  ls_cabn-doknr = is_charc_head-documentinforecorddocnumber.
  ls_cabn-dokvr = is_charc_head-documentinforecorddocversion.
  ls_cabn-doktl = is_charc_head-documentinforecorddocpart.
* ls_cabn-KNOBJ = IS_CHARC_HEAD- .
  ls_cabn-atinp = is_charc_head-charcisreadonly.
  ls_cabn-atvie = is_charc_head-charcishidden.
  ls_cabn-werks = is_charc_head-plant.
* ls_cabn-KATALOGART = IS_CHARC_HEAD- .
  ls_cabn-auswahlmge = is_charc_head-charcselectedset.
* ls_cabn-ATHKA = IS_CHARC_HEAD- .
* ls_cabn-ATHKO = IS_CHARC_HEAD- .
* ls_cabn-CLINT = IS_CHARC_HEAD- .
* ls_cabn-ATTOL = IS_CHARC_HEAD- .
* ls_cabn-ATZUS = IS_CHARC_HEAD- .
* ls_cabn-ATVPL = IS_CHARC_HEAD- .
  ls_cabn-atauth = is_charc_head-charcmaintauthgrp.
* ls_cabn-COUNTRYGRP = IS_CHARC_HEAD- .
  ls_cabn-datub = is_charc_head-validityenddate.


  ls_cawn-mandt = sy-mandt.
  ls_cawn-atinn = iv_charcinternalid.
  ls_cawn-atzhl = ls_charc_value-charcvaluepositionnumber.
  ls_cawn-adzhl = ls_charc_value-timeintervalnumber.
  ls_cawn-atwrt = ls_charc_value-charcvalue.
  ls_cawn-atflv = ls_charc_value-charcfromnumericvalue.
  ls_cawn-atflb = ls_charc_value-charctonumericvalue.
  ls_cawn-atcod = ls_charc_value-charcvaluedependency.
* ls_cawn-atstd = cs_charc_value
  ls_cawn-atawe = ls_charc_value-charcfromnumericvalueunit.
  ls_cawn-ataw1 = ls_charc_value-charctonumericvalueunit.
* ls_cawn-ATIDN = CS_CHARC_VALUE-
* ls_cawn-SPRAS
* ls_cawn-TXTNR = CS_CHARC_VALUE-ClfnTextNumber.
  ls_cawn-datuv = ls_charc_value-validitystartdate.
* ls_cawn-TECHV = CS_CHARC_VALUE-
  ls_cawn-aennr = ls_charc_value-changenumber.
  ls_cawn-lkenz = ls_charc_value-ismarkedfordeletion.
  ls_cawn-dokar = ls_charc_value-documentinforecorddoctype.
  ls_cawn-doknr = ls_charc_value-documentinforecorddocnumber.
  ls_cawn-dokvr = ls_charc_value-documentinforecorddocpart.
  ls_cawn-doktl = ls_charc_value-documentinforecorddocversion.
* ls_cawn-ATZHH
* ls_cawn-KNOBJ
* ls_cawn-ATWHI
* ls_cawn-ATTLV
* ls_cawn-ATTLB
* ls_cawn-ATPRZ
* ls_cawn-ATINC
* ls_cawn-ATVPL
  ls_cawn-datub = ls_charc_value-validityenddate.

  CALL FUNCTION 'CTCV_PREPARE_VALUES_TO_DISPLAY'
    EXPORTING
      align                = 'NO'
      condense             = 'YES'
*     DECIMALPOINT         = ' '
      shift                = 'LEFT'
      single               = 'NO'
*     STRING_WITHOUT_OPERAND      = 'NO'
*     STRING_WITHOUT_UNIT  = 'NO'
      string_with_baseunit = 'YES'
      structure_cabn       = ls_cabn
      structure_cawn       = ls_cawn
*     WITHOUT_EDIT_MASK    = ' '
*     LANGUAGE             = SY-LANGU
*     CLASSTYPE            = ' '
*     T_SEPARATOR          = ' '
*     WITH_CHECK           = ' '
    IMPORTING
*     OPERAND1             =
*     OPERAND2             =
      string               = ls_charc_value-charcvalue
*     STRING1              =
*     STRING2              =
*     UNIT                 =
*     UNIT2                =
*     STRING_LONG          =
      string_too_long      = lv_string_too_long
    EXCEPTIONS
      overflow             = 1
      exp_overflow         = 2
      unit_not_found       = 3
      OTHERS               = 4.

  IF sy-subrc = 0.
    cs_charc_value-charcvalue = ls_charc_value-charcvalue.
  ELSE.
    IF sy-msgid IS INITIAL.
      IF sy-subrc = 1
      OR sy-subrc = 2.
        MESSAGE e029(c4) INTO DATA(lv_msg).
      ELSEIF sy-subrc = 4.
        MESSAGE e191(c1) INTO lv_msg.
      ENDIF.
    ENDIF.
    APPEND VALUE #( msgty = sy-msgty
                    msgid = sy-msgid
                    msgno = sy-msgno
                    msgv1 = sy-msgv1
                    msgv2 = sy-msgv2
                    msgv3 = sy-msgv3
                    msgv4 = sy-msgv4 ) TO et_core_message.
  ENDIF.

ENDMETHOD.