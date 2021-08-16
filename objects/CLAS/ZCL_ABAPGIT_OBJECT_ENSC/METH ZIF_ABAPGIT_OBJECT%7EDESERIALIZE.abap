  METHOD zif_abapgit_object~deserialize.

    DATA: lv_spot_name  TYPE enhspotcompositename,
          lv_message    TYPE string,
          lv_enh_shtext TYPE string,
          lv_enh_spot   TYPE enhspotname,
          lt_enh_spots  TYPE enhspotname_it,
          lt_comp_spots TYPE enhspotname_it,
          lx_root       TYPE REF TO cx_root,
          lv_package    LIKE iv_package,
          li_spot_ref   TYPE REF TO if_enh_spot_composite,
          lo_spot_ref   TYPE REF TO cl_enh_spot_composite.


    lv_spot_name = ms_item-obj_name.

    io_xml->read( EXPORTING iv_name = 'SHORTTEXT'
                  CHANGING  cg_data = lv_enh_shtext ).
    io_xml->read( EXPORTING iv_name = 'ENH_SPOTS'     "Enhancement spots
                  CHANGING  cg_data = lt_enh_spots ).
    io_xml->read( EXPORTING iv_name = 'COMP_ENH_SPOTS' "Composite enhancement spots
                  CHANGING  cg_data = lt_comp_spots ).

    IF zif_abapgit_object~exists( ) = abap_true.
      zif_abapgit_object~delete( iv_package ).
    ENDIF.

    lv_package = iv_package.

    TRY.
        cl_enh_factory=>create_enhancement_spot_comp(
          EXPORTING
            name      = lv_spot_name
            run_dark  = abap_true
          IMPORTING
            composite = li_spot_ref
          CHANGING
            devclass  = lv_package ).

        lo_spot_ref ?= li_spot_ref.

        lo_spot_ref->if_enh_object_docu~set_shorttext( lv_enh_shtext ).
        "Add subsequent enhancement spots
        LOOP AT lt_enh_spots INTO lv_enh_spot.
          lo_spot_ref->if_enh_spot_composite~add_enh_spot_child( lv_enh_spot ).
        ENDLOOP.
        "Add subsequent composite enhancement spots
        LOOP AT lt_comp_spots INTO lv_enh_spot.
          lo_spot_ref->if_enh_spot_composite~add_composite_child( lv_enh_spot ).
        ENDLOOP.

        lo_spot_ref->if_enh_object~save( ).
        lo_spot_ref->if_enh_object~activate( ).
        lo_spot_ref->if_enh_object~unlock( ).

        zcl_abapgit_sotr_handler=>create_sotr(
          iv_package = iv_package
          io_xml     = io_xml ).

      CATCH cx_enh_root INTO lx_root.
        lv_message = `Error occured while deserializing ENSC: `
          && lx_root->get_text( ).
        zcx_abapgit_exception=>raise( lv_message ).
    ENDTRY.

  ENDMETHOD.