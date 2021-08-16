  METHOD upload_data_from_stream.

    DATA:
      lo_xml           TYPE REF TO cl_apl_ecatt_xml,
      lv_xstr          TYPE xstring,
      li_nc_xmlref_typ TYPE REF TO if_ixml_node_collection,
      li_n_xmlref_typ  TYPE REF TO if_ixml_node,
      lv_index         TYPE i VALUE 0,
      lv_count         TYPE i.

    lv_xstr = iv_xml_stream.

    CALL METHOD cl_apl_ecatt_xml=>('CREATE') " doesn't exist in 702
      EXPORTING
        im_type = co_xml
      RECEIVING
        re_xml  = lo_xml.

* whitespace stripping needs a namespace
* remove white spaces only at the time of upload
    lo_xml->stream_to_dom( im_xstream            = lv_xstr
                           im_ignore_white_space = 'X'
                           im_uri                = cl_apl_xml_const=>schema_uri ).

    lo_xml->get_attributes( IMPORTING ex_dom = ri_template_over_all ).

* MD: Workaround, because nodes starting with "XML" are not allowed
    li_nc_xmlref_typ ?= ri_template_over_all->get_elements_by_tag_name_ns( 'XMLREF_TYP' ).
    CALL METHOD li_nc_xmlref_typ->('GET_LENGTH')  " downport
      RECEIVING
        rval = lv_count.

    WHILE lv_index < lv_count.
      li_n_xmlref_typ = li_nc_xmlref_typ->get_item( lv_index ).
      li_n_xmlref_typ->set_name( 'X-MLREF_TYP' ).
      lv_index = lv_index + 1.
    ENDWHILE.

  ENDMETHOD.