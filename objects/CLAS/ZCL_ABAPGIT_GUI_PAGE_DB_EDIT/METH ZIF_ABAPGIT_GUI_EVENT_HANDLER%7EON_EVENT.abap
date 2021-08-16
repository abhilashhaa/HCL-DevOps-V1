  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: ls_db TYPE zif_abapgit_persistence=>ty_content.

    CASE ii_event->mv_action.
      WHEN c_action-update.
        ls_db = dbcontent_decode( ii_event->mt_postdata ).
        update( ls_db ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.
      WHEN OTHERS.
        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).
    ENDCASE.

  ENDMETHOD.