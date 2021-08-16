  METHOD zif_abapgit_object~serialize.
* see function module FB_DOWNLOAD_FORM

    DATA: lo_sf                  TYPE REF TO cl_ssf_fb_smart_form,
          lv_name                TYPE string,
          li_node                TYPE REF TO if_ixml_node,
          li_element             TYPE REF TO if_ixml_element,
          li_iterator            TYPE REF TO if_ixml_node_iterator,
          lv_formname            TYPE tdsfname,
          li_ixml                TYPE REF TO if_ixml,
          li_xml_doc             TYPE REF TO if_ixml_document.

    li_ixml = cl_ixml=>create( ).
    li_xml_doc = li_ixml->create_document( ).

    CREATE OBJECT lo_sf.
    lv_formname = ms_item-obj_name. " convert type
    TRY.
        lo_sf->load( im_formname = lv_formname
                     im_language = '' ).
      CATCH cx_ssf_fb.
* the smartform is not present in system, or other error occured
        RETURN.
    ENDTRY.

    lo_sf->xml_download( EXPORTING parent   = li_xml_doc
                         CHANGING  document = li_xml_doc ).

    li_iterator = li_xml_doc->create_iterator( ).
    li_node = li_iterator->get_next( ).
    WHILE NOT li_node IS INITIAL.

      lv_name = li_node->get_name( ).
      IF lv_name = 'DEVCLASS'
          OR lv_name = 'LASTDATE'
          OR lv_name = 'LASTTIME'.
        li_node->set_value( '' ).
      ENDIF.
      IF lv_name = 'FIRSTUSER'
          OR lv_name = 'LASTUSER'.
        li_node->set_value( 'DUMMY' ).
      ENDIF.
      li_node = li_iterator->get_next( ).
    ENDWHILE.

    fix_ids( li_xml_doc ).

    li_element = li_xml_doc->get_root_element( ).
    li_element->set_attribute(
      name      = 'sf'
      namespace = 'xmlns'
      value     = 'urn:sap-com:SmartForms:2000:internal-structure' ).
    li_element->set_attribute(
      name  = 'xmlns'
      value = 'urn:sap-com:sdixml-ifr:2000' ).

    io_xml->set_raw( li_xml_doc->get_root_element( ) ).

  ENDMETHOD.