  METHOD if_ngc_core_chr_value_check~check_value.

    CLEAR: et_message.

    " Execute basic checks
    super->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header = is_charc_header
      IMPORTING
        et_message      = DATA(lt_message)
      CHANGING
        cs_charc_value  = cs_charc_value ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    me->check_length(
      EXPORTING
        is_charc_header = is_charc_header
        iv_value        = cs_charc_value-charcfromnumericvalue
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    me->check_length(
      EXPORTING
        is_charc_header = is_charc_header
        iv_value        = cs_charc_value-charctonumericvalue
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    IF is_charc_header-valueintervalisallowed = abap_true AND
       cs_charc_value-charcvaluedependency CA '2345' AND
       cs_charc_value-charcfromnumericvalue >= cs_charc_value-charctonumericvalue.
      MESSAGE e008(ngc_core_chr) INTO DATA(lv_dummy).
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '008' ) TO et_message.
      RETURN.
    ENDIF.

    " Fill charctonumericvalue if charcvaluedependency is 1
    " and all the checks were ok so far
    " (This is needed because it was implemented the same way in CL_EX_CACL_CLSSF_UPD_EXT_VALUE
    " and in CL_NGC_CLF_UTIL_VALUATION_EXT.)
    IF cs_charc_value-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
      cs_charc_value-charctonumericvalue = cs_charc_value-charcfromnumericvalue.
    ENDIF.

    me->build_string(
      EXPORTING
        is_charc_header   = is_charc_header
        is_charc_value    = cs_charc_value
      IMPORTING
        et_message        = lt_message
        ev_charc_value    = cs_charc_value-charcvalue ).

    APPEND LINES OF lt_message TO et_message.

  ENDMETHOD.