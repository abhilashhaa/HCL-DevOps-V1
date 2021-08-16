  METHOD zif_abapgit_object~deserialize.

    DATA: lv_xstr      TYPE xstring,
          lv_layout    TYPE xstring,
          lv_name      TYPE fpname,
          li_wb_object TYPE REF TO if_fp_wb_form,
          li_form      TYPE REF TO if_fp_form,
          lx_fp_err    TYPE REF TO cx_fp_api.


    lv_name = ms_item-obj_name.
    lv_xstr = cl_ixml_80_20=>render_to_xstring( io_xml->get_raw( ) ).

    TRY.
        li_form = cl_fp_helper=>convert_xstring_to_form( lv_xstr ).

        IF mo_files->contains( c_layout_file_ext ) = abap_true.
          lv_layout = mo_files->read_raw( c_layout_file_ext ).
          li_form->get_layout( )->set_layout_data( lv_layout ).
        ENDIF.

        IF zif_abapgit_object~exists( ) = abap_true.
          cl_fp_wb_form=>delete( lv_name ).
        ENDIF.

        tadir_insert( iv_package ).
        li_wb_object = cl_fp_wb_form=>create( i_name = lv_name
                                              i_form = li_form ).
        li_wb_object->save( ).
        li_wb_object->free( ).
      CATCH cx_fp_api INTO lx_fp_err.
        zcx_abapgit_exception=>raise( |SFPF deserialization error: { lx_fp_err->get_text( ) }| ).
    ENDTRY.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

  ENDMETHOD.