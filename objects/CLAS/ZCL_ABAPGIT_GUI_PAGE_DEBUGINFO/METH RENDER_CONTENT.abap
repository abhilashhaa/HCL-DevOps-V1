  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="debug_info" class="debug_container">' ).
    ri_html->add( render_debug_info( ) ).
    ri_html->add( '</div>' ).

    ri_html->add( '<div id="supported_objects" class="debug_container">' ).
    ri_html->add( render_supported_object_types( ) ).
    ri_html->add( '</div>' ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.