  METHOD zif_abapgit_gui_services~register_event_handler.
    ASSERT ii_event_handler IS BOUND.
    INSERT ii_event_handler INTO mt_event_handlers INDEX 1.
  ENDMETHOD.