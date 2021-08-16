  METHOD render_scripts.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->set_title( cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ) ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_palette( zif_abapgit_definitions=>c_action-go_repo ) ).

  ENDMETHOD.