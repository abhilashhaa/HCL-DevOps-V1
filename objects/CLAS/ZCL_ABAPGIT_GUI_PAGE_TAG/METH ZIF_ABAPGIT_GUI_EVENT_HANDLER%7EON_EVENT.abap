  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_action-commit_post.

        create_tag( ii_event->mt_postdata ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.

      WHEN c_action-change_tag_type.

        parse_change_tag_type_request( ii_event->mt_postdata ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_action-commit_cancel.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.

    ENDCASE.

  ENDMETHOD.