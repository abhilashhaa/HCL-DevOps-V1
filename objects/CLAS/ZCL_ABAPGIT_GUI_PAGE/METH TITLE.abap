  METHOD title.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="header">' ).

    ri_html->add( '<div class="logo">' ).
    ri_html->add( ri_html->icon( 'git-alt' ) ).
    ri_html->add( ri_html->icon( 'abapgit' ) ).
    ri_html->add( '</div>' ).

    ri_html->add( |<div class="page-title"><span class="spacer">&#x25BA;</span>{ ms_control-page_title }</div>| ).

    IF ms_control-page_menu IS BOUND.
      ri_html->add( '<div class="float-right">' ).
      ri_html->add( ms_control-page_menu->render( iv_right = abap_true ) ).
      ri_html->add( '</div>' ).
    ENDIF.

    ri_html->add( '</div>' ).

  ENDMETHOD.