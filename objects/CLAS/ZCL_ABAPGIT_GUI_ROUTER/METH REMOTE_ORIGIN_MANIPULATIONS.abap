  METHOD remote_origin_manipulations.

    DATA lv_key TYPE zif_abapgit_persistence=>ty_repo-key.


    lv_key = ii_event->query( )->get( 'KEY' ).

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-repo_remote_attach.            " Remote attach
        zcl_abapgit_services_repo=>remote_attach( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_remote_detach.            " Remote detach
        zcl_abapgit_services_repo=>remote_detach( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_remote_change.            " Remote change
        zcl_abapgit_services_repo=>remote_change( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
    ENDCASE.

  ENDMETHOD.