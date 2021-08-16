  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="repo">' ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top(
      io_repo         = mo_repo
      iv_show_package = abap_false
      iv_branch       = mo_repo->get_branch_name( ) ) ).

    ri_html->add( render_menu( ) ).
    ri_html->add( render_form( ) ).
    ri_html->add( render_stage( ) ).
    ri_html->add( '</div>' ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.