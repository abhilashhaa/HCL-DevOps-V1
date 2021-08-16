  METHOD serialize_locals_imp.

    rt_source = read_include( is_clskey = is_clskey
                              iv_type = seop_ext_class_locals_imp ).

    reduce( CHANGING ct_source = rt_source ).

  ENDMETHOD.