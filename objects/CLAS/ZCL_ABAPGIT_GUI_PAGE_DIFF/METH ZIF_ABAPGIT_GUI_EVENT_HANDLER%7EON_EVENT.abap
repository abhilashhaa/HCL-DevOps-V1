  METHOD zif_abapgit_gui_event_handler~on_event.

    CASE ii_event->mv_action.
      WHEN c_actions-toggle_unified. " Toggle file diplay

        mv_unified = zcl_abapgit_persistence_user=>get_instance( )->toggle_diff_unified( ).
        rs_handled-state   = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN OTHERS.

        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).

    ENDCASE.

  ENDMETHOD.