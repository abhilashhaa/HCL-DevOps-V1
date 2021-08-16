  METHOD zif_abapgit_object~serialize.

    DATA: lo_xslt       TYPE REF TO cl_o2_api_xsltdesc,
          lv_source     TYPE string,
          ls_attributes TYPE o2xsltattr.


    lo_xslt = get( ).

    ls_attributes = lo_xslt->get_attributes( ).

    CLEAR: ls_attributes-author,
           ls_attributes-createdon,
           ls_attributes-changedby,
           ls_attributes-changedon,
           ls_attributes-devclass.

    io_xml->add( iv_name = 'ATTRIBUTES'
                 ig_data = ls_attributes ).

    lv_source = lo_xslt->get_source_string( ).

    mo_files->add_string( iv_extra  = 'source'
                          iv_ext    = 'xml'
                          iv_string = lv_source ).

  ENDMETHOD.