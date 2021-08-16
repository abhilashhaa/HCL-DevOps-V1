  METHOD if_ngc_core_conv_logger~init_logger.

    DATA:
      lv_logtype        TYPE upgba_logtype,
      lv_upgrade_active TYPE abap_bool,
      lv_spam_active    TYPE abap_bool.

    IF iv_logtype = if_ngc_core_conv_logger=>gc_logtype_auto.
      CALL FUNCTION 'UPG_COMPONENT_INFO'
        IMPORTING
          ev_upgrade_active = lv_upgrade_active
          ev_spam_active    = lv_spam_active
        EXCEPTIONS
          OTHERS            = 2.

      IF sy-subrc = 0 AND ( lv_upgrade_active = abap_true OR lv_spam_active = abap_true ).
        lv_logtype = cl_upgba_logger=>gc_logtype_file.
      ELSE.
        lv_logtype = cl_upgba_logger=>gc_logtype_tr.
      ENDIF.
    ELSE.
      lv_logtype = iv_logtype.
    ENDIF.

    IF lv_logtype = cl_upgba_logger=>gc_logtype_file AND strlen( iv_appl_name ) > 24 ##NUMBER_OK.
      cl_upgba_logger=>create(
        iv_logid   = iv_appl_name(24)
        iv_logtype = lv_logtype
      ).
    ELSE.
      cl_upgba_logger=>create(
        iv_logid   = iv_appl_name
        iv_logtype = lv_logtype
      ).
    ENDIF.

    cl_upgba_logger=>log->cleanup( ).

  ENDMETHOD.