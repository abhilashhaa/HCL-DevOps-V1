  METHOD constructor.

    super->constructor( ).
    mo_settings = zcl_abapgit_persist_settings=>get_instance( )->read( ).

  ENDMETHOD.