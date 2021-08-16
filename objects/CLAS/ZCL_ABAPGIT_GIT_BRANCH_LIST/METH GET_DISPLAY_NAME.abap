  METHOD get_display_name.
    rv_display_name = iv_branch_name.

    IF rv_display_name CP zif_abapgit_definitions=>c_git_branch-heads.
      REPLACE FIRST OCCURRENCE OF zif_abapgit_definitions=>c_git_branch-heads_prefix IN rv_display_name WITH ''.
    ELSEIF rv_display_name CP zif_abapgit_definitions=>c_git_branch-tags.
      REPLACE FIRST OCCURRENCE OF zif_abapgit_definitions=>c_git_branch-prefix IN rv_display_name WITH ''.
    ENDIF.

  ENDMETHOD.