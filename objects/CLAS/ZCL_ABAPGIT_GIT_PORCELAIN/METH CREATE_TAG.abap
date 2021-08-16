  METHOD create_tag.

    IF is_tag-name CS ` `.
      zcx_abapgit_exception=>raise( 'Tag name cannot contain blank spaces' ).
    ENDIF.

    CASE is_tag-type.
      WHEN zif_abapgit_definitions=>c_git_branch_type-annotated_tag.

        create_annotated_tag(
          is_tag = is_tag
          iv_url = iv_url ).

      WHEN zif_abapgit_definitions=>c_git_branch_type-lightweight_tag.

        create_lightweight_tag(
          is_tag = is_tag
          iv_url = iv_url ).

      WHEN OTHERS.

        zcx_abapgit_exception=>raise( |Invalid tag type: { is_tag-type }| ).

    ENDCASE.

  ENDMETHOD.