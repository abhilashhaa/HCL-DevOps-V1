  METHOD get_sha1_remote.
    fetch_remote( ).
    rv_sha1 = mv_branch.
  ENDMETHOD.