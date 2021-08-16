  METHOD get_branches_only.
    FIELD-SYMBOLS <ls_branch> LIKE LINE OF mt_branches.

    LOOP AT mt_branches ASSIGNING <ls_branch>.
      IF <ls_branch>-type = zif_abapgit_definitions=>c_git_branch_type-branch.
        APPEND <ls_branch> TO rt_branches.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.