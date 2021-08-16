  METHOD render_merge.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<form id="commit_form" method="post" action="sapevent:merge">' ).
    ri_html->add( 'Merge' ).
    ri_html->add( form_select( 'source' ) ).
    ri_html->add( 'into' ).
    ri_html->add( form_select( 'target' ) ).
    ri_html->add( '<input type="submit" value="Submit">' ).
    ri_html->add( '</form>' ).

  ENDMETHOD.