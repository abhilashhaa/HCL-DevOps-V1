  METHOD if_ngc_core_chr_value_check~check_value.

    CLEAR: et_message.

    " Check if data type is valid
    IF is_charc_header-charcdatatype <> mv_data_type.
      RAISE EXCEPTION TYPE cx_ngc_core_chr_exception.
    ENDIF.

    " Check if charc value dependency is in valid range
    IF NOT cs_charc_value-charcvaluedependency CA '123456789'.
      MESSAGE e002(ngc_core_chr) INTO DATA(lv_dummy).
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '002' ) TO et_message.
      RETURN.
    ENDIF.

    " Check if TO value is only filled when expected
    IF cs_charc_value-charcvaluedependency CA '189'.
      IF cs_charc_value-charctonumericvalue IS NOT INITIAL.
        MESSAGE e003(ngc_core_chr) INTO lv_dummy.
        APPEND VALUE #(
          key_date        = sy-datum
          charcinternalid = is_charc_header-charcinternalid
          msgty           = if_ngc_c=>gc_message_severity-error
          msgid           = 'NGC_CORE_CHR'
          msgno           = '003' ) TO et_message.
        RETURN.
      ENDIF.
    ENDIF.

    " Check if FROM value is only filled when expected
    IF cs_charc_value-charcvaluedependency CA '67'.
      IF cs_charc_value-charcfromnumericvalue IS NOT INITIAL.
        MESSAGE e023(ngc_core_chr) INTO lv_dummy.
        APPEND VALUE #(
          key_date        = sy-datum
          charcinternalid = is_charc_header-charcinternalid
          msgty           = if_ngc_c=>gc_message_severity-error
          msgid           = 'NGC_CORE_CHR'
          msgno           = '023' ) TO et_message.
        RETURN.
      ENDIF.
    ENDIF.

    " Check if value is negative and it is not allowed
    IF is_charc_header-negativevalueisallowed = abap_false AND
       ( cs_charc_value-charcfromnumericvalue < 0 ).
      MESSAGE e006(ngc_core_chr) WITH is_charc_header-charcdescription INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '006'
        msgv1           = is_charc_header-charcdescription ) TO et_message.
      RETURN.
    ENDIF.

    " Check if dependency is 1 for single value characteristics
    IF is_charc_header-valueintervalisallowed = abap_false AND
       cs_charc_value-charcvaluedependency <> '1'.
      MESSAGE e002(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '002' ) TO et_message.
      RETURN.
    ENDIF.

  ENDMETHOD.