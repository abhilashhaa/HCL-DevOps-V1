  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="toc">' ).
    ri_html->add( body( ) ).
    ri_html->add( '</div>' ).

  ENDMETHOD.