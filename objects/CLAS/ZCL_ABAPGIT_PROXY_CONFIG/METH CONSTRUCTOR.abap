  METHOD constructor.

    mo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

    mi_exit = zcl_abapgit_exit=>get_instance( ).

  ENDMETHOD.