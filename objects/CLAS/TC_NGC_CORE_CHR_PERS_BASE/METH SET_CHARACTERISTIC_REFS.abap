  METHOD SET_CHARACTERISTIC_REFS.

    go_sql_environment->insert_test_data(
      i_data             = it_characteristic_ref
      i_parameter_values = VALUE #( ( parameter_name = 'P_KeyDate' parameter_value = iv_keydate ) ) ).

  ENDMETHOD.