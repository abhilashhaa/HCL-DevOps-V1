  METHOD update_global_settings.

    DATA: li_ixml          TYPE REF TO if_ixml,
          lv_settings_xml  TYPE string,
          li_ostream       TYPE REF TO if_ixml_ostream,
          li_renderer      TYPE REF TO if_ixml_renderer,
          li_streamfactory TYPE REF TO if_ixml_stream_factory.

    " finally update global settings
    " migrated elements are already removed from document

    li_ixml = cl_ixml=>create( ).
    li_streamfactory = li_ixml->create_stream_factory( ).
    li_ostream = li_streamfactory->create_ostream_cstring( lv_settings_xml ).
    li_renderer = li_ixml->create_renderer( ostream  = li_ostream
                                            document = ii_document ).
    li_renderer->render( ).

    zcl_abapgit_persistence_db=>get_instance( )->update(
      iv_type  = zcl_abapgit_persistence_db=>c_type_settings
      iv_value = ''
      iv_data  = lv_settings_xml ).

  ENDMETHOD.