  METHOD zif_abapgit_repo_srv~new_offline.

    DATA: ls_repo        TYPE zif_abapgit_persistence=>ty_repo,
          lv_key         TYPE zif_abapgit_persistence=>ty_repo-key,
          lo_dot_abapgit TYPE REF TO zcl_abapgit_dot_abapgit.


    IF zcl_abapgit_auth=>is_allowed( zif_abapgit_auth=>gc_authorization-create_repo ) = abap_false.
      zcx_abapgit_exception=>raise( 'Not authorized' ).
    ENDIF.

    validate_package( iv_package ).

    lo_dot_abapgit = zcl_abapgit_dot_abapgit=>build_default( ).
    lo_dot_abapgit->set_folder_logic( iv_folder_logic ).

    lv_key = zcl_abapgit_persist_factory=>get_repo( )->add(
      iv_url          = iv_url
      iv_branch_name  = ''
      iv_package      = iv_package
      iv_offline      = abap_true
      is_dot_abapgit  = lo_dot_abapgit->get_data( ) ).

    TRY.
        ls_repo = zcl_abapgit_persist_factory=>get_repo( )->read( lv_key ).
      CATCH zcx_abapgit_not_found.
        zcx_abapgit_exception=>raise( 'new_offline not found' ).
    ENDTRY.

    ro_repo ?= instantiate_and_add( ls_repo ).

    ls_repo-local_settings-serialize_master_lang_only = iv_master_lang_only.
    ro_repo->set_local_settings( ls_repo-local_settings ).

  ENDMETHOD.