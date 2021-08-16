  METHOD set_valuation.

    go_sql_environment->insert_test_data(
      i_data             = it_valuation
      i_parameter_values = VALUE #( ( parameter_name = 'P_KeyDate' parameter_value = iv_keydate ) ) ).

  ENDMETHOD.