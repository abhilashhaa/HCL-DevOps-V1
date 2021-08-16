  METHOD zif_abapgit_object~exists.

    TRY.
        cl_abap_pragma=>get_ref( ms_item-obj_name ).

      CATCH cx_abap_pragma_not_exists.
        rv_bool = abap_false.
        RETURN.
    ENDTRY.

    rv_bool = abap_true.

  ENDMETHOD.