  METHOD zif_abapgit_object~deserialize.

    DATA: ls_webi     TYPE ty_webi,
          lv_name     TYPE vepname,
          ls_header   LIKE LINE OF ls_webi-pvepheader,
          lx_root     TYPE REF TO cx_root,
          lv_exists   TYPE abap_bool,
          li_root     TYPE REF TO if_ws_md_vif_root,
          ls_endpoint LIKE LINE OF ls_webi-pvependpoint.

    io_xml->read( EXPORTING iv_name = 'WEBI'
                  CHANGING  cg_data = ls_webi ).

    lv_name = ms_item-obj_name.

    READ TABLE ls_webi-pvependpoint INDEX 1 INTO ls_endpoint.
    ASSERT sy-subrc = 0.
    IF ls_endpoint-auto_generated = abap_true.
      " handled by SPRX.
      RETURN.
    ENDIF.

    READ TABLE ls_webi-pvepheader INDEX 1 INTO ls_header.
    ASSERT sy-subrc = 0.

    lv_exists = cl_ws_md_vif_root=>check_existence_by_vif_name(
      name      = lv_name
      i_version = sews_c_vif_version-all ).

    li_root = cl_ws_md_factory=>get_vif_root( ).
    TRY.
        IF lv_exists = abap_false.
          mi_vi = li_root->create_virtual_interface(
            name    = lv_name
            nameext = ls_header-vepnameext ).
        ELSE.
          mi_vi = li_root->get_virtual_interface( lv_name ).
          mi_vi->if_ws_md_lockable_object~lock( ).
        ENDIF.

        mi_vi->set_short_text( ls_webi-veptext ).

        handle_endpoint( ls_webi ).
        handle_types( ls_webi ).
        handle_function( ls_webi ).
        handle_soap( ls_webi ).

        tadir_insert( iv_package ).

        mi_vi->if_ws_md_lockable_object~save( ).
        mi_vi->if_ws_md_lockable_object~unlock( ).
      CATCH cx_ws_md_exception INTO lx_root.
        TRY.
            mi_vi->if_ws_md_lockable_object~unlock( ).
          CATCH cx_ws_md_exception ##no_handler.
        ENDTRY.
        zcx_abapgit_exception=>raise( lx_root->if_message~get_text( ) ).
    ENDTRY.

    zcl_abapgit_objects_activation=>add_item( ms_item ).

    zcl_abapgit_sotr_handler=>create_sotr(
      iv_package = iv_package
      io_xml     = io_xml ).

  ENDMETHOD.