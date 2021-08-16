  METHOD serialize_macros.

    rt_source = read_include( is_clskey = is_clskey
                              iv_type = seop_ext_class_macros ).

    reduce( CHANGING ct_source = rt_source ).

  ENDMETHOD.