  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mv_dependency_rule_key = ms_item-obj_name.

    TRY.
        CREATE DATA mr_dependency_rule TYPE ('CL_DRUL_WB_OBJECT_DATA=>TY_OBJECT_DATA').
        CREATE OBJECT mi_persistence TYPE ('CL_DRUL_WB_OBJECT_PERSIST').

      CATCH cx_sy_create_error.
        zcx_abapgit_exception=>raise( |DRUL not supported by your NW release| ).
    ENDTRY.

  ENDMETHOD.