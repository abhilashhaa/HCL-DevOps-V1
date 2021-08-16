  METHOD get_agent.

* bitbucket require agent prefix = "git/"
* also see https://github.com/abapGit/abapGit/issues/1432
    rv_agent = |git/2.0 (abapGit { zif_abapgit_version=>gc_abap_version })|.

  ENDMETHOD.