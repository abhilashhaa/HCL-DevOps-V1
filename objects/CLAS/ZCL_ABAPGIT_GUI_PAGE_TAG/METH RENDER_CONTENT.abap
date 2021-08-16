  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="repo">' ).
    ri_html->add( render_menu( ) ).
    ri_html->add( render_form( ) ).
    ri_html->add( '</div>' ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.