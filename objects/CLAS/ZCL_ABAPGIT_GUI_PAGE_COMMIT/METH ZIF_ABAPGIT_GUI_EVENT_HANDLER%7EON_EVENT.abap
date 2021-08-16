  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_action-commit_post.

        parse_commit_request(
          EXPORTING it_postdata = ii_event->mt_postdata
          IMPORTING eg_fields   = ms_commit ).

        ms_commit-repo_key = mo_repo->get_key( ).

        zcl_abapgit_services_git=>commit(
          is_commit = ms_commit
          io_repo   = mo_repo
          io_stage  = mo_stage ).

        MESSAGE 'Commit was successful' TYPE 'S'.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back_to_bookmark.

      WHEN c_action-commit_cancel.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.

      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.