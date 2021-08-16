  METHOD get_type.

    DATA: lv_annotated_tag_with_suffix TYPE string.

    FIELD-SYMBOLS: <lv_result> TYPE LINE OF string_table.

    rv_type = zif_abapgit_definitions=>c_git_branch_type-other.

    IF iv_branch_name CP zif_abapgit_definitions=>c_git_branch-heads OR
       iv_branch_name = zif_abapgit_definitions=>c_head_name.
      rv_type = zif_abapgit_definitions=>c_git_branch_type-branch.

    ELSEIF iv_branch_name CP zif_abapgit_definitions=>c_git_branch-tags.

      lv_annotated_tag_with_suffix = iv_branch_name && '^{}'.

      READ TABLE it_result ASSIGNING <lv_result>
                           INDEX iv_current_row_index + 1.
      IF sy-subrc = 0 AND <lv_result> CP '*' && lv_annotated_tag_with_suffix.
        rv_type = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.
      ELSE.
        rv_type = zif_abapgit_definitions=>c_git_branch_type-lightweight_tag.
      ENDIF.

    ENDIF.

  ENDMETHOD.