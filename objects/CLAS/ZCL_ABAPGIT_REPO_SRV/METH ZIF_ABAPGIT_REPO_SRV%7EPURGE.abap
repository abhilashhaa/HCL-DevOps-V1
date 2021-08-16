  METHOD zif_abapgit_repo_srv~purge.

* todo, this should be a method on the repo instead

    DATA: lt_tadir TYPE zif_abapgit_definitions=>ty_tadir_tt.


    IF io_repo->get_local_settings( )-write_protected = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot purge. Local code is write-protected by repo config' ).
    ELSEIF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-uninstall ) = abap_false.
      zcx_abapgit_exception=>raise( 'Not authorized' ).
    ENDIF.

    lt_tadir = zcl_abapgit_factory=>get_tadir( )->read( io_repo->get_package( ) ).

    zcl_abapgit_objects=>delete( it_tadir  = lt_tadir
                                 is_checks = is_checks ).

    delete( io_repo ).

  ENDMETHOD.