  METHOD complete_heads_branch_name.
    IF iv_branch_name CP zif_abapgit_definitions=>c_git_branch-heads.
      rv_name = iv_branch_name.
    ELSE.
      rv_name = zif_abapgit_definitions=>c_git_branch-heads_prefix && iv_branch_name.
    ENDIF.
  ENDMETHOD.