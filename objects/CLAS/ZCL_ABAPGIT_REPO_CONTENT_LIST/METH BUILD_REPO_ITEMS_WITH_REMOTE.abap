  METHOD build_repo_items_with_remote.

    DATA:
      ls_file   TYPE zif_abapgit_definitions=>ty_repo_file,
      lt_status TYPE zif_abapgit_definitions=>ty_results_tt.

    FIELD-SYMBOLS: <ls_status>    LIKE LINE OF lt_status,
                   <ls_repo_item> LIKE LINE OF rt_repo_items.


    lt_status = mo_repo->status( mi_log ).

    LOOP AT lt_status ASSIGNING <ls_status>.
      AT NEW obj_name. "obj_type + obj_name
        APPEND INITIAL LINE TO rt_repo_items ASSIGNING <ls_repo_item>.
        <ls_repo_item>-obj_type = <ls_status>-obj_type.
        <ls_repo_item>-obj_name = <ls_status>-obj_name.
        <ls_repo_item>-inactive = <ls_status>-inactive.
        <ls_repo_item>-sortkey  = c_sortkey-default. " Default sort key
        <ls_repo_item>-changes  = 0.
        <ls_repo_item>-path     = <ls_status>-path.
      ENDAT.

      IF <ls_status>-filename IS NOT INITIAL.
        ls_file-path       = <ls_status>-path.
        ls_file-filename   = <ls_status>-filename.
        ls_file-is_changed = boolc( <ls_status>-match = abap_false ). " TODO refactor
        ls_file-rstate     = <ls_status>-rstate.
        ls_file-lstate     = <ls_status>-lstate.
        APPEND ls_file TO <ls_repo_item>-files.

        IF <ls_status>-inactive = abap_true
            AND <ls_repo_item>-sortkey > c_sortkey-changed.
          <ls_repo_item>-sortkey = c_sortkey-inactive.
        ENDIF.

        IF ls_file-is_changed = abap_true.
          <ls_repo_item>-sortkey = c_sortkey-changed. " Changed files
          <ls_repo_item>-changes = <ls_repo_item>-changes + 1.

          zcl_abapgit_state=>reduce( EXPORTING iv_cur = ls_file-lstate
                                     CHANGING cv_prev = <ls_repo_item>-lstate ).
          zcl_abapgit_state=>reduce( EXPORTING iv_cur = ls_file-rstate
                                     CHANGING cv_prev = <ls_repo_item>-rstate ).
        ENDIF.
      ENDIF.

      AT END OF obj_name. "obj_type + obj_name
        IF <ls_repo_item>-obj_type IS INITIAL.
          <ls_repo_item>-sortkey = c_sortkey-orphan. "Virtual objects
        ENDIF.
      ENDAT.
    ENDLOOP.

  ENDMETHOD.