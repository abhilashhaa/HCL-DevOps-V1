  METHOD render_content.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( `<div class="repo">` ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( mo_repo ) ).
    ri_html->add( `</div>` ).

    ri_html->add( '<div class="toc">' ).

    ri_html->add( render_variant( c_variant ) ).

    IF lines( mt_result ) = 0.
      ri_html->add( '<div class="dummydiv success">' ).
      ri_html->add( ri_html->icon( 'check' ) ).
      ri_html->add( 'No syntax errors' ).
      ri_html->add( '</div>' ).
    ELSE.
      render_result( ii_html   = ri_html
                     it_result = mt_result ).
    ENDIF.

  ENDMETHOD.