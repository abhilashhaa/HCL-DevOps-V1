  METHOD delete_branch.

    DATA: lv_pack TYPE xstring.


* "client MUST send an empty packfile"
* https://github.com/git/git/blob/master/Documentation/technical/pack-protocol.txt#L514

    zcl_abapgit_git_transport=>receive_pack(
      iv_url         = iv_url
      iv_old         = is_branch-sha1
      iv_new         = c_zero
      iv_branch_name = is_branch-name
      iv_pack        = lv_pack ).

  ENDMETHOD.