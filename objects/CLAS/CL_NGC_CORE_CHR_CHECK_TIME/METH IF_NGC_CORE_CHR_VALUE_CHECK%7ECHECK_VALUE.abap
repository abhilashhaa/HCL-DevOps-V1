  METHOD if_ngc_core_chr_value_check~check_value.

    DATA:
      lv_charcfromtime TYPE auspext_time_from,
      lv_charctotime   TYPE auspext_time_to,
      lv_time_from_str TYPE string,
      lv_time_to_str   TYPE string.

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

    " Check if input contains numbers only (HHMMSS)
    cl_ngc_clf_util_valuation_ext=>convert_fltp_to_time(
      EXPORTING
        iv_fltp_value    = cs_charc_value-charctonumericvalue
      RECEIVING
        rv_time          = lv_charctotime
      EXCEPTIONS
        conversion_error = 1
    ).
    IF sy-subrc <> 0.
      MESSAGE e022(ngc_core_chr) INTO DATA(lv_dummy).
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '022' ) TO et_message.
      RETURN.
    ENDIF.

    cl_ngc_clf_util_valuation_ext=>convert_fltp_to_time(
      EXPORTING
        iv_fltp_value    = cs_charc_value-charcfromnumericvalue
      RECEIVING
        rv_time          = lv_charcfromtime
      EXCEPTIONS
        conversion_error = 1
    ).
    IF sy-subrc <> 0.
      MESSAGE e022(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '022' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate hours
    IF lv_charcfromtime(2) > 24 OR
       lv_charctotime(2)   > 24.
      MESSAGE e013(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '013' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate minutes
    IF lv_charcfromtime+2(2) > 59 OR
       lv_charctotime+2(2)   > 59.
      MESSAGE e014(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '014' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate seconds
    IF lv_charcfromtime+4(2) > 59 OR
       lv_charctotime+4(2)   > 59.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '015' ) TO et_message.
      RETURN.
    ENDIF.

    " Validate time
    IF lv_charcfromtime > '240000' OR
       lv_charctotime   > '240000'.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '016' ) TO et_message.
      RETURN.
    ENDIF.

    " Check if FROM value is less than TO value
    IF is_charc_header-valueintervalisallowed = abap_true AND
       cs_charc_value-charcvaluedependency CA '2345' AND
       lv_charcfromtime >= lv_charctotime.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '008' ) TO et_message.
      RETURN.
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