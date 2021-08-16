  METHOD zif_abapgit_object~serialize.

    DATA: lv_enh_id   TYPE enhname,
          li_enho     TYPE REF TO zif_abapgit_object_enho,
          li_enh_tool TYPE REF TO if_enh_tool.

    IF zif_abapgit_object~exists( ) = abap_false.
      RETURN.
    ENDIF.

    lv_enh_id = ms_item-obj_name.
    TRY.
        li_enh_tool = cl_enh_factory=>get_enhancement(
          enhancement_id   = lv_enh_id
          bypassing_buffer = abap_true ).
      CATCH cx_enh_root.
        zcx_abapgit_exception=>raise( 'Error from CL_ENH_FACTORY' ).
    ENDTRY.

    li_enho = factory( li_enh_tool->get_tool( ) ).

    li_enho->serialize( ii_xml      = io_xml
                        ii_enh_tool = li_enh_tool ).

    zcl_abapgit_sotr_handler=>read_sotr(
      iv_pgmid    = 'R3TR'
      iv_object   = ms_item-obj_type
      iv_obj_name = ms_item-obj_name
      io_xml      = io_xml ).

  ENDMETHOD.