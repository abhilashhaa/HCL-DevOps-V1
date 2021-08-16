  METHOD parse_annotated_tags.

    DATA: ls_raw TYPE zcl_abapgit_git_pack=>ty_tag.

    FIELD-SYMBOLS: <ls_object> LIKE LINE OF it_objects,
                   <ls_tag>    LIKE LINE OF mt_tags.

    LOOP AT it_objects ASSIGNING <ls_object> USING KEY type
        WHERE type = zif_abapgit_definitions=>c_type-tag.

      ls_raw = zcl_abapgit_git_pack=>decode_tag( <ls_object>-data ).

      READ TABLE mt_tags ASSIGNING <ls_tag>
                         WITH KEY sha1 = <ls_object>-sha1.
      ASSERT sy-subrc = 0.

      <ls_tag>-name         = zif_abapgit_definitions=>c_git_branch-tags_prefix && ls_raw-tag.
      <ls_tag>-sha1         = <ls_object>-sha1.
      <ls_tag>-object       = ls_raw-object.
      <ls_tag>-type         = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.
      <ls_tag>-display_name = ls_raw-tag.
      <ls_tag>-tagger_name  = ls_raw-tagger_name.
      <ls_tag>-tagger_email = ls_raw-tagger_email.
      <ls_tag>-message      = ls_raw-message.
      <ls_tag>-body         = ls_raw-body.

    ENDLOOP.

  ENDMETHOD.