  METHOD render_stage.

    DATA: lt_stage TYPE zif_abapgit_definitions=>ty_stage_tt.

    FIELD-SYMBOLS: <ls_stage> LIKE LINE OF lt_stage.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lt_stage = mo_stage->get_all( ).

    ri_html->add( '<table class="stage_tab">' ).
    ri_html->add( '<thead>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<th colspan="3">Staged Files</th>' ).
    ri_html->add( '</tr>' ).
    ri_html->add( '</thead>' ).

    ri_html->add( '<tbody>' ).
    LOOP AT lt_stage ASSIGNING <ls_stage>.
      ri_html->add( '<tr>' ).
      ri_html->add( '<td>' ).
      ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state(
        iv_lstate = <ls_stage>-status-lstate
        iv_rstate = <ls_stage>-status-rstate ) ).
      ri_html->add( '</td>' ).
      ri_html->add( '<td class="method">' ).
      ri_html->add( |<b>{ zcl_abapgit_stage=>method_description( <ls_stage>-method ) }</b>| ).
      ri_html->add( '</td>' ).
      ri_html->add( '<td>' ).
      ri_html->add( <ls_stage>-file-path && <ls_stage>-file-filename ).
      ri_html->add( '</td>' ).
      ri_html->add( '</tr>' ).
    ENDLOOP.
    ri_html->add( '</tbody>' ).

    ri_html->add( '</table>' ).

  ENDMETHOD.