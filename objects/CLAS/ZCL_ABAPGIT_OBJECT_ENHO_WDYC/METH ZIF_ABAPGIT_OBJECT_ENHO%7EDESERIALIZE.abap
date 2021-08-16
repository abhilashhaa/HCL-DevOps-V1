  METHOD zif_abapgit_object_enho~deserialize.

    DATA: lv_enhname TYPE enhname,
          lo_wdyconf TYPE REF TO cl_wdr_cfg_enhancement,
          li_tool    TYPE REF TO if_enh_tool,
          ls_obj     TYPE wdy_config_key,
          lv_package TYPE devclass.


    ii_xml->read( EXPORTING iv_name = 'ORIGINAL_OBJECT'
                  CHANGING cg_data  = ls_obj ).

    lv_enhname = ms_item-obj_name.
    lv_package = iv_package.
    TRY.
        cl_enh_factory=>create_enhancement(
          EXPORTING
            enhname     = lv_enhname
            enhtype     = ''
            enhtooltype = cl_wdr_cfg_enhancement=>tooltype
          IMPORTING
            enhancement = li_tool
          CHANGING
            devclass    = lv_package ).
        lo_wdyconf ?= li_tool.

* todo
* io_xml->read_xml()
* CL_WDR_CFG_PERSISTENCE_UTILS=>COMP_XML_TO_TABLES( )
* lo_wdyconf->set_enhancement_data( )
        ASSERT 0 = 1.

        lo_wdyconf->if_enh_object~save( run_dark = abap_true ).
        lo_wdyconf->if_enh_object~unlock( ).
      CATCH cx_enh_root.
        zcx_abapgit_exception=>raise( 'error deserializing ENHO wdyconf' ).
    ENDTRY.

  ENDMETHOD.