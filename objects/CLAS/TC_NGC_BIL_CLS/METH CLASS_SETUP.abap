  METHOD class_setup.

    go_sql_environment = cl_osql_test_environment=>create(
      VALUE #(
        ( 'i_clfnclassforkeydatetp' )
        ( 'i_clfncharcforkeydatetp' )
        ( 'i_clfnclasscharcforkeydatetp' )
        ( 'i_clfnclassdescforkeydatetp' )
        ( 'i_clfnclasskeywordforkeydatetp' )
        ( 'i_clfnclasstextforkeydatetp' )
        ( 'i_clfncharcrstrcnforkeydatetp' )
        ( 'tclx' ) ) ).

  ENDMETHOD.