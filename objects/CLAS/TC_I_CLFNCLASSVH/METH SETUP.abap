  METHOD setup.

    DATA:
      lt_class TYPE STANDARD TABLE OF i_clfnclass.


    lt_class = VALUE #(
      ( class = 'CLASS_01' classtype = '001' classinternalid = '0000000001' )
      ( class = 'CLASS_02' classtype = '001' classinternalid = '0000000002' )
      ( class = 'CLASS_03' classtype = '017' classinternalid = '0000000003' ) ).

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).
    go_environment->insert_test_data( lt_class ).

  ENDMETHOD.