  METHOD deserialize_docu_uen.

    DATA lt_docu TYPE ty_docu_lines.

    io_xml->read( EXPORTING iv_name = 'DOCU_UENC'
                 CHANGING cg_data = lt_docu ).
    deserialize_docu_xxxx( lt_docu ).


    CLEAR lt_docu.
    io_xml->read( EXPORTING iv_name = 'DOCU_UEND'
                 CHANGING cg_data = lt_docu ).
    deserialize_docu_xxxx( lt_docu ).


    CLEAR lt_docu.
    io_xml->read( EXPORTING iv_name = 'DOCU_UENE'
                 CHANGING cg_data = lt_docu ).
    deserialize_docu_xxxx( lt_docu ).

  ENDMETHOD.