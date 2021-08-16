  METHOD zif_abapgit_object~deserialize.

    DATA: lv_xstr      TYPE xstring,
          lv_name      TYPE fpname,
          li_wb_object TYPE REF TO if_fp_wb_interface,
          li_interface TYPE REF TO if_fp_interface.


    lv_name = ms_item-obj_name.
    lv_xstr = cl_ixml_80_20=>render_to_xstring( io_xml->get_raw( ) ).

    IF zif_abapgit_object~exists( ) = abap_true.
      zif_abapgit_object~delete( iv_package ).
    ENDIF.

    TRY.
        li_interface = cl_fp_helper=>convert_xstring_to_interface( lv_xstr ).
        tadir_insert( iv_package ).
        li_wb_object = cl_fp_wb_interface=>create( i_name      = lv_name
                                                   i_interface = li_interface ).
        li_wb_object->save( ).
        li_wb_object->free( ).
      CATCH cx_fp_api.
        zcx_abapgit_exception=>raise( 'SFPI error, deserialize' ).
    ENDTRY.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.