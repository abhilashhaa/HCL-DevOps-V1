  METHOD zif_abapgit_object~exists.

    DATA: lv_object_key TYPE seu_objkey.

    lv_object_key = ms_item-obj_name.

    rv_bool = abap_true.

    TRY.
        get_persistence( )->get( p_object_key           = lv_object_key
                                 p_version              = swbm_version_active
                                 p_existence_check_only = abap_true ).

      CATCH cx_swb_exception.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.