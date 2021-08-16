  METHOD load.

    DATA: lv_name TYPE fpname.


    lv_name = ms_item-obj_name.

    TRY.
        ri_wb_interface = cl_fp_wb_interface=>load( lv_name ).
      CATCH cx_fp_api.
        zcx_abapgit_exception=>raise( 'SFPI error, load' ).
    ENDTRY.

  ENDMETHOD.