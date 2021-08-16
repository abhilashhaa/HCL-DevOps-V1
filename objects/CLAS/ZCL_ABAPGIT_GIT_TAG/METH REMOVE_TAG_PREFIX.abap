  METHOD remove_tag_prefix.

    rv_text = iv_text.

    REPLACE FIRST OCCURRENCE OF zif_abapgit_definitions=>c_git_branch-tags_prefix
            IN rv_text
            WITH ''.

  ENDMETHOD.