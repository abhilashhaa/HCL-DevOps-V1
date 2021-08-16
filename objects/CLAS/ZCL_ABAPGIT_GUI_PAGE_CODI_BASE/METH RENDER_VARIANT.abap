  METHOD render_variant.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div class="ci-head">' ).
    ri_html->add( |Code inspector check variant: <span class="ci-variant">{ iv_variant }</span>| ).
    ri_html->add( `</div>` ).

  ENDMETHOD.