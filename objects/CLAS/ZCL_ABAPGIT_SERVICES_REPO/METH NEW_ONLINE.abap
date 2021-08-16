  METHOD new_online.

    DATA:
      lo_repo     TYPE REF TO zcl_abapgit_repo,
      li_repo_srv TYPE REF TO zif_abapgit_repo_srv,
      lv_reason   TYPE string.

    " make sure package is not already in use for a different repository
    " 702: chaining calls with exp&imp parameters causes syntax error
    li_repo_srv = zcl_abapgit_repo_srv=>get_instance( ).
    li_repo_srv->get_repo_from_package(
      EXPORTING
        iv_package = is_repo_params-package
        iv_ign_subpkg = is_repo_params-ignore_subpackages
      IMPORTING
        eo_repo    = lo_repo
        ev_reason  = lv_reason ).

    IF lo_repo IS BOUND.
      zcx_abapgit_exception=>raise( lv_reason ).
    ENDIF.

    ro_repo = zcl_abapgit_repo_srv=>get_instance( )->new_online(
      iv_url              = is_repo_params-url
      iv_branch_name      = is_repo_params-branch_name
      iv_package          = is_repo_params-package
      iv_display_name     = is_repo_params-display_name
      iv_folder_logic     = is_repo_params-folder_logic
      iv_ign_subpkg       = is_repo_params-ignore_subpackages
      iv_master_lang_only = is_repo_params-master_lang_only ).

    toggle_favorite( ro_repo->get_key( ) ).

    " Set default repo for user
    zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( ro_repo->get_key( ) ).

    COMMIT WORK.

  ENDMETHOD.