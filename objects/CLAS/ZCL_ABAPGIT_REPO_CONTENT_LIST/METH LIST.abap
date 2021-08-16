  METHOD list.

    mi_log->clear( ).

    IF mo_repo->has_remote_source( ) = abap_true.
      rt_repo_items = build_repo_items_with_remote( ).
    ELSE.
      rt_repo_items = build_repo_items_local_only( ).
    ENDIF.

    IF iv_by_folders = abap_true.
      build_folders(
        EXPORTING iv_cur_dir    = iv_path
        CHANGING  ct_repo_items = rt_repo_items ).
    ENDIF.

    IF iv_changes_only = abap_true.
      " There are never changes for offline repositories
      filter_changes( CHANGING ct_repo_items = rt_repo_items ).
    ENDIF.

    SORT rt_repo_items BY
      sortkey ASCENDING
      path ASCENDING
      obj_name ASCENDING.

  ENDMETHOD.