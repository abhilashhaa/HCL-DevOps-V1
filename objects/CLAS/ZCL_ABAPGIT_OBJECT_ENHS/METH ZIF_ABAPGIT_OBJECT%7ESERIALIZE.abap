  METHOD zif_abapgit_object~serialize.

    DATA: lv_spot_name TYPE enhspotname,
          li_spot_ref  TYPE REF TO if_enh_spot_tool,
          li_enhs      TYPE REF TO zif_abapgit_object_enhs,
          lx_enh_root  TYPE REF TO cx_enh_root.

    lv_spot_name = ms_item-obj_name.

    TRY.
        li_spot_ref = cl_enh_factory=>get_enhancement_spot( lv_spot_name ).

      CATCH cx_enh_root INTO lx_enh_root.
        zcx_abapgit_exception=>raise_with_text( lx_enh_root ).
    ENDTRY.

    li_enhs = factory( li_spot_ref->get_tool( ) ).

    li_enhs->serialize( ii_xml           = io_xml
                        ii_enh_spot_tool = li_spot_ref ).

    zcl_abapgit_sotr_handler=>read_sotr(
      iv_pgmid    = 'R3TR'
      iv_object   = ms_item-obj_type
      iv_obj_name = ms_item-obj_name
      io_xml      = io_xml ).

  ENDMETHOD.