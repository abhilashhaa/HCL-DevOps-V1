  METHOD class_setup.

    go_sql_environment = cl_osql_test_environment=>create(
      VALUE #(
        ( 'i_clfncharcforkeydatetp' )
        ( 'i_clfncharcrstrcnforkeydatetp' )
        ( 'i_clfncharcrefforkeydatetp' )
        ( 'i_clfncharcdescforkeydatetp' )
        ( 'i_clfncharcvalforkeydatetp' )
        ( 'i_clfncharcvaldescforkeydatetp' )

        ( 'i_clfncharacteristic' )
        ( 'i_clfncharcrestriction' )
        ( 'i_clfncharcreference' )
        ( 'i_clfncharcdesc' )
        ( 'i_clfncharcvalue' )
        ( 'i_clfncharcvaluedesc' ) ) ).

  ENDMETHOD.