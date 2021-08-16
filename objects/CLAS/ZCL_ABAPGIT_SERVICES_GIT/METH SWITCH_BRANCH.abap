  METHOD switch_branch.

    DATA: lo_repo   TYPE REF TO zcl_abapgit_repo_online,
          ls_branch TYPE zif_abapgit_definitions=>ty_git_branch.


    lo_repo ?= zcl_abapgit_repo_srv=>get_instance( )->get( iv_key ).

    IF lo_repo->get_local_settings( )-write_protected = abap_true.
      zcx_abapgit_exception=>raise( 'Cannot switch branch. Local code is write-protected by repo config' ).
    ENDIF.

    ls_branch = zcl_abapgit_ui_factory=>get_popups( )->branch_list_popup(
      iv_url             = lo_repo->get_url( )
      iv_default_branch  = lo_repo->get_branch_name( )
      iv_show_new_option = abap_true ).
    IF ls_branch IS INITIAL.
      RAISE EXCEPTION TYPE zcx_abapgit_cancel.
    ENDIF.

    IF ls_branch-name = zif_abapgit_popups=>c_new_branch_label.
      create_branch( iv_key ).
      RETURN.
    ENDIF.

    lo_repo->set_branch_name( ls_branch-name ).

    COMMIT WORK AND WAIT.

  ENDMETHOD.