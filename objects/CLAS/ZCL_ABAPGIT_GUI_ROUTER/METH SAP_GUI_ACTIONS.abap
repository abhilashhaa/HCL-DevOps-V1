  METHOD sap_gui_actions.

    DATA: ls_item TYPE zif_abapgit_definitions=>ty_item.

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-jump.                          " Open object editor
        ls_item-obj_type = ii_event->query( )->get( 'TYPE' ).
        ls_item-obj_name = ii_event->query( )->get( 'NAME' ).
        zcl_abapgit_objects=>jump( ls_item ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

      WHEN zif_abapgit_definitions=>c_action-jump_transport.
        jump_display_transport( |{ ii_event->query( )->get( 'TRANSPORT' ) }| ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

      WHEN zif_abapgit_definitions=>c_action-url.
        call_browser( ii_event->query( )->get( 'URL' ) ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

    ENDCASE.

  ENDMETHOD.