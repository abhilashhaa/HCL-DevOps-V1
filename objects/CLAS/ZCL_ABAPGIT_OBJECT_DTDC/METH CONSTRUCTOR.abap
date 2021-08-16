  METHOD constructor.

    super->constructor(
        is_item     = is_item
        iv_language = iv_language ).

    mv_dynamic_cache_key = ms_item-obj_name.

    TRY.
        CREATE DATA mr_dynamic_cache TYPE ('CL_DTDC_WB_OBJECT_DATA=>TY_DTDC_OBJECT_DATA').
        CREATE OBJECT mi_persistence TYPE ('CL_DTDC_OBJECT_PERSIST').

      CATCH cx_sy_create_error.
        zcx_abapgit_exception=>raise( |DTDC not supported by your NW release| ).
    ENDTRY.

  ENDMETHOD.