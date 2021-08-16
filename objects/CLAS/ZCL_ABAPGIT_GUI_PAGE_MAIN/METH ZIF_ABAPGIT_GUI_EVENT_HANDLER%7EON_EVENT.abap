  METHOD zif_abapgit_gui_event_handler~on_event.

    DATA: lv_key TYPE zif_abapgit_persistence=>ty_value.

    CASE ii_event->mv_action.
      WHEN c_actions-abapgit_home.
        CLEAR mv_repo_key.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN c_actions-select.

        lv_key = ii_event->query( iv_upper_cased = abap_true )->get( 'KEY' ).
        zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( lv_key ).

        TRY.
            zcl_abapgit_repo_srv=>get_instance( )->get( lv_key )->refresh( ).
          CATCH zcx_abapgit_exception ##NO_HANDLER.
        ENDTRY.

        mv_repo_key = lv_key.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_view_repo
          EXPORTING
            iv_key = lv_key.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN zif_abapgit_definitions=>c_action-change_order_by.

        mo_repo_overview->set_order_by( ii_event->query( )->get( 'ORDERBY' ) ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN zif_abapgit_definitions=>c_action-direction.

        mo_repo_overview->set_order_direction(
          boolc( ii_event->query( )->get( 'DIRECTION' ) = 'DESCENDING' ) ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN c_actions-apply_filter.

        mo_repo_overview->set_filter( ii_event->mt_postdata ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.

      WHEN zif_abapgit_definitions=>c_action-go_patch.

        lv_key = ii_event->query( )->get( 'KEY' ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_patch
          EXPORTING
            iv_key = lv_key.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN zif_abapgit_definitions=>c_action-repo_settings.

        lv_key = ii_event->query( iv_upper_cased = abap_true )->get( 'KEY' ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_repo_sett
          EXPORTING
            io_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN OTHERS.

        rs_handled = super->zif_abapgit_gui_event_handler~on_event( ii_event ).

    ENDCASE.

  ENDMETHOD.