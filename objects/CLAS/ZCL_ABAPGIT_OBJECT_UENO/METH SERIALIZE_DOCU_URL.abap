  METHOD serialize_docu_url.


    DATA lt_docu            TYPE ty_docu_lines.

    lt_docu = serialize_docu_xxxx( 'URL1' ).
    io_xml->add( iv_name = 'DOCU_URL1'
                 ig_data = lt_docu ).


    lt_docu = serialize_docu_xxxx( 'URL2' ).
    io_xml->add( iv_name = 'DOCU_URL2'
                 ig_data = lt_docu ).

    lt_docu = serialize_docu_xxxx( 'URLC' ).
    io_xml->add( iv_name = 'DOCU_URLC'
                 ig_data = lt_docu ).

  ENDMETHOD.