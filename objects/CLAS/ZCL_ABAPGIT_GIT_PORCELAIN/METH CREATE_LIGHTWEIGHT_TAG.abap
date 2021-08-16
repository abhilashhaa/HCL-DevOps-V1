  METHOD create_lightweight_tag.

    DATA: lt_objects TYPE zif_abapgit_definitions=>ty_objects_tt,
          lv_pack    TYPE xstring.

* "client MUST send an empty packfile"
* https://github.com/git/git/blob/master/Documentation/technical/pack-protocol.txt#L514
    lv_pack = zcl_abapgit_git_pack=>encode( lt_objects ).

    zcl_abapgit_git_transport=>receive_pack(
      iv_url         = iv_url
      iv_old         = c_zero
      iv_new         = is_tag-sha1
      iv_branch_name = is_tag-name
      iv_pack        = lv_pack ).

  ENDMETHOD.