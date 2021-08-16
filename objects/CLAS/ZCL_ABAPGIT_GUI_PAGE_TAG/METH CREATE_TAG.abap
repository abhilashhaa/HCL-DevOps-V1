  METHOD create_tag.

    DATA:
      ls_tag   TYPE zif_abapgit_definitions=>ty_git_tag,
      lx_error TYPE REF TO zcx_abapgit_exception,
      lv_text  TYPE string.

    parse_tag_request(
      EXPORTING it_postdata = it_postdata
      IMPORTING eg_fields   = ls_tag ).

    IF ls_tag-name IS INITIAL.
      zcx_abapgit_exception=>raise( |Please supply a tag name| ).
    ENDIF.

    ls_tag-name = zcl_abapgit_git_tag=>add_tag_prefix( ls_tag-name ).
    ASSERT ls_tag-name CP zif_abapgit_definitions=>c_git_branch-tags.

    CASE mv_selected_type.
      WHEN c_tag_type-lightweight.

        ls_tag-type = zif_abapgit_definitions=>c_git_branch_type-lightweight_tag.

      WHEN c_tag_type-annotated.

        ls_tag-type = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.

      WHEN OTHERS.

        zcx_abapgit_exception=>raise( |Invalid tag type: { mv_selected_type }| ).

    ENDCASE.

    TRY.
        zcl_abapgit_git_porcelain=>create_tag( iv_url = mo_repo_online->get_url( )
                                               is_tag = ls_tag ).

      CATCH zcx_abapgit_exception INTO lx_error.
        zcx_abapgit_exception=>raise( |Cannot create tag { ls_tag-name }. Error: '{ lx_error->get_text( ) }'| ).
    ENDTRY.

    IF ls_tag-type = zif_abapgit_definitions=>c_git_branch_type-lightweight_tag.
      lv_text = |Lightweight tag { zcl_abapgit_git_tag=>remove_tag_prefix( ls_tag-name ) } created|.
    ELSEIF ls_tag-type = zif_abapgit_definitions=>c_git_branch_type-annotated_tag.
      lv_text = |Annotated tag { zcl_abapgit_git_tag=>remove_tag_prefix( ls_tag-name ) } created|.
    ENDIF.

    MESSAGE lv_text TYPE 'S'.

  ENDMETHOD.