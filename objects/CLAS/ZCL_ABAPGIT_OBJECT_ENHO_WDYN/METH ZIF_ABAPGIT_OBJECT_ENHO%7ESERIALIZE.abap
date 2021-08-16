  METHOD zif_abapgit_object_enho~serialize.

    DATA: lo_wdyn           TYPE REF TO cl_enh_tool_wdy,
          lv_component_name TYPE wdy_component_name,
          ls_enh_data       TYPE enhwdyn.


    lo_wdyn ?= ii_enh_tool.
    lv_component_name = lo_wdyn->get_component_name( ).

    TRY.
        lo_wdyn->get_all_data_for_comp(
          EXPORTING
            p_component_name = lv_component_name
          IMPORTING
            p_enh_data       = ls_enh_data ).

        ii_xml->add( iv_name = 'TOOL'
                     ig_data = ii_enh_tool->get_tool( ) ).

        ii_xml->add( iv_name = 'COMPONENT_DATA'
                     ig_data = ls_enh_data ).

      CATCH cx_enh_not_found.
        zcx_abapgit_exception=>raise( |error serializing ENHO wdyn { ms_item-obj_name }| ).
    ENDTRY.

  ENDMETHOD.