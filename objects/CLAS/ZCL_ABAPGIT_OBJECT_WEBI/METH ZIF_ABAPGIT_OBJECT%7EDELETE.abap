  METHOD zif_abapgit_object~delete.

    DATA: lv_name TYPE vepname,
          lo_vif  TYPE REF TO cl_ws_md_vif_root.


    lv_name = ms_item-obj_name.

    CREATE OBJECT lo_vif.
    TRY.
        lo_vif->if_ws_md_vif_root~delete_virtual_interface( lv_name ).
      CATCH cx_ws_md_exception.
        zcx_abapgit_exception=>raise( 'error deleting WEBI' ).
    ENDTRY.

  ENDMETHOD.