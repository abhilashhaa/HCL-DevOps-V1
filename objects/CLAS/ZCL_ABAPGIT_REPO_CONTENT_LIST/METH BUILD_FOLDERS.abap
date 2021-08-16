  METHOD build_folders.

    DATA: lv_index    TYPE i,
          lt_subitems LIKE ct_repo_items,
          ls_subitem  LIKE LINE OF ct_repo_items,
          ls_folder   LIKE LINE OF ct_repo_items.

    FIELD-SYMBOLS <ls_item> LIKE LINE OF ct_repo_items.


    LOOP AT ct_repo_items ASSIGNING <ls_item>.
      lv_index = sy-tabix.
      CHECK <ls_item>-path <> iv_cur_dir. " files in target dir - just leave them be

      IF zcl_abapgit_path=>is_subdir( iv_path = <ls_item>-path
                                      iv_parent = iv_cur_dir ) = abap_true.
        ls_subitem-changes = <ls_item>-changes.
        ls_subitem-path    = <ls_item>-path.
        ls_subitem-lstate  = <ls_item>-lstate.
        ls_subitem-rstate  = <ls_item>-rstate.
        APPEND ls_subitem TO lt_subitems.
      ENDIF.

      DELETE ct_repo_items INDEX lv_index.
    ENDLOOP.

    SORT lt_subitems BY path ASCENDING.

    LOOP AT lt_subitems ASSIGNING <ls_item>.
      AT NEW path.
        CLEAR ls_folder.
        ls_folder-path    = <ls_item>-path.
        ls_folder-sortkey = c_sortkey-dir. " Directory
        ls_folder-is_dir  = abap_true.
      ENDAT.

      ls_folder-changes = ls_folder-changes + <ls_item>-changes.

      zcl_abapgit_state=>reduce( EXPORTING iv_cur = <ls_item>-lstate
                                 CHANGING cv_prev = ls_folder-lstate ).
      zcl_abapgit_state=>reduce( EXPORTING iv_cur = <ls_item>-rstate
                                 CHANGING cv_prev = ls_folder-rstate ).

      AT END OF path.
        APPEND ls_folder TO ct_repo_items.
      ENDAT.
    ENDLOOP.

  ENDMETHOD.