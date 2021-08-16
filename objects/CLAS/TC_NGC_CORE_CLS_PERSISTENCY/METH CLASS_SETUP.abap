  METHOD class_setup.

    go_sql_environment = cl_osql_test_environment=>create(
     VALUE #(
       ( 'i_clfnclassforkeydate' )
       ( 'i_clfnobjectclassbasic' )
       ( 'i_clfnclassstatus' )
       ( 'i_clfnclassstatustext' )
       ( 'i_clfnorganizationalarea' )
       ( 'i_clfnobjectcharcvaluebasic' )
       ( 'i_clfnclasssuperiorforkeydate' )
       ( 'i_clfnclasscharcbasic' )
       ( 'i_clfncharcbasic' ) ) ).

  ENDMETHOD.