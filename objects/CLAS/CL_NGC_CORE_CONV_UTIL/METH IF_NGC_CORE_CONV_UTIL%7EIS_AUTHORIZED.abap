  METHOD if_ngc_core_conv_util~is_authorized.

    " Check for SUM privilege.
    AUTHORITY-CHECK OBJECT 'S_ADMI_FCD' ID 'S_ADMI_FCD' FIELD 'SUM'.

    IF sy-subrc = 0.
      rv_authorized = abap_true.
    ELSE.

      " Check for application-specific (or developer) privilege.
      AUTHORITY-CHECK OBJECT 'S_DEVELOP'
        ID 'DEVCLASS' FIELD '*'
        ID 'OBJTYPE'  FIELD 'PROG'
        ID 'OBJNAME'  FIELD sy-repid
        ID 'P_GROUP'  DUMMY
        ID 'ACTVT'    FIELD '02'.

      IF sy-subrc = 0.
        rv_authorized = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.