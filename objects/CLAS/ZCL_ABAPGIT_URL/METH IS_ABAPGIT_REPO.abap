  METHOD is_abapgit_repo.

    IF iv_url CS 'github.com' AND ( iv_url CP '*/abapGit' OR iv_url CP '*/abapGit.git' ).
      rv_abapgit = abap_true.
    ENDIF.

  ENDMETHOD.