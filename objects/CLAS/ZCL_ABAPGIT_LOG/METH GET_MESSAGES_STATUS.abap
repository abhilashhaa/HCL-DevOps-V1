  METHOD get_messages_status.

    DATA lr_msg TYPE REF TO zif_abapgit_log=>ty_msg.
    rv_status = 'S'.
    LOOP AT it_msg REFERENCE INTO lr_msg.
      CASE lr_msg->type.
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