  METHOD zip_services.

    DATA: lv_key               TYPE zif_abapgit_persistence=>ty_repo-key,
          lo_repo              TYPE REF TO zcl_abapgit_repo,
          lv_package           TYPE devclass,
          lv_path              TYPE string,
          lv_xstr              TYPE xstring.

    " TODO refactor
    CONSTANTS:
      BEGIN OF lc_page,
        main_view TYPE string VALUE 'ZCL_ABAPGIT_GUI_PAGE_MAIN',
        repo_view TYPE string VALUE 'ZCL_ABAPGIT_GUI_PAGE_VIEW_REPO',
      END OF lc_page.

    lv_key = ii_event->query( )->get( 'KEY' ).

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-zip_import.                      " Import repo from ZIP
        lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        lv_path = zcl_abapgit_ui_factory=>get_frontend_services( )->show_file_open_dialog(
          iv_title            = 'Import ZIP'
          iv_extension        = 'zip'
          iv_default_filename = '*.zip' ).
        lv_xstr = zcl_abapgit_ui_factory=>get_frontend_services( )->file_upload( lv_path ).
        lo_repo->set_files_remote( zcl_abapgit_zip=>load( lv_xstr ) ).
        zcl_abapgit_services_repo=>refresh( lv_key ).

        " TODO refactor how current page name is determined
        CASE ii_event->mi_gui_services->get_current_page_name( ).
          WHEN lc_page-repo_view.
            rs_handled-state = zcl_abapgit_gui=>c_event_state-re_render.
          WHEN lc_page-main_view.
            CREATE OBJECT rs_handled-page TYPE zcl_abapgit_gui_page_view_repo
              EXPORTING
                iv_key = lo_repo->get_key( ).
            rs_handled-state = zcl_abapgit_gui=>c_event_state-new_page.
          WHEN OTHERS.
            rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
        ENDCASE.
      WHEN zif_abapgit_definitions=>c_action-zip_export.                      " Export repo as ZIP
        lo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( lv_key ).
        lv_xstr = zcl_abapgit_zip=>export( lo_repo ).
        file_download( iv_package = lo_repo->get_package( )
                       iv_xstr    = lv_xstr ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-zip_package.                     " Export package as ZIP
        zcl_abapgit_zip=>export_package( IMPORTING
          ev_xstr    = lv_xstr
          ev_package = lv_package ).
        file_download( iv_package = lv_package
                       iv_xstr    = lv_xstr ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-zip_transport.                   " Export transports as ZIP
        zcl_abapgit_transport_mass=>run( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-zip_object.                      " Export object as ZIP
        zcl_abapgit_zip=>export_object( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
    ENDCASE.

  ENDMETHOD.