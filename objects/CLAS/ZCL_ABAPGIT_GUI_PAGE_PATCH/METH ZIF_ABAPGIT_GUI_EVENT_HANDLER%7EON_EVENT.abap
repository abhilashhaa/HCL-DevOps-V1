  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_actions-stage.

        start_staging( ii_event->mt_postdata ).

        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_commit
          EXPORTING
            io_repo  = mo_repo_online
            io_stage = mo_stage.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN OTHERS.

        FIND FIRST OCCURRENCE OF REGEX |^{ c_actions-refresh }| IN ii_event->mv_action.
        IF sy-subrc = 0.

          apply_patch_from_form_fields( ii_event->mt_postdata ).
          refresh( ii_event->mv_action ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

        ELSE.

          rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).

        ENDIF.

    ENDCASE.

  ENDMETHOD.