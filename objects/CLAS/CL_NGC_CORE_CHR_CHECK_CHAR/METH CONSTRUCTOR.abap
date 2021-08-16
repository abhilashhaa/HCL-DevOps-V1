  METHOD constructor.

    super->constructor( if_ngc_c=>gc_charcdatatype-char ).

    mo_core_util ?= cl_ngc_core_util=>get_instance( ).

  ENDMETHOD.