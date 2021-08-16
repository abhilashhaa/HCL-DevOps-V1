  METHOD class_setup.

    go_sql_environment = cl_osql_test_environment=>create(
     VALUE #(
       ( 'i_clfncharacteristicforkeydate' )
       ( 'i_clfncharcvalueforkeydate' )
       ( 'i_clfncharcreference' )
       ( 'i_unitofmeasure' )
       ( 'mara' )
       ( 'makt' ) ) ).

  ENDMETHOD.