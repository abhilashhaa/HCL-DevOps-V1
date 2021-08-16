  METHOD serialize_docu_usp.

    DATA lt_docu            TYPE ty_docu_lines.

    lt_docu = serialize_docu_xxxx( 'USPD' ).

    io_xml->add( iv_name = 'DOCU_USPD'
                 ig_data = lt_docu ).


  ENDMETHOD.