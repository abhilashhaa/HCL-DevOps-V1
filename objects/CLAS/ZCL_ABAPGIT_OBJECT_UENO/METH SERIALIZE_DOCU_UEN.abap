  METHOD serialize_docu_uen.

    DATA lt_docu            TYPE ty_docu_lines.

    lt_docu = serialize_docu_xxxx( 'UENC' ).

    io_xml->add( iv_name = 'DOCU_UENC'
                 ig_data = lt_docu ).


    lt_docu = serialize_docu_xxxx( 'UEND' ).

    io_xml->add( iv_name = 'DOCU_UEND'
                 ig_data = lt_docu ).

    lt_docu = serialize_docu_xxxx( 'UENE' ).

    io_xml->add( iv_name = 'DOCU_UENE'
                 ig_data = lt_docu ).
  ENDMETHOD.