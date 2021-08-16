  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mv_service_binding_key = ms_item-obj_name.

    TRY.
        CREATE DATA mr_service_binding TYPE ('CL_SRVB_OBJECT_DATA=>TY_OBJECT_DATA').
        CREATE OBJECT mi_persistence TYPE ('CL_SRVB_OBJECT_PERSIST').

      CATCH cx_sy_create_error.
        zcx_abapgit_exception=>raise( |SRVB not supported by your NW release| ).
    ENDTRY.

  ENDMETHOD.