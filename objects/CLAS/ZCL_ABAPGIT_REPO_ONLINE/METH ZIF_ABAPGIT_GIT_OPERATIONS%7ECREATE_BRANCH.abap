  METHOD zif_abapgit_git_operations~create_branch.

    DATA: lv_sha1 TYPE zif_abapgit_definitions=>ty_sha1.

    ASSERT iv_name CP zif_abapgit_definitions=>c_git_branch-heads.

    IF iv_from IS INITIAL.
      lv_sha1 = get_sha1_remote( ).
    ELSE.
      lv_sha1 = iv_from.
    ENDIF.

    zcl_abapgit_git_porcelain=>create_branch(
      iv_url  = get_url( )
      iv_name = iv_name
      iv_from = lv_sha1 ).

    " automatically switch to new branch
    set_branch_name( iv_name ).

  ENDMETHOD.