  METHOD constructor.
    mi_ixml     = cl_ixml=>create( ).
    mi_xml_doc  = mi_ixml->create_document( ).
    mv_filename = iv_filename.
  ENDMETHOD.