  METHOD render_branch_span.

    DATA: lv_text  TYPE string,
          lv_class TYPE string.

    lv_text = zcl_abapgit_git_branch_list=>get_display_name( iv_branch ).

    IF zcl_abapgit_git_branch_list=>get_type( iv_branch ) = zif_abapgit_definitions=>c_git_branch_type-branch.
      lv_class = 'branch branch_branch'.
    ELSE.
      lv_class = 'branch'.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<span class="{ lv_class }">| ).
    ri_html->add_icon( iv_name = 'code-branch/grey70'
                       iv_hint = 'Current branch' ).
    IF iv_interactive = abap_true.
      ri_html->add_a( iv_act = |{ zif_abapgit_definitions=>c_action-git_branch_switch }?key={ io_repo->get_key( ) }|
                      iv_txt = lv_text ).
    ELSE.
      ri_html->add( lv_text ).
    ENDIF.
    ri_html->add( '</span>' ).

  ENDMETHOD.