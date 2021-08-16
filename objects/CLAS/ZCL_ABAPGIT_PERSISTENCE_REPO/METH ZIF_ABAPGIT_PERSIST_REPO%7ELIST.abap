  METHOD zif_abapgit_persist_repo~list.

    DATA: lt_content TYPE zif_abapgit_persistence=>tt_content,
          ls_content LIKE LINE OF lt_content,
          ls_repo    LIKE LINE OF rt_repos.


    lt_content = mo_db->list_by_type( zcl_abapgit_persistence_db=>c_type_repo ).

    LOOP AT lt_content INTO ls_content.
      MOVE-CORRESPONDING from_xml( ls_content-data_str ) TO ls_repo.
      IF ls_repo-local_settings-write_protected = abap_false AND
         zcl_abapgit_factory=>get_environment( )->is_repo_object_changes_allowed( ) = abap_false.
        ls_repo-local_settings-write_protected = abap_true.
      ENDIF.
      ls_repo-key = ls_content-value.
      INSERT ls_repo INTO TABLE rt_repos.
    ENDLOOP.

  ENDMETHOD.