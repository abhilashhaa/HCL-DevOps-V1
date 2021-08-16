  METHOD determine_tags.

    DATA: lv_tag TYPE LINE OF zif_abapgit_definitions=>ty_commit-tags.

    FIELD-SYMBOLS: <ls_tag>    LIKE LINE OF mt_tags,
                   <ls_commit> LIKE LINE OF mt_commits.

    LOOP AT mt_tags ASSIGNING <ls_tag>.

      IF <ls_tag>-type = zif_abapgit_definitions=>c_git_branch_type-lightweight_tag.
        READ TABLE mt_commits WITH KEY sha1 = <ls_tag>-sha1
                              ASSIGNING <ls_commit>.      "#EC CI_SUBRC
      ELSEIF <ls_tag>-type = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.
        READ TABLE mt_commits WITH KEY sha1 = <ls_tag>-object
                              ASSIGNING <ls_commit>.
      ENDIF.

      CHECK sy-subrc = 0.

      lv_tag = zcl_abapgit_git_tag=>remove_tag_prefix( <ls_tag>-name ).
      INSERT lv_tag INTO TABLE <ls_commit>-tags.

    ENDLOOP.

  ENDMETHOD.