  METHOD determine_merges.

    DATA: BEGIN OF ls_deleted_branch_info,
            created TYPE abap_bool,
            index   TYPE string,
            name    TYPE string,
          END OF ls_deleted_branch_info.

    FIELD-SYMBOLS: <ls_merged_branch_commit> TYPE zif_abapgit_definitions=>ty_commit,
                   <ls_merged_branch_parent> TYPE zif_abapgit_definitions=>ty_commit,
                   <ls_commit>               TYPE zif_abapgit_definitions=>ty_commit,
                   <ls_create>               TYPE zif_abapgit_definitions=>ty_create.

* we need latest first here: latest -> initial
    _reverse_sort_order( CHANGING ct_commits = mt_commits ).

    LOOP AT mt_commits ASSIGNING <ls_commit> WHERE NOT parent2 IS INITIAL.
      ASSERT NOT <ls_commit>-branch IS INITIAL.

      READ TABLE mt_commits ASSIGNING <ls_merged_branch_commit> WITH KEY sha1 = <ls_commit>-parent2.
      IF sy-subrc = 0.
        <ls_commit>-merge = <ls_merged_branch_commit>-branch.

* orphaned, branch has been deleted after merge
        ls_deleted_branch_info-created = abap_false.

        WHILE <ls_merged_branch_commit>-branch IS INITIAL.
          IF ls_deleted_branch_info-created = abap_false.

            ls_deleted_branch_info-created = abap_true.
            ls_deleted_branch_info-index = ls_deleted_branch_info-index + 1.
            ls_deleted_branch_info-name = c_deleted_branch_name_prefix && ls_deleted_branch_info-index && '__'.
            CONDENSE ls_deleted_branch_info-name NO-GAPS.

            <ls_commit>-merge = ls_deleted_branch_info-name.

          ENDIF.
          <ls_merged_branch_commit>-branch = ls_deleted_branch_info-name.

          READ TABLE mt_commits ASSIGNING <ls_merged_branch_parent>
                                WITH KEY sha1 = <ls_merged_branch_commit>-parent1.
          IF sy-subrc <> 0.
            EXIT.
          ELSE.
            ASSIGN <ls_merged_branch_parent> TO <ls_merged_branch_commit>.
          ENDIF.
        ENDWHILE.

        IF <ls_merged_branch_parent> IS ASSIGNED.
          APPEND INITIAL LINE TO <ls_merged_branch_parent>-create ASSIGNING <ls_create>.
          <ls_create>-name = ls_deleted_branch_info-name.
          <ls_create>-parent = <ls_commit>-branch.
        ENDIF.

      ENDIF.
    ENDLOOP.

    " switch back to initial -> latest
    _reverse_sort_order( CHANGING ct_commits = mt_commits ).

  ENDMETHOD.