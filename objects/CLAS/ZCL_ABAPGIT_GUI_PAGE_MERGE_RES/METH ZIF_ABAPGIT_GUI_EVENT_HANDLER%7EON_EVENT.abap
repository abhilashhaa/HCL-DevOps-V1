  METHOD zif_abapgit_gui_event_handler~on_event.

    FIELD-SYMBOLS: <ls_conflict> TYPE zif_abapgit_definitions=>ty_merge_conflict.

    CASE ii_event->mv_action.
      WHEN c_actions-apply_merge
        OR c_actions-apply_source
        OR c_actions-apply_target
        OR c_actions-cancel.

        CASE ii_event->mv_action.
          WHEN c_actions-apply_merge.
            apply_merged_content( ii_event->mt_postdata ).

          WHEN c_actions-apply_source.
            READ TABLE mt_conflicts ASSIGNING <ls_conflict> INDEX mv_current_conflict_index.
            <ls_conflict>-result_sha1 = <ls_conflict>-source_sha1.
            <ls_conflict>-result_data = <ls_conflict>-source_data.
            mo_merge->resolve_conflict( <ls_conflict> ).

          WHEN c_actions-apply_target.
            READ TABLE mt_conflicts ASSIGNING <ls_conflict> INDEX mv_current_conflict_index.
            <ls_conflict>-result_sha1 = <ls_conflict>-target_sha1.
            <ls_conflict>-result_data = <ls_conflict>-target_data.
            mo_merge->resolve_conflict( <ls_conflict> ).

        ENDCASE.

        mv_current_conflict_index = mv_current_conflict_index + 1.
        IF mv_current_conflict_index > lines( mt_conflicts ).
          CLEAR mv_current_conflict_index.
        ENDIF.

        IF mv_current_conflict_index IS NOT INITIAL.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
        ELSE.
          rs_handled-page = mo_merge_page.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.
        ENDIF.

      WHEN c_actions-toggle_mode.
        toggle_merge_mode( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

    ENDCASE.

  ENDMETHOD.