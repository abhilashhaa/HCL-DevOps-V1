  METHOD general_page_routing.

    DATA: lv_key           TYPE zif_abapgit_persistence=>ty_repo-key,
          lv_last_repo_key TYPE zif_abapgit_persistence=>ty_repo-key,
          lt_repo_list     TYPE zif_abapgit_definitions=>ty_repo_ref_tt.


    lv_key = ii_event->query( )->get( 'KEY' ).

    CASE ii_event->mv_action.
      WHEN zcl_abapgit_gui=>c_action-go_home.
        lv_last_repo_key = zcl_abapgit_persistence_user=>get_instance( )->get_repo_show( ).
        lt_repo_list = zcl_abapgit_repo_srv=>get_instance( )->list( ).

        IF lv_last_repo_key IS NOT INITIAL.
          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_view_repo
            EXPORTING
              iv_key = lv_last_repo_key.
        ELSEIF lt_repo_list IS NOT INITIAL.
          CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_main.
        ELSE.
          rs_handled-page = zcl_abapgit_gui_page_tutorial=>create( ).
        ENDIF.

        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.

      WHEN zif_abapgit_definitions=>c_action-go_db.                          " Go DB util page
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_db.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_debuginfo.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_debuginfo.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_settings.
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_settings.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_background_run.              " Go background run page
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_bkg_run.
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_background.                   " Go Background page
        rs_handled-page  = get_page_background( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_diff.                         " Go Diff page
        rs_handled-page  = get_page_diff( ii_event ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_w_bookmark.
      WHEN zif_abapgit_definitions=>c_action-go_stage.                        " Go Staging page
        rs_handled-page  = get_page_stage( ii_event ).
        IF ii_event->mi_gui_services->get_current_page_name( ) = 'ZCL_ABAPGIT_GUI_PAGE_DIFF'. " TODO refactor
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
        ELSE.
          rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page_w_bookmark.
        ENDIF.
      WHEN zif_abapgit_definitions=>c_action-go_branch_overview.              " Go repo branch overview
        rs_handled-page  = get_page_branch_overview( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-go_tutorial.                     " Go to tutorial
        rs_handled-page  = zcl_abapgit_gui_page_tutorial=>create( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-documentation.                   " abapGit docs
        zcl_abapgit_services_abapgit=>open_abapgit_wikipage( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-go_explore.                      " dotabap
        zcl_abapgit_services_abapgit=>open_dotabap_homepage( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-changelog.                       " abapGit full changelog
        zcl_abapgit_services_abapgit=>open_abapgit_changelog( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.

    ENDCASE.

  ENDMETHOD.