  METHOD footer.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="footer">' ).
    ri_html->add( '<table class="w100"><tr>' ).

    ri_html->add( '<td class="w40"></td>' ).  " spacer

    ri_html->add( '<td class="center">' ).
    ri_html->add( '<div class="logo">' ).
    ri_html->add( ri_html->icon( 'git-alt' ) ).
    ri_html->add( ri_html->icon( 'abapgit' ) ).
    ri_html->add( '</div>' ).
    ri_html->add( |<div class="version">{ zif_abapgit_version=>gc_abap_version }</div>| ).
    ri_html->add( '</td>' ).

    ri_html->add( '<td id="debug-output" class="w40"></td>' ).

    ri_html->add( '</tr></table>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.