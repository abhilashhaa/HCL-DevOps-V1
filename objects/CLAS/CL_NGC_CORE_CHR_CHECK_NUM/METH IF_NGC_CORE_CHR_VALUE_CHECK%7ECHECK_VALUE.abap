  METHOD if_ngc_core_chr_value_check~check_value.

    DATA:
      lv_value_from TYPE atflv,
      lv_value_to   TYPE atflb.

    CLEAR: et_message.

    lv_value_from = cs_charc_value-charcfromnumericvalue.
    lv_value_to   = cs_charc_value-charctonumericvalue.

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

    " Check if TO UoM is only filled when expected
    IF cs_charc_value-charcvaluedependency CA '189' AND
       cs_charc_value-charctonumericvalueunit IS NOT INITIAL.
      MESSAGE e004(ngc_core_chr) INTO DATA(lv_dummy).
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '004' ) TO et_message.
      RETURN.
    ENDIF.

    " Check if FROM UoM is only filled when expected
    IF cs_charc_value-charcvaluedependency CA '67' AND
       cs_charc_value-charcfromnumericvalueunit IS NOT INITIAL.
      MESSAGE e024(ngc_core_chr) INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '024' ) TO et_message.
      RETURN.
    ENDIF.

    " Check if no uom is provided for value if base uom is not defined
    IF ( cs_charc_value-charcfromnumericvalueunit IS NOT INITIAL OR
         cs_charc_value-charctonumericvalueunit IS NOT INITIAL ) AND
        is_charc_header-charcvalueunit IS INITIAL.
      MESSAGE e005(ngc_core_chr) WITH is_charc_header-charcdescription INTO lv_dummy.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '005'
        msgv1           = is_charc_header-charcdescription ) TO et_message.
      RETURN.
    ENDIF.

    me->check_length(
      EXPORTING
        is_charc_header = is_charc_header
        iv_value        = lv_value_from
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    me->check_length(
      EXPORTING
        is_charc_header = is_charc_header
        iv_value        = lv_value_to
      IMPORTING
        et_message      = lt_message ).

    APPEND LINES OF lt_message TO et_message.
    CHECK lt_message IS INITIAL.

    " Try to convert FROM value to base uom
    IF cs_charc_value-charcfromnumericvalueunit IS NOT INITIAL.
      mo_uom_converter->convert_value_uom(
        EXPORTING
          is_charc_header = is_charc_header
          iv_value        = cs_charc_value-charcfromnumericvalue
          iv_uom_from     = cs_charc_value-charcfromnumericvalueunit
          iv_uom_to       = is_charc_header-charcvalueunit
        IMPORTING
          ev_value        = lv_value_from
          et_message      = lt_message ).

      APPEND LINES OF lt_message TO et_message.
      CHECK lt_message IS INITIAL.
    ENDIF.

    " Try to convert TO value to base uom
    IF cs_charc_value-charctonumericvalueunit IS NOT INITIAL.
      mo_uom_converter->convert_value_uom(
        EXPORTING
          is_charc_header = is_charc_header
          iv_value        = cs_charc_value-charctonumericvalue
          iv_uom_from     = cs_charc_value-charctonumericvalueunit
          iv_uom_to       = is_charc_header-charcvalueunit
        IMPORTING
          ev_value        = lv_value_to
          et_message      = lt_message ).

      APPEND LINES OF lt_message TO et_message.
      CHECK lt_message IS INITIAL.
    ENDIF.

    " Check if FROM value is less than TO value
    IF is_charc_header-valueintervalisallowed = abap_true AND
       cs_charc_value-charcvaluedependency CA '2345' AND
       lv_value_from >= lv_value_to.
      MESSAGE e008(ngc_core_chr) INTO lv_dummy.
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