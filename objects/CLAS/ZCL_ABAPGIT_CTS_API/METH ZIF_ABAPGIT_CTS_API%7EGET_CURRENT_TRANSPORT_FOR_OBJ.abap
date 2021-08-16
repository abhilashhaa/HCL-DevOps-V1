  METHOD zif_abapgit_cts_api~get_current_transport_for_obj.
    DATA: lv_object_lockable   TYPE abap_bool,
          lv_locked            TYPE abap_bool,
          lv_transport_request TYPE trkorr,
          lv_task              TYPE trkorr,
          lv_tr_object_name    TYPE trobj_name.

    lv_tr_object_name = iv_object_name.

    CALL FUNCTION 'TR_CHECK_OBJECT_LOCK'
      EXPORTING
        wi_pgmid             = iv_program_id
        wi_object            = iv_object_type
        wi_objname           = lv_tr_object_name
      IMPORTING
        we_lockable_object   = lv_object_lockable
        we_locked            = lv_locked
        we_lock_order        = lv_transport_request
        we_lock_task         = lv_task
      EXCEPTIONS
        empty_key            = 1
        no_systemname        = 2
        no_systemtype        = 3
        unallowed_lock_order = 4
        OTHERS               = 5.
    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise_t100( ).
    ENDIF.

    IF lv_locked = abap_false.
      zcx_abapgit_exception=>raise( |Object { iv_program_id }-{ iv_object_type }-{ iv_object_name } is not locked| ).
    ENDIF.

    IF lv_object_lockable = abap_false.
      zcx_abapgit_exception=>raise( |Object type { iv_program_id }-{ iv_object_type } not lockable| ).
    ENDIF.

    IF lv_task IS NOT INITIAL AND lv_task <> lv_transport_request AND iv_resolve_task_to_request = abap_false.
      rv_transport = lv_task.
    ELSE.
      rv_transport = lv_transport_request.
    ENDIF.
  ENDMETHOD.