  METHOD zif_abapgit_object_enho~deserialize.

    DATA: ls_enh_data  TYPE enhwdyn,
          li_tool      TYPE REF TO if_enh_tool,
          lo_wdyn      TYPE REF TO cl_enh_tool_wdy,
          lv_tool_type TYPE enhtooltype,
          lv_package   TYPE devclass.

    FIELD-SYMBOLS: <ls_controller_data> TYPE enhwdyc,
                   <ls_view_data>       TYPE enhwdyv.


    ii_xml->read(
      EXPORTING
        iv_name = 'TOOL'
      CHANGING
        cg_data = lv_tool_type ).

    ii_xml->read(
      EXPORTING
        iv_name = 'COMPONENT_DATA'
      CHANGING
        cg_data = ls_enh_data ).

    lv_package = iv_package.

    TRY.
        cl_enh_factory=>create_enhancement(
          EXPORTING
            enhname     = |{ ms_item-obj_name }|
            enhtype     = ''
            enhtooltype = lv_tool_type
          IMPORTING
            enhancement = li_tool
          CHANGING
            devclass    = lv_package ).

        lo_wdyn ?= li_tool.

        lo_wdyn->initialize( ls_enh_data-component_name ).

        lo_wdyn->set_component_data( ls_enh_data-component_data ).

        LOOP AT ls_enh_data-controller_data ASSIGNING <ls_controller_data>.

          lo_wdyn->set_controller_data( p_controller_name = <ls_controller_data>-controller_name
                                        p_enh_data        = <ls_controller_data> ).

        ENDLOOP.

        LOOP AT ls_enh_data-view_data ASSIGNING <ls_view_data>.

          lo_wdyn->set_view_data( p_view_name = <ls_view_data>-view_name
                                  p_enh_data  = <ls_view_data> ).

        ENDLOOP.

        lo_wdyn->if_enh_object~save( run_dark = abap_true ).
        lo_wdyn->if_enh_object~unlock( ).

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |error deserializing ENHO wdyn { ms_item-obj_name }| ).
    ENDTRY.

  ENDMETHOD.