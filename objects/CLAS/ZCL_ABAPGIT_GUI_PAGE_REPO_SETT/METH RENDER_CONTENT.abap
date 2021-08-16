  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( `<div class="repo">` ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( mo_repo ) ).
    ri_html->add( `</div>` ).

    ri_html->add( '<div class="settings_container">' ).
    ri_html->add( |<form id="settings_form" method="post" action="sapevent:{ c_action-save_settings }">| ).

    render_dot_abapgit( ri_html ).
    IF mo_repo->is_offline( ) = abap_false.
      render_remotes( ri_html ).
    ENDIF.
    render_local_settings( ri_html ).

    ri_html->add( '<input type="submit" value="Save" class="floating-button blue-set emphasis">' ).
    ri_html->add( '</form>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.