  METHOD zif_abapgit_object~serialize.

    DATA: lv_spot_name  TYPE enhspotcompositename,
          lv_message    TYPE string,
          lv_enh_shtext TYPE string,
          lt_enh_spots  TYPE enhspotname_it,
          lt_comp_spots TYPE enhspotname_it,
          lx_root       TYPE REF TO cx_root,
          li_spot_ref   TYPE REF TO if_enh_spot_composite,
          lo_spot_ref   TYPE REF TO cl_enh_spot_composite.


    lv_spot_name = ms_item-obj_name.

    TRY.
        li_spot_ref = cl_enh_factory=>get_enhancement_spot_comp(
          lock = ''
          name = lv_spot_name ).

        lo_spot_ref ?= li_spot_ref.

        lv_enh_shtext = li_spot_ref->if_enh_object_docu~get_shorttext( ).
        "find subsequent enhancement spots
        lt_enh_spots = lo_spot_ref->if_enh_spot_composite~get_enh_spot_childs( ).
        "find subsequent composite enhancement spots
        lt_comp_spots = lo_spot_ref->if_enh_spot_composite~get_composite_childs( ).

        io_xml->add( ig_data = lv_enh_shtext
                     iv_name = 'SHORTTEXT' ).
        io_xml->add( ig_data = lt_enh_spots
                     iv_name = 'ENH_SPOTS' ).         "Enhancement spots
        io_xml->add( ig_data = lt_comp_spots
                     iv_name = 'COMP_ENH_SPOTS' ).    "Composite enhancement spots

        zcl_abapgit_sotr_handler=>read_sotr(
          iv_pgmid    = 'R3TR'
          iv_object   = ms_item-obj_type
          iv_obj_name = ms_item-obj_name
          io_xml      = io_xml ).

      CATCH cx_enh_root INTO lx_root.
        lv_message = `Error occured while serializing ENSC: `
          && lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_message ).
    ENDTRY.

  ENDMETHOD.