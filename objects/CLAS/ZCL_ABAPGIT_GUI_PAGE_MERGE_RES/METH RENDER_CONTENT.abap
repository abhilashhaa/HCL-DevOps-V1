  METHOD render_content.

    resolve_diff( ).
    IF ms_diff_file IS INITIAL.
      zcx_abapgit_exception=>raise( 'no conflict found' ).
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<div id="diff-list" data-repo-key="{ mo_repo->get_key( ) }">| ).
    ri_html->add( render_diff( ms_diff_file ) ).
    ri_html->add( '</div>' ).

  ENDMETHOD.