  METHOD zif_abapgit_object~exists.

    TRY.
        mi_persistence->get(
            p_object_key           = mv_logical_db_schema_key
            p_version              = 'A'
            p_existence_check_only = abap_true ).
        rv_bool = abap_true.

      CATCH cx_swb_exception.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.