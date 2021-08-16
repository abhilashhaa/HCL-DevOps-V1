  METHOD if_ngc_core_chr_value_check~check_value.

    DATA:
      lv_charcfromdate TYPE auspext_date_from,
      lv_charctodate   TYPE auspext_date_to,
      lv_date_from_str TYPE string,
      lv_date_to_str   TYPE string.

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

    " Check if input contains numbers only (YYYYMMDD)
    cl_ngc_clf_util_valuation_ext=>convert_fltp_to_date(
      EXPORTING
        iv_fltp_value    = cs_charc_value-charcfromnumericvalue
      RECEIVING
        rv_date          = lv_charcfromdate
      EXCEPTIONS
        conversion_error = 1 ).
    IF sy-subrc <> 0.
      MESSAGE e021(ngc_core_chr) INTO DATA(lv_dummy).
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '021' ) TO et_message.
      RETURN.
    ENDIF.

    cl_ngc_clf_util_valuation_ext=>convert_fltp_to_date(
      EXPORTING
        iv_fltp_value    = cs_charc_value-charctonumericvalue
      RECEIVING
        rv_date          = lv_charctodate
      EXCEPTIONS
        conversion_error = 1 ).
    IF sy-subrc <> 0.
      MESSAGE e021(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '021' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate months
    IF lv_charcfromdate+4(2) > 12 OR
       lv_charctodate+4(2)   > 12.
      MESSAGE e019(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '019' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate days
    me->validate_day(
      EXPORTING
        is_charc_header = is_charc_header
        iv_date         = lv_charcfromdate
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    me->validate_day(
      EXPORTING
        is_charc_header = is_charc_header
        iv_date         = lv_charctodate
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    " Check if FROM value is less than TO value
    IF is_charc_header-valueintervalisallowed = abap_true AND
       cs_charc_value-charcvaluedependency CA '2345' AND
       lv_charcfromdate >= lv_charctodate.
      MESSAGE e008(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '008' ) TO et_message.
      RETURN.
    ENDIF.

    " Get display format
    lv_date_from_str = lv_charcfromdate.
    lv_date_to_str   = lv_charctodate.

    me->build_string(
      EXPORTING
        is_charc_header = is_charc_header
        is_charc_value  = cs_charc_value
      IMPORTING
        et_message      = lt_message
        ev_charc_value  = cs_charc_value-charcvalue ).

    APPEND LINES OF lt_message TO et_message.

  ENDMETHOD.