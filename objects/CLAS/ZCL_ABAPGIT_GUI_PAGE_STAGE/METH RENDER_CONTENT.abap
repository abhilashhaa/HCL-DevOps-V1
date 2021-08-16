  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="repo">' ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( mo_repo ) ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_js_error_banner( ) ).
    ri_html->add( render_master_language_warning( ) ).

    ri_html->add( '<div class="stage-container">' ).
    ri_html->add( render_actions( ) ).
    ri_html->add( render_list( ) ).
    ri_html->add( '</div>' ).

    ri_html->add( '</div>' ).

    gui_services( )->get_hotkeys_ctl( )->register_hotkeys( me ).
    gui_services( )->get_html_parts( )->add_part(
      iv_collection = zcl_abapgit_gui_component=>c_html_parts-hidden_forms
      ii_part       = render_deferred_hidden_events( ) ).
    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.