  METHOD render_js_error_banner.
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( '<div id="js-error-banner" class="dummydiv error">' ).
    ri_html->add( |{ ri_html->icon( 'exclamation-triangle/red' ) }| &&
                  ' If this does not disappear soon,' &&
                  ' then there is a JS init error, please log an issue' ).
    ri_html->add( '</div>' ).
  ENDMETHOD.