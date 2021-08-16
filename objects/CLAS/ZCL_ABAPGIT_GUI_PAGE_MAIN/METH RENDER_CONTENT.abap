  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    gui_services( )->get_hotkeys_ctl( )->register_hotkeys( me ).

    IF mo_repo_overview IS INITIAL.
      CREATE OBJECT mo_repo_overview TYPE zcl_abapgit_gui_repo_over.
    ENDIF.

    ri_html->add( mo_repo_overview->zif_abapgit_gui_renderable~render( ) ).

    register_deferred_script( zcl_abapgit_gui_chunk_lib=>render_repo_palette( c_actions-select ) ).

  ENDMETHOD.