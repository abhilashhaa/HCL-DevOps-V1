  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE vepname.


    lv_name = ms_item-obj_name.

    rv_bool = cl_ws_md_vif_root=>check_existence_by_vif_name(
      name      = lv_name
      i_version = sews_c_vif_version-active ).

  ENDMETHOD.