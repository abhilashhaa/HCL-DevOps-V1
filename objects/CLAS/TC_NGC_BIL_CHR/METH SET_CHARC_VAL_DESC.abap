  METHOD set_charc_val_desc.

    go_sql_environment->insert_test_data(
      i_data             = it_charc_val_desc
      i_parameter_values = VALUE #( ( parameter_name = 'P_KeyDate' parameter_value = iv_keydate ) ) ).

  ENDMETHOD.