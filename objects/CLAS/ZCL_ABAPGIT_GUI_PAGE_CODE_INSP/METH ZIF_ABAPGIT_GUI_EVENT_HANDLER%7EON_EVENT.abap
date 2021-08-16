  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: lo_repo_online TYPE REF TO zcl_abapgit_repo_online.

    CASE ii_event->mv_action.
      WHEN c_actions-stage.

        lo_repo_online ?= mo_repo.

        IF is_stage_allowed( ) = abap_true.
          " we need to refresh as the source might have changed
          lo_repo_online->refresh( ).

          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_stage
            EXPORTING
              io_repo = lo_repo_online.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

        ELSE.

          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

        ENDIF.

      WHEN c_actions-commit.

        lo_repo_online ?= mo_repo.

        IF is_stage_allowed( ) = abap_true.

          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_commit
            EXPORTING
              io_repo  = lo_repo_online
              io_stage = mo_stage.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

        ELSE.

          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

        ENDIF.

      WHEN c_actions-rerun.

        run_code_inspector( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.