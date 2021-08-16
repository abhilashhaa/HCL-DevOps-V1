  METHOD get_referred_class_name.

    DATA lo_ref TYPE REF TO cl_abap_refdescr.
    lo_ref ?= cl_abap_typedescr=>describe_by_data( io_ref ).
    rv_name = lo_ref->get_referenced_type( )->get_relative_name( ).

  ENDMETHOD.