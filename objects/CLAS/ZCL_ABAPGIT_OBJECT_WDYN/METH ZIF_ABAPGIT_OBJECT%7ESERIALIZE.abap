  METHOD zif_abapgit_object~serialize.

    DATA: ls_component   TYPE wdy_component_metadata,
          ls_description TYPE wdy_ext_ctx_map.

    ls_component = read( ).

    io_xml->add( iv_name = 'COMPONENT'
                 ig_data = ls_component ).
    io_xml->add( ig_data = mt_components
                 iv_name = 'COMPONENTS' ).
    io_xml->add( ig_data = mt_sources
                 iv_name = 'SOURCES' ).

    READ TABLE ls_component-comp_metadata-descriptions INTO ls_description INDEX 1.
    IF sy-subrc = 0.
      zcl_abapgit_sotr_handler=>read_sotr(
        iv_pgmid    = 'LIMU'
        iv_object   = 'WDYV'
        iv_obj_name = ms_item-obj_name
        io_xml      = io_xml ).
    ENDIF.

  ENDMETHOD.