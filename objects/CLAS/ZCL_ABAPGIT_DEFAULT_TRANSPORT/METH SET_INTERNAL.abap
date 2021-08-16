  METHOD set_internal.

    CALL FUNCTION 'TR_TASK_SET'
      EXPORTING
        iv_order          = iv_transport
      EXCEPTIONS
        invalid_username  = 1
        invalid_category  = 2
        invalid_client    = 3
        invalid_validdays = 4
        invalid_order     = 5
        invalid_task      = 6
        OTHERS            = 7.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from TR_TASK_SET. Subrc = { sy-subrc }| ).
    ENDIF.

  ENDMETHOD.