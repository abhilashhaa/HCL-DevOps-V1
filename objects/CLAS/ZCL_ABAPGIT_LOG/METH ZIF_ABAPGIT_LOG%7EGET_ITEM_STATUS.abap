  METHOD zif_abapgit_log~get_item_status.

    DATA lr_log         TYPE REF TO ty_log.
    DATA ls_msg         TYPE zif_abapgit_log=>ty_msg.
    DATA ls_item_status TYPE zif_abapgit_log=>ty_item_status_out.
    DATA lr_item_status TYPE REF TO zif_abapgit_log=>ty_item_status_out.

    "collect all message for all objects
    LOOP AT mt_log REFERENCE INTO lr_log.
      CLEAR ls_item_status.
      ls_item_status-item = lr_log->item.
      READ TABLE rt_item_status REFERENCE INTO lr_item_status
           WITH KEY item-obj_type = ls_item_status-item-obj_type
                    item-obj_name = ls_item_status-item-obj_name.
      IF sy-subrc <> 0.
        INSERT ls_item_status INTO TABLE rt_item_status.
        GET REFERENCE OF ls_item_status INTO lr_item_status.
      ENDIF.
      CLEAR ls_msg.
      ls_msg-type = lr_log->msg-type.
      ls_msg-text = lr_log->msg-text.
      INSERT ls_msg INTO TABLE lr_item_status->messages.
    ENDLOOP.

    "determine object status from object messages
    LOOP AT rt_item_status REFERENCE INTO lr_item_status.
      lr_item_status->status = get_messages_status( lr_item_status->messages ).
      IF lr_item_status->messages IS INITIAL.
        CLEAR ls_msg.
        ls_msg-type = 'I'.
        ls_msg-text = 'No message'.
        INSERT ls_msg INTO TABLE lr_item_status->messages.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.