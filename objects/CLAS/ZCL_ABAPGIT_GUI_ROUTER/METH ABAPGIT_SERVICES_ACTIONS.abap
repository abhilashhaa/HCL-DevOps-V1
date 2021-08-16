  METHOD abapgit_services_actions.
    DATA: li_main_page TYPE REF TO zcl_abapgit_gui_page_main.
    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-abapgit_home.
        CREATE OBJECT li_main_page.
        rs_handled-page = li_main_page.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-abapgit_install.                 " Install abapGit
        zcl_abapgit_services_abapgit=>install_abapgit( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
    ENDCASE.

  ENDMETHOD.