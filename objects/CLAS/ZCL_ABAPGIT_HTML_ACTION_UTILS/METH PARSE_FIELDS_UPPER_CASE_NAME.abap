  METHOD parse_fields_upper_case_name.

    rt_fields = parse_fields( iv_string ).
    field_keys_to_upper( CHANGING ct_fields = rt_fields ).

  ENDMETHOD.