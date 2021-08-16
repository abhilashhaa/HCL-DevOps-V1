  METHOD zif_abapgit_object~delete.

    DATA: lv_name         TYPE fpname,
          lo_wb_interface TYPE REF TO cl_fp_wb_interface.


    lo_wb_interface ?= load( ).

    lv_name = ms_item-obj_name.

    TRY.
        lo_wb_interface->delete( lv_name ).
      CATCH cx_fp_api.
        zcx_abapgit_exception=>raise( 'SFPI error, delete' ).
    ENDTRY.

  ENDMETHOD.