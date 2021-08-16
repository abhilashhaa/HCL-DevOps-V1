  METHOD parse.

    DATA lo_parser TYPE REF TO lcl_json_parser.

    CREATE OBJECT ro_instance.
    CREATE OBJECT lo_parser.
    ro_instance->mt_json_tree = lo_parser->parse( iv_json ).

    IF iv_freeze = abap_true.
      ro_instance->freeze( ).
    ENDIF.

  ENDMETHOD.