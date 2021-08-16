  METHOD zif_abapgit_object~exists.

    DATA: lv_object_type TYPE etobj_type.

    lv_object_type = get_object_type( ).

    TRY.
        rv_bool = cl_apl_ecatt_object=>existence_check_object( im_name               = mv_object_name
                                                               im_version            = co_default_version
                                                               im_obj_type           = lv_object_type
                                                               im_exists_any_version = abap_true ).

      CATCH cx_ecatt.
        RETURN.
    ENDTRY.

  ENDMETHOD.