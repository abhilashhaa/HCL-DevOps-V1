  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA lv_path TYPE string.
    DATA lv_switched TYPE abap_bool.

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-go_repo. " Switch to another repo
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_view_repo
          EXPORTING
            iv_key = |{ ii_event->query( iv_upper_cased = abap_true )->get( 'KEY' ) }|.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_replacing.

      WHEN c_actions-toggle_hide_files. " Toggle file diplay
        mv_hide_files    = zcl_abapgit_persistence_user=>get_instance( )->toggle_hide_files( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-change_dir.        " Change dir
        lv_path         = ii_event->query( )->get( 'PATH' ).
        mv_cur_dir      = zcl_abapgit_path=>change_dir(
          iv_cur_dir = mv_cur_dir
          iv_cd      = lv_path ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-toggle_folders.    " Toggle folder view
        mv_show_folders = boolc( mv_show_folders <> abap_true ).
        mv_cur_dir      = '/'. " Root
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-toggle_changes.    " Toggle changes only view
        mv_changes_only = zcl_abapgit_persistence_user=>get_instance( )->toggle_changes_only( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-toggle_diff_first.
        mv_diff_first = boolc( mv_diff_first = abap_false ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-display_more.      " Increase MAX lines limit
        mv_max_lines    = mv_max_lines + mv_max_setting.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN zif_abapgit_definitions=>c_action-change_order_by.
        mv_order_by      = ii_event->query( )->get( 'ORDERBY' ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN zif_abapgit_definitions=>c_action-direction.
        mv_order_descending = boolc( ii_event->query( )->get( 'DIRECTION' ) = 'DESCENDING' ).
        rs_handled-state    = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN zif_abapgit_definitions=>c_action-repo_open_in_master_lang.
        open_in_master_language( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-repo_switch_origin_to_pr.
        lv_switched = switch_to_pr( ).
        IF lv_switched = abap_true.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
        ELSE.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
        ENDIF.

      WHEN c_actions-repo_reset_origin.
        switch_to_pr( iv_revert = abap_true ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN OTHERS.

        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ). " TODO refactor, move to HOC components

    ENDCASE.

  ENDMETHOD.