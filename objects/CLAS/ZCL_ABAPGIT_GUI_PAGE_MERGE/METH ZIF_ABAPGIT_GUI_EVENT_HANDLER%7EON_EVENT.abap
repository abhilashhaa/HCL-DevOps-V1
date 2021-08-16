  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_actions-merge.
        IF mo_merge->has_conflicts( ) = abap_true.
          zcx_abapgit_exception=>raise( 'conflicts exists' ).
        ENDIF.

        IF mo_merge->get_result( )-stage->count( ) = 0.
          zcx_abapgit_exception=>raise( 'nothing to merge' ).
        ENDIF.

        IF mo_repo->get_local_settings( )-code_inspector_check_variant IS NOT INITIAL.

          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_code_insp
            EXPORTING
              io_repo  = mo_repo
              io_stage = mo_merge->get_result( )-stage.

        ELSE.

          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_commit
            EXPORTING
              io_repo  = mo_repo
              io_stage = mo_merge->get_result( )-stage.

        ENDIF.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN c_actions-res_conflicts.

        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_merge_res
          EXPORTING
            io_repo       = mo_repo
            io_merge_page = me
            io_merge      = mo_merge.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.