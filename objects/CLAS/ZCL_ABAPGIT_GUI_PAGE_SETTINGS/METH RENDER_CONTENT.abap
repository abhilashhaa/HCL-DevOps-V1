  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    read_settings( ).

    ri_html->add( render_form_begin( ) ).
    ri_html->add( render_section_begin( |Global Settings| ) ).
    ri_html->add( render_proxy( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_commit_msg( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_development_internals( ) ).
    ri_html->add( render_section_end( ) ).
    ri_html->add( render_section_begin( |User Specific Settings| ) ).
    ri_html->add( render_start_up( ) ).
    ri_html->add( render_max_lines( ) ).
    ri_html->add( render_icon_scaling( ) ).
    ri_html->add( render_ui_theme( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_adt_jump_enabled( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_parallel_proc( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_link_hints( ) ).
    ri_html->add( |<hr>| ).
    ri_html->add( render_hotkeys( ) ).
    ri_html->add( render_section_end( ) ).
    ri_html->add( render_form_end( ) ).

  ENDMETHOD.