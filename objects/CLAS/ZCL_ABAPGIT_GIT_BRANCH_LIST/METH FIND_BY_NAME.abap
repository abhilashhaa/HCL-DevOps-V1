  METHOD find_by_name.

    IF iv_branch_name IS INITIAL.
      zcx_abapgit_exception=>raise( 'Branch name empty' ).
    ENDIF.

    IF iv_branch_name CP zif_abapgit_definitions=>c_git_branch-tags.
      rs_branch = find_tag_by_name( iv_branch_name ).
    ELSE.

      READ TABLE mt_branches INTO rs_branch
        WITH KEY name = iv_branch_name.
      IF sy-subrc <> 0.
        zcx_abapgit_exception=>raise( |Branch { get_display_name( iv_branch_name )
          } not found. Use 'Branch' > 'Switch' to select a different branch| ).
      ENDIF.

    ENDIF.

  ENDMETHOD.