  METHOD zif_abapgit_sap_package~get_transport_type.
    DATA: lv_err_prefix TYPE string,
          lv_pkg_name   TYPE e071-obj_name.

    lv_err_prefix = |TRINT_GET_REQUEST_TYPE(R3TR, DEVC, { mv_package })|.
    lv_pkg_name = mv_package.

    CALL FUNCTION 'TRINT_GET_REQUEST_TYPE'
      EXPORTING
        iv_pgmid                   = 'R3TR'
        iv_object                  = 'DEVC'
        iv_obj_name                = lv_pkg_name
      IMPORTING
        ev_request_type            = rs_transport_type-request
        ev_task_type               = rs_transport_type-task
      EXCEPTIONS
        no_request_needed          = 1
        internal_error             = 2
        cts_initialization_failure = 3.

    CASE sy-subrc.
      WHEN 0.
        " OK!

      WHEN 1.
        zcx_abapgit_exception=>raise( |{ lv_err_prefix }: transport is not needed| ).

      WHEN 2.
        zcx_abapgit_exception=>raise( |{ lv_err_prefix }: internal error| ).

      WHEN 3.
        zcx_abapgit_exception=>raise( |{ lv_err_prefix }: failed to initialized CTS| ).

      WHEN OTHERS.
        zcx_abapgit_exception=>raise( |{ lv_err_prefix }: unrecognized return code| ).
    ENDCASE.

  ENDMETHOD.