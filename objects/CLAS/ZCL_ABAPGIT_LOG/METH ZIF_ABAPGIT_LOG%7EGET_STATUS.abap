  METHOD zif_abapgit_log~get_status.

    DATA lr_log TYPE REF TO ty_log.
    rv_status = 'S'.
    LOOP AT mt_log REFERENCE INTO lr_log.
      CASE lr_log->msg-type.
        WHEN 'E' OR 'A' OR 'X'.
          rv_status = 'E'. "not okay
          EXIT.
        WHEN 'W'.
          rv_status = 'W'. "maybe
          CONTINUE.
        WHEN 'S' OR 'I'.
          IF rv_status <> 'W'.
            rv_status = 'S'. "okay
          ENDIF.
          CONTINUE.
        WHEN OTHERS. "unknown
          CONTINUE.
      ENDCASE.
    ENDLOOP.

  ENDMETHOD.