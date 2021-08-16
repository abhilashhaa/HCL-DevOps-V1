  METHOD get_tags_only.
    FIELD-SYMBOLS <ls_branch> LIKE LINE OF mt_branches.

    LOOP AT mt_branches ASSIGNING <ls_branch>
        WHERE type = zif_abapgit_definitions=>c_git_branch_type-lightweight_tag
        OR type = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.
      APPEND <ls_branch> TO rt_tags.
    ENDLOOP.

  ENDMETHOD.