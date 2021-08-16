  METHOD zif_abapgit_gui_event_handler~on_event.
* todo, check input values eg INT

    DATA:
      lt_post_fields TYPE tihttpnvp.

    CASE ii_event->mv_action.
      WHEN c_action-save_settings.
        lt_post_fields = zcl_abapgit_html_action_utils=>parse_post_form_data( ii_event->mt_postdata ).

        post( lt_post_fields ).
        validate_settings( ).

        IF mv_error = abap_true.
          MESSAGE 'Error when saving settings. Open an issue at https://github.com/abapGit/abapGit' TYPE 'E'.
        ELSE.
          persist_settings( ).
        ENDIF.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.
      WHEN c_action-change_proxy_bypass.
        mt_proxy_bypass = zcl_abapgit_ui_factory=>get_popups( )->popup_proxy_bypass( mt_proxy_bypass ).

        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
    ENDCASE.

  ENDMETHOD.