  METHOD zif_abapgit_object~serialize.

    DATA: lx_error            TYPE REF TO cx_enh_root,
          li_enh_composite    TYPE REF TO if_enh_composite,
          lt_composite_childs TYPE enhcompositename_it,
          lt_enh_childs       TYPE enhname_it,
          lv_longtext_id      TYPE enhdocuobject,
          lv_shorttext        TYPE string.

    TRY.
        li_enh_composite = cl_enh_factory=>load_enhancement_composite(
          name = mv_composite_id
          lock = abap_false ).

        lv_shorttext = li_enh_composite->if_enh_object_docu~get_shorttext( ).

        lt_composite_childs = li_enh_composite->get_composite_childs( ).
        lt_enh_childs       = li_enh_composite->get_enh_childs( ).
        lv_longtext_id      = li_enh_composite->get_longtext_id( ).

        io_xml->add( iv_name = 'SHORTTEXT'
                     ig_data = lv_shorttext ).
        io_xml->add( iv_name = 'COMPOSITE_CHILDS'
                     ig_data = lt_composite_childs ).
        io_xml->add( iv_name = 'ENH_CHILDS'
                     ig_data = lt_enh_childs ).
        io_xml->add( iv_name = 'LONGTEXT_ID'
                     ig_data = lv_longtext_id ).

        zcl_abapgit_sotr_handler=>read_sotr(
          iv_pgmid    = 'R3TR'
          iv_object   = ms_item-obj_type
          iv_obj_name = ms_item-obj_name
          io_xml      = io_xml ).

      CATCH cx_enh_root INTO lx_error.
        zcx_abapgit_exception=>raise( lx_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.