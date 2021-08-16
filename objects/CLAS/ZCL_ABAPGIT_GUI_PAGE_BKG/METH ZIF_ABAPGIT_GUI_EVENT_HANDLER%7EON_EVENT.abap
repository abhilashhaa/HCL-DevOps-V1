  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA ls_fields TYPE zcl_abapgit_persist_background=>ty_background.

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-bg_update.
        ls_fields = decode( ii_event->mv_getdata ).
        update( ls_fields ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.