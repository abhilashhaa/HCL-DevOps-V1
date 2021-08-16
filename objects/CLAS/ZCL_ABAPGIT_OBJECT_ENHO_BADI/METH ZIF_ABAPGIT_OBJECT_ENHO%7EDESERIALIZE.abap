  METHOD zif_abapgit_object_enho~deserialize.

    DATA: lv_spot_name TYPE enhspotname,
          lv_shorttext TYPE string,
          lv_enhname   TYPE enhname,
          lo_badi      TYPE REF TO cl_enh_tool_badi_impl,
          li_tool      TYPE REF TO if_enh_tool,
          lv_package   TYPE devclass,
          lt_impl      TYPE enh_badi_impl_data_it.

    FIELD-SYMBOLS: <ls_impl> LIKE LINE OF lt_impl.


    ii_xml->read( EXPORTING iv_name = 'SHORTTEXT'
                  CHANGING cg_data  = lv_shorttext ).
    ii_xml->read( EXPORTING iv_name = 'SPOT_NAME'
                  CHANGING cg_data  = lv_spot_name ).
    ii_xml->read( EXPORTING iv_name = 'IMPL'
                  CHANGING cg_data  = lt_impl ).

    lv_enhname = ms_item-obj_name.
    lv_package = iv_package.
    TRY.
        cl_enh_factory=>create_enhancement(
          EXPORTING
            enhname     = lv_enhname
            enhtype     = cl_abstract_enh_tool_redef=>credefinition
            enhtooltype = cl_enh_tool_badi_impl=>tooltype
          IMPORTING
            enhancement = li_tool
          CHANGING
            devclass    = lv_package ).
        lo_badi ?= li_tool.

        lo_badi->set_spot_name( lv_spot_name ).
        lo_badi->if_enh_object_docu~set_shorttext( lv_shorttext ).
        LOOP AT lt_impl ASSIGNING <ls_impl>.
          lo_badi->add_implementation( <ls_impl> ).
        ENDLOOP.
        lo_badi->if_enh_object~save( run_dark = abap_true ).
        lo_badi->if_enh_object~unlock( ).
      CATCH cx_enh_root.
        zcx_abapgit_exception=>raise( 'error deserializing ENHO badi' ).
    ENDTRY.

  ENDMETHOD.