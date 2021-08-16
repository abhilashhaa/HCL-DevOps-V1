  METHOD receive_pack_create_tag.

    DATA: lv_tag          TYPE xstring,
          lt_objects      TYPE zif_abapgit_definitions=>ty_objects_tt,
          lv_pack         TYPE xstring,
          ls_object       LIKE LINE OF lt_objects,
          ls_tag          TYPE zcl_abapgit_git_pack=>ty_tag,
          lv_new_tag_sha1 TYPE zif_abapgit_definitions=>ty_sha1.

* new tag
    ls_tag-object       = is_tag-sha1.
    ls_tag-type         = zif_abapgit_definitions=>c_type-commit.
    ls_tag-tag          = is_tag-name.
    ls_tag-tagger_name  = is_tag-tagger_name.
    ls_tag-tagger_email = is_tag-tagger_email.
    ls_tag-message      = is_tag-message
                      && |{ zif_abapgit_definitions=>c_newline }|
                      && |{ zif_abapgit_definitions=>c_newline }|
                      && is_tag-body.

    lv_tag = zcl_abapgit_git_pack=>encode_tag( ls_tag ).

    lv_new_tag_sha1 = zcl_abapgit_hash=>sha1(
      iv_type = zif_abapgit_definitions=>c_type-tag
      iv_data = lv_tag ).

    ls_object-sha1 = lv_new_tag_sha1.
    ls_object-type = zif_abapgit_definitions=>c_type-tag.
    ls_object-data = lv_tag.
    ls_object-index = 1.
    APPEND ls_object TO lt_objects.

    lv_pack = zcl_abapgit_git_pack=>encode( lt_objects ).

    zcl_abapgit_git_transport=>receive_pack(
      iv_url         = iv_url
      iv_old         = c_zero
      iv_new         = lv_new_tag_sha1
      iv_branch_name = is_tag-name
      iv_pack        = lv_pack ).

  ENDMETHOD.