  METHOD zif_abapgit_gui_renderable~render.

    mt_overview = map_repo_list_to_overview( zcl_abapgit_persist_factory=>get_repo( )->list( ) ).
    apply_order_by( CHANGING ct_overview = mt_overview ).
    apply_filter( CHANGING ct_overview = mt_overview ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    render_header_bar( ri_html ).
    render_table( ii_html     = ri_html
                  it_overview = mt_overview ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.