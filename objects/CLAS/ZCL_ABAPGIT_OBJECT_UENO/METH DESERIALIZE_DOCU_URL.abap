  METHOD deserialize_docu_url.

    DATA lt_docu TYPE ty_docu_lines.

    io_xml->read( EXPORTING iv_name = 'DOCU_URL1'
                 CHANGING cg_data = lt_docu ).

    deserialize_docu_xxxx( lt_docu ).

    CLEAR lt_docu.
    io_xml->read( EXPORTING iv_name = 'DOCU_URL2'
                 CHANGING cg_data = lt_docu ).

    deserialize_docu_xxxx( lt_docu ).

    CLEAR lt_docu.
    io_xml->read( EXPORTING iv_name = 'DOCU_URLC'
                 CHANGING cg_data = lt_docu ).

    deserialize_docu_xxxx( lt_docu ).

  ENDMETHOD.