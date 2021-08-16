  METHOD zif_abapgit_object~exists.

    DATA: lv_spot_name TYPE enhspotcompositename.


    lv_spot_name = ms_item-obj_name.

    TRY.
        cl_enh_factory=>get_enhancement_spot_comp(
          lock = ''
          name = lv_spot_name ).
        rv_bool = abap_true.
      CATCH cx_enh_root.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.