  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_action-save_settings.
        save( ii_event->mt_postdata ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.
      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).

    ENDCASE.

  ENDMETHOD.