METHOD init_logger.

  DATA:
    lv_logtype        TYPE upgba_logtype,
    lv_upgrade_active TYPE abap_bool,
    lv_spam_active    TYPE abap_bool.

  CALL FUNCTION 'UPG_COMPONENT_INFO'
    IMPORTING
*     ET_SW_COMPONENT_INFO       =
      ev_upgrade_active = lv_upgrade_active
      ev_spam_active    = lv_spam_active
    EXCEPTIONS
      error_occurred    = 1
      OTHERS            = 2.
  IF sy-subrc EQ 0 AND ( lv_upgrade_active EQ abap_true OR lv_spam_active EQ abap_true ).
    lv_logtype = cl_upgba_logger=>gc_logtype_file.
  ELSE.
    lv_logtype = cl_upgba_logger=>gc_logtype_tr.
  ENDIF.

  cl_upgba_logger=>create( iv_logid    = iv_appl_name
                           iv_logtype  = lv_logtype ).
  cl_upgba_logger=>log->cleanup( ).

ENDMETHOD.