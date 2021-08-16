  METHOD zif_abapgit_persist_repo~add.

    DATA: ls_repo        TYPE zif_abapgit_persistence=>ty_repo,
          lv_repo_as_xml TYPE string.


    ls_repo-url          = iv_url.
    ls_repo-branch_name  = iv_branch_name.
    ls_repo-package      = iv_package.
    ls_repo-offline      = iv_offline.
    ls_repo-created_by   = sy-uname.
    GET TIME STAMP FIELD ls_repo-created_at.
    ls_repo-dot_abapgit  = is_dot_abapgit.

    ls_repo-local_settings-display_name = iv_display_name.

    lv_repo_as_xml = to_xml( ls_repo ).

    rv_key = get_next_id( ).

    mo_db->add( iv_type  = zcl_abapgit_persistence_db=>c_type_repo
                iv_value = rv_key
                iv_data  = lv_repo_as_xml ).

  ENDMETHOD.