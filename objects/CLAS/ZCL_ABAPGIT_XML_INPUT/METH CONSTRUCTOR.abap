  METHOD constructor.

    super->constructor( iv_filename ).
    parse( iv_xml ).
    fix_xml( ).

  ENDMETHOD.