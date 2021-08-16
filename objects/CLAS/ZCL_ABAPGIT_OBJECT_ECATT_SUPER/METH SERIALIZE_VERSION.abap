  METHOD serialize_version.

    DATA: li_document    TYPE REF TO if_ixml_document,
          lv_xml         TYPE xstring,
          li_node        TYPE REF TO if_ixml_element,
          lo_download    TYPE REF TO cl_apl_ecatt_download,
          lv_object_type TYPE etobj_type.

    lo_download = get_download( ).

    lv_object_type = get_object_type( ).

    lv_xml = zcl_abapgit_ecatt_helper=>build_xml_of_object(
                 iv_object_name    = mv_object_name
                 iv_object_version = iv_version
                 iv_object_type    = lv_object_type
                 io_download       = lo_download ).

    IF lv_xml IS INITIAL.
      zcx_abapgit_exception=>raise( |ECATT, empty xml, { mv_object_name }| ).
    ENDIF.

    li_document = cl_ixml_80_20=>parse_to_document( stream_xstring = lv_xml ).

    clear_attributes( CHANGING ci_document = li_document ).

    clear_elements( CHANGING ci_document = li_document ).

    li_node = li_document->create_element( co_name-version ).
    li_node->append_child( li_document->get_root_element( ) ).

    ci_node->append_child( li_node ).

  ENDMETHOD.