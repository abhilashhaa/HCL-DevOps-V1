  METHOD refresh.

    mi_branch_overview = zcl_abapgit_factory=>get_branch_overview( mo_repo ).

    mt_commits = mi_branch_overview->get_commits( ).
    IF mv_compress = abap_true.
      mt_commits = mi_branch_overview->compress( mt_commits ).
    ENDIF.

  ENDMETHOD.