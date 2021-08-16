  METHOD perform_migration.

    IF interface_exists( ) = abap_false.
      create_interface( ).
    ELSEIF interface_valid( ) = abap_false.
      add_intf_source_and_activate( ).
    ENDIF.

  ENDMETHOD.