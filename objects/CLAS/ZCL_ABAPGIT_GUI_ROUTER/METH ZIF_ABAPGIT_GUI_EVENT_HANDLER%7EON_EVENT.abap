  METHOD zif_abapgit_gui_event_handler~on_event.


    rs_handled = general_page_routing( ii_event ).
    IF rs_handled-state IS INITIAL.
      rs_handled = repository_services( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = git_services( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = zip_services( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = db_actions( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = abapgit_services_actions( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = remote_origin_manipulations( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = sap_gui_actions( ii_event ).
    ENDIF.
    IF rs_handled-state IS INITIAL.
      rs_handled = other_utilities( ii_event ).
    ENDIF.

    IF rs_handled-state IS INITIAL.
      rs_handled-state = zcl_abapgit_gui=>c_event_state-not_handled.
    ENDIF.

  ENDMETHOD.