  METHOD render_item_lock_column.

    DATA li_cts_api          TYPE REF TO zif_abapgit_cts_api.
    DATA lv_transport        TYPE trkorr.
    DATA lv_transport_string TYPE string.
    DATA lv_icon_html        TYPE string.
    DATA li_html             TYPE REF TO zif_abapgit_html.

    CREATE OBJECT li_html TYPE zcl_abapgit_html.

    li_cts_api = zcl_abapgit_factory=>get_cts_api( ).

    TRY.
        IF is_item-obj_type IS INITIAL OR is_item-obj_name IS INITIAL OR
           li_cts_api->is_object_type_lockable( is_item-obj_type ) = abap_false OR
           li_cts_api->is_object_locked_in_transport( iv_object_type = is_item-obj_type
                                                      iv_object_name = is_item-obj_name ) = abap_false.
          rv_html = |<td class="icon"></td>|.
        ELSE.
          lv_transport = li_cts_api->get_current_transport_for_obj( iv_object_type             = is_item-obj_type
                                                                    iv_object_name             = is_item-obj_name
                                                                    iv_resolve_task_to_request = abap_false ).
          lv_transport_string = lv_transport.
          lv_icon_html = li_html->a(
            iv_txt = li_html->icon( iv_name = 'briefcase/darkgrey'
                                    iv_hint = lv_transport_string )
            iv_act = |{ zif_abapgit_definitions=>c_action-jump_transport }?transport={ lv_transport }| ).

          rv_html = |<td class="icon">| &&
                    |{ lv_icon_html }| &&
                    |</td>|.
        ENDIF.
      CATCH zcx_abapgit_exception.
        ASSERT 1 = 2.
    ENDTRY.
  ENDMETHOD.