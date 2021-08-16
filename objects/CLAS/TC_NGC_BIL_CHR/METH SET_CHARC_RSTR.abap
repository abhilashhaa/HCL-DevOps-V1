  METHOD SET_CHARC_RSTR.

    go_sql_environment->insert_test_data(
      i_data             = it_charc_rstr
      i_parameter_values = VALUE #( ( parameter_name = 'P_KeyDate' parameter_value = sy-datum ) ) ).

  ENDMETHOD.