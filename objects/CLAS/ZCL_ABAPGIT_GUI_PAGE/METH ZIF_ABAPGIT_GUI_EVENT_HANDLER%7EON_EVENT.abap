  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-goto_source.

        IF mo_exception_viewer IS BOUND.
          mo_exception_viewer->goto_source( ).
        ENDIF.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

      WHEN zif_abapgit_definitions=>c_action-show_callstack.

        IF mo_exception_viewer IS BOUND.
          mo_exception_viewer->show_callstack( ).
        ENDIF.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

      WHEN zif_abapgit_definitions=>c_action-goto_message.

        IF mo_exception_viewer IS BOUND.
          mo_exception_viewer->goto_message( ).
        ENDIF.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

    ENDCASE.

  ENDMETHOD.