  METHOD access_free.

    " Release the lock on the object.

    CALL FUNCTION 'RS_ACCESS_PERMISSION'
      EXPORTING
        mode                     = 'FREE'
        object                   = me->ms_object_type
        object_class             = me->c_transport_object_class
      EXCEPTIONS
        canceled_in_corr         = 1
        enqueued_by_user         = 2
        enqueue_system_failure   = 3
        illegal_parameter_values = 4
        locked_by_author         = 5
        no_modify_permission     = 6
        no_show_permission       = 7
        permission_failure       = 8
        request_language_denied  = 9
        OTHERS                   = 10.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ELSE.
      rv_result = abap_true.
    ENDIF.

  ENDMETHOD.