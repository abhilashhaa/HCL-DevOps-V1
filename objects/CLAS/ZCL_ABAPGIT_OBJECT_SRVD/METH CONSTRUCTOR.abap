  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mv_service_definition_key = ms_item-obj_name.

    TRY.
        CREATE DATA mr_service_definition TYPE ('CL_SRVD_WB_OBJECT_DATA=>TY_SRVD_OBJECT_DATA').
        CREATE OBJECT mi_persistence TYPE ('CL_SRVD_OBJECT_PERSIST').

      CATCH cx_sy_create_error.
        zcx_abapgit_exception=>raise( |SRVD not supported by your NW release| ).
    ENDTRY.

  ENDMETHOD.