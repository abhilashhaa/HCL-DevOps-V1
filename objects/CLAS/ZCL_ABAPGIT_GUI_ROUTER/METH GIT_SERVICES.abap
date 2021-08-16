  METHOD git_services.

    DATA lv_key TYPE zif_abapgit_persistence=>ty_repo-key.

    lv_key = ii_event->query( )->get( 'KEY' ).

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-git_pull.                      " GIT Pull
        zcl_abapgit_services_git=>pull( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_reset.                     " GIT Reset
        zcl_abapgit_services_git=>reset( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_branch_create.             " GIT Create new branch
        zcl_abapgit_services_git=>create_branch( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_branch_delete.             " GIT Delete remote branch
        zcl_abapgit_services_git=>delete_branch( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_branch_switch.             " GIT Switch branch
        zcl_abapgit_services_git=>switch_branch( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-go_tag_overview.               " GIT Tag overview
        zcl_abapgit_services_git=>tag_overview( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_tag_create.                " GIT Tag create
        CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_tag
          EXPORTING
            io_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
      WHEN zif_abapgit_definitions=>c_action-git_tag_delete.                " GIT Tag create
        zcl_abapgit_services_git=>delete_tag( lv_key ).
        zcl_abapgit_services_repo=>refresh( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
      WHEN zif_abapgit_definitions=>c_action-git_tag_switch.                " GIT Switch Tag
        zcl_abapgit_services_git=>switch_tag( lv_key ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
    ENDCASE.

  ENDMETHOD.