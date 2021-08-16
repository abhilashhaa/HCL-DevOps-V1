METHOD check_authority.

*   Ensure only privileged user are allowed to manually start the data conversion
*   1. check for SUM privilege
  AUTHORITY-CHECK OBJECT 'S_ADMI_FCD' ID 'S_ADMI_FCD' FIELD 'SUM'.
  IF sy-subrc NE 0.
*   2. check for application-specific (or developer privilege)
    "AUTHORITY-CHECK OBJECT '<appl_auth_obj>' ID '<appl_auth_id>' FIELD '<auth_fld>'.
    AUTHORITY-CHECK OBJECT 'S_DEVELOP'
      ID 'DEVCLASS' FIELD '*'
      ID 'OBJTYPE'  FIELD 'PROG'
      ID 'OBJNAME'  FIELD sy-repid
      ID 'P_GROUP'  DUMMY "not required in this context
      ID 'ACTVT'    FIELD '02'.

    IF sy-subrc NE 0.
      MESSAGE e900(upgba) INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).
      cl_upgba_logger=>log->close( ).
      rv_failed = abap_true.
    ENDIF.
  ENDIF.

ENDMETHOD.