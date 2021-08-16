  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE cxsltdesc.

    lv_name = ms_item-obj_name.

    rv_bool = cl_o2_api_xsltdesc=>exists( lv_name ).
    rv_bool = boolc( rv_bool = '1' ).

  ENDMETHOD.