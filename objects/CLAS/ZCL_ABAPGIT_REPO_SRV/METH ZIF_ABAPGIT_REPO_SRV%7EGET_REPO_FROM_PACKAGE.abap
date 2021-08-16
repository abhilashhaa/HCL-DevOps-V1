  METHOD zif_abapgit_repo_srv~get_repo_from_package.

    DATA:
      lt_repos TYPE zif_abapgit_persistence=>tt_repo,
      lv_name  TYPE zif_abapgit_persistence=>ty_local_settings-display_name,
      lv_owner TYPE zif_abapgit_persistence=>ty_local_settings-display_name.

    FIELD-SYMBOLS:
      <ls_repo> LIKE LINE OF lt_repos.

    " check if package is already in use for a different repository
    lt_repos = zcl_abapgit_persist_factory=>get_repo( )->list( ).
    READ TABLE lt_repos WITH KEY package = iv_package ASSIGNING <ls_repo>.
    IF sy-subrc = 0.
      eo_repo = get_instance( )->get( <ls_repo>-key ).
      lv_name = eo_repo->get_name( ).
      lv_owner = <ls_repo>-created_by.
      ev_reason = |Package { iv_package } already versioned as { lv_name } by { lv_owner }|.
    ELSE.
      " check if package is include as sub-package in a different repo
      validate_sub_super_packages(
        EXPORTING
          iv_package    = iv_package
          it_repos      = lt_repos
          iv_ign_subpkg = iv_ign_subpkg
        IMPORTING
          eo_repo       = eo_repo
          ev_reason     = ev_reason ).
    ENDIF.

  ENDMETHOD.