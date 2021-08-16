  METHOD render_head_line.

    DATA lo_toolbar TYPE REF TO zcl_abapgit_html_toolbar.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    lo_toolbar = build_head_menu( iv_lstate = iv_lstate
                                  iv_rstate = iv_rstate ).

    ri_html->add( '<div class="paddings">' ).
    ri_html->add( '<table class="w100"><tr>' ).

    IF mv_show_folders = abap_true.
      ri_html->add( |<td class="current_dir">{ mv_cur_dir }</td>| ).
    ENDIF.

    ri_html->add( '<td class="right">' ).
    ri_html->add( lo_toolbar->render( iv_right = abap_true ) ).
    ri_html->add( '</td>' ).
    ri_html->add( '</tr></table>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.