  METHOD zif_abapgit_xml_output~render.

    DATA: li_git  TYPE REF TO if_ixml_element,
          li_abap TYPE REF TO if_ixml_element.


    IF mi_raw IS INITIAL.
      li_abap ?= mi_xml_doc->get_root( )->get_first_child( ).
      mi_xml_doc->get_root( )->remove_child( li_abap ).
      IF li_abap IS INITIAL.
        li_abap = build_asx_node( ).
      ENDIF.
    ELSE.
      li_abap = mi_raw.
    ENDIF.

    li_git = mi_xml_doc->create_element( c_abapgit_tag ).
    li_git->set_attribute( name = c_attr_version
                           value = zif_abapgit_version=>gc_xml_version ).
    IF NOT is_metadata IS INITIAL.
      li_git->set_attribute( name  = c_attr_serializer
                             value = is_metadata-class ).
      li_git->set_attribute( name  = c_attr_serializer_version
                             value = is_metadata-version ).
    ENDIF.
    li_git->append_child( li_abap ).
    mi_xml_doc->get_root( )->append_child( li_git ).

    rv_xml = to_xml( iv_normalize ).

  ENDMETHOD.