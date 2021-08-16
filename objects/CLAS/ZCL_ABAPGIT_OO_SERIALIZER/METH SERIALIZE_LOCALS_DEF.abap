  METHOD serialize_locals_def.

    rt_source = read_include( is_clskey = is_clskey
                              iv_type = seop_ext_class_locals_def ).

    reduce( CHANGING ct_source = rt_source ).

  ENDMETHOD.