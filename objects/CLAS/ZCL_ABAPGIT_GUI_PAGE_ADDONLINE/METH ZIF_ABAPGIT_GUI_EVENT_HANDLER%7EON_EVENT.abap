  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: ls_repo_params     TYPE zif_abapgit_services_repo=>ty_repo_params,
          lo_new_online_repo TYPE REF TO zcl_abapgit_repo_online.

    " import data from html before re-render
    mo_form_data = parse_form( zcl_abapgit_html_action_utils=>parse_post_form_data( ii_event->mt_postdata ) ).

    CASE ii_event->mv_action.
      WHEN c_event-go_back.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-go_back.

      WHEN c_event-create_package.

        mo_form_data->set(
          iv_key = c_id-package
          iv_val = zcl_abapgit_services_basis=>create_package(
            iv_prefill_package = |{ mo_form_data->get( 'package' ) }| ) ).
        IF mo_form_data->get( c_id-package ) IS NOT INITIAL.
          mo_validation_log = validate_form( mo_form_data ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
        ELSE.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
        ENDIF.

      WHEN c_event-choose_package.

        mo_form_data->set(
          iv_key = c_id-package
          iv_val = zcl_abapgit_ui_factory=>get_popups( )->popup_search_help( 'TDEVC-DEVCLASS' ) ).
        IF mo_form_data->get( c_id-package ) IS NOT INITIAL.
          mo_validation_log = validate_form( mo_form_data ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
        ELSE.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
        ENDIF.

      WHEN c_event-choose_branch.

        mo_validation_log = validate_form( mo_form_data ).
        IF mo_validation_log->has( c_id-url ) = abap_true.
          mo_validation_log->set(
            iv_key = c_id-branch_name
            iv_val = 'Check URL issues' ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render. " Display errors
          RETURN.
        ENDIF.
        mo_form_data->set(
          iv_key = c_id-branch_name
          iv_val = zcl_abapgit_ui_factory=>get_popups( )->branch_list_popup( mo_form_data->get( c_id-url ) )-name ).

        IF mo_form_data->get( c_id-branch_name ) IS INITIAL.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
        ELSE.
          mo_form_data->set(
            iv_key = c_id-branch_name
            iv_val = replace( " strip technical
              val = mo_form_data->get( c_id-branch_name )
              sub = zif_abapgit_definitions=>c_git_branch-heads_prefix
              with = '' ) ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
        ENDIF.

      WHEN c_event-add_online_repo.

        mo_validation_log = validate_form( mo_form_data ).

        IF mo_validation_log->is_empty( ) = abap_true.
          mo_form_data->to_abap( CHANGING cs_container = ls_repo_params ).
          lo_new_online_repo = zcl_abapgit_services_repo=>new_online( ls_repo_params ).
          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_view_repo
            EXPORTING
              iv_key = lo_new_online_repo->get_key( ).
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_replacing.
        ELSE.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render. " Display errors
        ENDIF.

    ENDCASE.

  ENDMETHOD.