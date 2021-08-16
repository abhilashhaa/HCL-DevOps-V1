  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mv_logical_db_schema_key = ms_item-obj_name.

    TRY.
        CREATE DATA mr_logical_db_schema TYPE ('CL_AMDP_SCHEMA_OBJECT_DATA=>TY_OBJECT_DATA').
        CREATE OBJECT mi_persistence TYPE ('CL_AMDP_SCHEMA_OBJECT_PERSIST').

      CATCH cx_sy_create_error.
        zcx_abapgit_exception=>raise( |AMSD not supported by your NW release| ).
    ENDTRY.

  ENDMETHOD.