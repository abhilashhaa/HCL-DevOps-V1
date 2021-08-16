  METHOD set_charcbasic.

    go_sql_environment->insert_test_data(
      i_data = it_charcbasic ).

  ENDMETHOD.