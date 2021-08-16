  METHOD zif_abapgit_repo_srv~delete.

    zcl_abapgit_persist_factory=>get_repo( )->delete( io_repo->get_key( ) ).

    " If favorite, remove it
    IF zcl_abapgit_persistence_user=>get_instance( )->is_favorite_repo( io_repo->get_key( ) ) = abap_true.
      zcl_abapgit_persistence_user=>get_instance( )->toggle_favorite( io_repo->get_key( ) ).
    ENDIF.

    DELETE TABLE mt_list FROM io_repo.
    ASSERT sy-subrc = 0.

  ENDMETHOD.