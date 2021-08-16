  METHOD clear.

    CALL FUNCTION 'TR_TASK_RESET'
      EXPORTING
        iv_username      = is_default_task-username
        iv_order         = is_default_task-ordernum
        iv_task          = is_default_task-tasknum
        iv_dialog        = abap_false
      EXCEPTIONS
        invalid_username = 1
        invalid_order    = 2
        invalid_task     = 3
        OTHERS           = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from TR_TASK_RESET. Subrc = { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.