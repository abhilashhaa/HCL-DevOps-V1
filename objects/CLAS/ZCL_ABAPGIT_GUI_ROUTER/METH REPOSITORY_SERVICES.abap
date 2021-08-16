  METHOD repository_services.

    DATA:
      lv_key TYPE zif_abapgit_persistence=>ty_repo-key,
      li_log TYPE REF TO zif_abapgit_log.

    lv_key = ii_event->query( )->get( 'KEY' ).

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-repo_newoffline.                 " New offline repo
        zcl_abapgit_services_repo=>new_offline( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_add_all_obj_to_trans_req.
        zcl_abapgit_transport=>add_all_objects_to_trans_req( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_refresh.                    " Repo refresh
        zcl_abapgit_services_repo=>refresh( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_syntax_check.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_syntax
          EXPORTING
            io_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-repo_code_inspector.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_code_insp
          EXPORTING
            io_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-repo_purge.                      " Repo remove & purge all objects
        zcl_abapgit_services_repo=>purge( lv_key ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_main.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_replacing.
      WHEN zif_abapgit_definitions=>c_action-repo_remove.                     " Repo remove
        zcl_abapgit_services_repo=>remove( lv_key ).
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_main.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_replacing.
      WHEN zif_abapgit_definitions=>c_action-repo_newonline.
        rs_handled-page  = zcl_abapgit_gui_page_addonline=>create( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-repo_refresh_checksums.          " Rebuild local checksums
        zcl_abapgit_services_repo=>refresh_local_checksums( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_toggle_fav.                 " Toggle repo as favorite
        zcl_abapgit_services_repo=>toggle_favorite( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_transport_to_branch.
        zcl_abapgit_services_repo=>transport_to_branch( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-repo_settings.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_repo_sett
          EXPORTING
            io_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-repo_log.
        li_log = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key )->get_log( ).
        zcl_abapgit_log_viewer=>show_log( ii_log = li_log
                                          iv_header_text = li_log->get_title( ) ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
    ENDCASE.

  ENDMETHOD.