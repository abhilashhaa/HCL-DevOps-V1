  METHOD zif_abapgit_object~exists.

    DATA: lv_spot_name TYPE enhspotname,
          li_spot_ref  TYPE REF TO if_enh_spot_tool.

    lv_spot_name = ms_item-obj_name.

    TRY.
        li_spot_ref = cl_enh_factory=>get_enhancement_spot( lv_spot_name ).

        rv_bool = abap_true.

      CATCH cx_enh_root.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.