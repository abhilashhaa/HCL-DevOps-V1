  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( `<div class="repo">` ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( mo_repo ) ).
    ri_html->add( `</div>` ).

    IF mv_check_variant IS INITIAL.
      ri_html->add( zcl_abapgit_gui_chunk_lib=>render_error( iv_error = 'No check variant supplied.' ) ).
      RETURN.
    ENDIF.

    gui_services( )->get_hotkeys_ctl( )->register_hotkeys( me ).

    ri_html->add( render_variant( mv_check_variant ) ).

    IF lines( mt_result ) = 0.
      ri_html->add( '<div class="dummydiv success">' ).
      ri_html->add( ri_html->icon( 'check' ) ).
      ri_html->add( 'No code inspector findings' ).
      ri_html->add( '</div>' ).
    ELSE.
      render_result(
        ii_html   = ri_html
        it_result = mt_result ).
    ENDIF.

  ENDMETHOD.