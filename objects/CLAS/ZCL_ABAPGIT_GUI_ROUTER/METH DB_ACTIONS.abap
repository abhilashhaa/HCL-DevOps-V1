  METHOD db_actions.

    DATA ls_db_key TYPE zif_abapgit_persistence=>ty_content.
    DATA lo_query TYPE REF TO zcl_abapgit_string_map.

    lo_query = ii_event->query( ).
    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-db_edit.
        lo_query->to_abap( CHANGING cs_container = ls_db_key ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_db_edit
          EXPORTING
            is_key = ls_db_key.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
        IF ii_event->mi_gui_services->get_current_page_name( ) = 'ZCL_ABAPGIT_GUI_PAGE_DB_DIS'. " TODO refactor
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_replacing.
        ENDIF.
      WHEN zif_abapgit_definitions=>c_action-db_display.
        lo_query->to_abap( CHANGING cs_container = ls_db_key ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_db_dis
          EXPORTING
            is_key = ls_db_key.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
    ENDCASE.

  ENDMETHOD.