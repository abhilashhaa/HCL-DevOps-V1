  METHOD switch_to_pr.

    DATA lo_repo_online TYPE REF TO zcl_abapgit_repo_online.
    DATA lt_pulls TYPE zif_abapgit_pr_enum_provider=>tty_pulls.
    DATA ls_pull LIKE LINE OF lt_pulls.

    IF mo_repo->is_offline( ) = abap_true.
      zcx_abapgit_exception=>raise( 'Unexpected PR switch for offline repo' ).
    ENDIF.
    IF mo_repo->get_local_settings( )-write_protected = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot switch branch. Local code is write-protected by repo config' ).
    ENDIF.

    lo_repo_online ?= mo_repo.

    IF iv_revert = abap_true.
      lo_repo_online->switch_origin( '' ).
    ELSE.
      lt_pulls = zcl_abapgit_pr_enumerator=>new( lo_repo_online )->get_pulls( ).
      IF lines( lt_pulls ) = 0.
        RETURN. " false
      ENDIF.

      ls_pull = zcl_abapgit_ui_factory=>get_popups( )->choose_pr_popup( lt_pulls ).
      IF ls_pull IS INITIAL.
        RETURN. " false
      ENDIF.

      lo_repo_online->switch_origin( ls_pull-head_url ).
      lo_repo_online->set_branch_name( |refs/heads/{ ls_pull-head_branch }| ). " TODO refactor
      rv_switched = abap_true.
    ENDIF.

  ENDMETHOD.