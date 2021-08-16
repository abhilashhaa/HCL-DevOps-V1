  METHOD render_file.

    DATA: lv_param            TYPE string,
          lv_filename         TYPE string,
          lv_transport_string TYPE string,
          lv_transport_html   TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    lv_transport_string = iv_transport.

    lv_filename = is_file-path && is_file-filename.
* make sure whitespace is preserved in the DOM
    REPLACE ALL OCCURRENCES OF ` ` IN lv_filename WITH '&nbsp;'.

    ri_html->add( |<tr class="{ iv_context }">| ).
    ri_html->add( '<td>' ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_item_state(
      iv_lstate = is_status-lstate
      iv_rstate = is_status-rstate ) ).
    ri_html->add( '</td>' ).

    CASE iv_context.
      WHEN 'local'.
        lv_param = zcl_abapgit_html_action_utils=>file_encode(
          iv_key  = mo_repo->get_key( )
          ig_file = is_file ).

        lv_filename = ri_html->a(
          iv_txt = lv_filename
          iv_act = |{ zif_abapgit_definitions=>c_action-go_diff }?{ lv_param }| ).

        IF iv_transport IS NOT INITIAL.
          lv_transport_html = ri_html->a(
            iv_txt = lv_transport_string
            iv_act = |{ zif_abapgit_definitions=>c_action-jump_transport }?transport={ iv_transport }| ).
        ENDIF.
        ri_html->add( |<td class="type">{ is_item-obj_type }</td>| ).
        ri_html->add( |<td class="name">{ lv_filename }</td>| ).
        ri_html->add( |<td class="user">{ iv_changed_by }</td>| ).
        ri_html->add( |<td class="transport">{ lv_transport_html }</td>| ).
      WHEN 'remote'.
        ri_html->add( '<td class="type">-</td>' ).  " Dummy for object type
        ri_html->add( |<td class="name">{ lv_filename }</td>| ).
        ri_html->add( '<td></td>' ).                " Dummy for changed-by
        ri_html->add( '<td></td>' ).                " Dummy for transport
    ENDCASE.

    ri_html->add( |<td class="status">?</td>| ).
    ri_html->add( '<td class="cmd"></td>' ). " Command added in JS

    ri_html->add( '</tr>' ).

  ENDMETHOD.