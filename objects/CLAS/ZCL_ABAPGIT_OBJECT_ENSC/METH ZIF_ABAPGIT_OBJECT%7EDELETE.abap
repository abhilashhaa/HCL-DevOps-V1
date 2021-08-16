  METHOD zif_abapgit_object~delete.
    DATA: lv_spot_name TYPE enhspotcompositename,
          lv_message   TYPE string,
          lx_root      TYPE REF TO cx_root,
          li_spot_ref  TYPE REF TO if_enh_spot_composite.

    lv_spot_name = ms_item-obj_name.

    TRY.
        li_spot_ref = cl_enh_factory=>get_enhancement_spot_comp(
          lock = 'X'
          name = lv_spot_name ).

        IF li_spot_ref IS BOUND.
          li_spot_ref->if_enh_object~delete(
            nevertheless_delete = 'X'
            run_dark            = 'X' ).
        ENDIF.
        li_spot_ref->if_enh_object~unlock( ).
      CATCH cx_enh_root INTO lx_root.
        lv_message = `Error occured while deleting ENSC: `
          && lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_message ).
    ENDTRY.

  ENDMETHOD.