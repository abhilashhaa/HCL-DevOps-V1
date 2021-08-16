  METHOD zif_abapgit_object~deserialize.

    DATA: li_document         TYPE REF TO if_ixml_document,
          li_versions         TYPE REF TO if_ixml_node_collection,
          li_version_iterator TYPE REF TO if_ixml_node_iterator,
          li_version_node     TYPE REF TO if_ixml_node.

    li_document = io_xml->get_raw( ).

    li_versions = li_document->get_elements_by_tag_name( depth = 0
                                                         name  = co_name-version ).

    li_version_iterator = li_versions->create_iterator( ).

    DO.
      li_version_node = li_version_iterator->get_next( ).

      IF li_version_node IS NOT BOUND.
        EXIT.
      ENDIF.

      deserialize_version( ii_version_node = li_version_node
                           iv_package      = iv_package ).

    ENDDO.

  ENDMETHOD.