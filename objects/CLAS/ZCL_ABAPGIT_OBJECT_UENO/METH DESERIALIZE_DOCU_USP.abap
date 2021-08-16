  METHOD deserialize_docu_usp.

    DATA lt_docu TYPE ty_docu_lines.

    io_xml->read( EXPORTING iv_name = 'DOCU_USPD'
                 CHANGING cg_data = lt_docu ).

    deserialize_docu_xxxx( lt_docu ).

  ENDMETHOD.