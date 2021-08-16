  METHOD toggle_favorite.

    zcl_abapgit_persistence_user=>get_instance( )->toggle_favorite( iv_key ).

  ENDMETHOD.