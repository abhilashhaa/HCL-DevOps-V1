  METHOD class_setup.

    go_sql_environment = cl_osql_test_environment=>create(
      VALUE #(
        ( 'i_clfnobjectclassforkeydate' )
        ( 'i_clfnclassforkeydate' )
        ( 'i_clfnobjectcharcvalforkeydate' )
        ( 'i_clfnclasstype' )
        ( 'i_clfnclasstypetext' )
        ( 'tclao' )
        ( 'tclt' ) ) ).

  ENDMETHOD.