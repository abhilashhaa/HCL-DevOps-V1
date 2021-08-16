  METHOD lock.
    DATA: lv_dummy_update_function TYPE funcname.

    CALL FUNCTION 'ENQUEUE_EZABAPGIT'
      EXPORTING
        mode_zabapgit  = iv_mode
        type           = iv_type
        value          = iv_value
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Could not aquire lock { iv_type } { iv_value }| ).
    ENDIF.

    lv_dummy_update_function = get_update_function( ).

* trigger dummy update task to automatically release locks at commit
    CALL FUNCTION lv_dummy_update_function
      IN UPDATE TASK.

  ENDMETHOD.