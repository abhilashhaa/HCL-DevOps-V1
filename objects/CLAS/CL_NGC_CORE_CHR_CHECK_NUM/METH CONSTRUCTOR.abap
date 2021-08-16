  METHOD constructor.

    super->constructor( if_ngc_c=>gc_charcdatatype-num ).

    mo_uom_converter = NEW lcl_uom_converter( ).

  ENDMETHOD.