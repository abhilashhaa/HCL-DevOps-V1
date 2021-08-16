  METHOD render_content.

    DATA: lt_repo_items        TYPE zif_abapgit_definitions=>tt_repo_items,
          lo_browser           TYPE REF TO zcl_abapgit_repo_content_list,
          lx_error             TYPE REF TO zcx_abapgit_exception,
          lv_lstate            TYPE char1,
          lv_rstate            TYPE char1,
          lv_max               TYPE abap_bool,
          lv_max_str           TYPE string,
          lv_add_str           TYPE string,
          li_log               TYPE REF TO zif_abapgit_log,
          lv_render_transports TYPE abap_bool,
          lv_msg               TYPE string,
          lo_news              TYPE REF TO zcl_abapgit_news.

    FIELD-SYMBOLS <ls_item> LIKE LINE OF lt_repo_items.

    gui_services( )->get_hotkeys_ctl( )->register_hotkeys( me ).
    gui_services( )->register_event_handler( me ).

    " Reinit, for the case of type change
    mo_repo = zcl_abapgit_repo_srv=>get_instance( )->get( mo_repo->get_key( ) ).

    lo_news = zcl_abapgit_news=>create( mo_repo ).

    TRY.
        CREATE OBJECT ri_html TYPE zcl_abapgit_html.
        ri_html->add( |<div class="repo" id="repo{ mv_key }">| ).
        ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top(
          io_repo               = mo_repo
          io_news               = lo_news
          iv_interactive_branch = abap_true ) ).

        ri_html->add( zcl_abapgit_gui_chunk_lib=>render_news( io_news = lo_news ) ).

        lv_render_transports = zcl_abapgit_factory=>get_cts_api(
          )->is_chrec_possible_for_package( mo_repo->get_package( ) ).

        CREATE OBJECT lo_browser
          EXPORTING
            io_repo = mo_repo.

        lt_repo_items = lo_browser->list( iv_path         = mv_cur_dir
                                          iv_by_folders   = mv_show_folders
                                          iv_changes_only = mv_changes_only ).

        apply_order_by( CHANGING ct_repo_items = lt_repo_items ).

        LOOP AT lt_repo_items ASSIGNING <ls_item>.
          zcl_abapgit_state=>reduce( EXPORTING iv_cur = <ls_item>-lstate
                                     CHANGING cv_prev = lv_lstate ).
          zcl_abapgit_state=>reduce( EXPORTING iv_cur = <ls_item>-rstate
                                     CHANGING cv_prev = lv_rstate ).
        ENDLOOP.

        ri_html->add( render_head_line( iv_lstate = lv_lstate
                                        iv_rstate = lv_rstate ) ).

        li_log = lo_browser->get_log( ).
        IF mo_repo->is_offline( ) = abap_false AND li_log->count( ) > 0.
          ri_html->add( '<div class="log">' ).
          ri_html->add( zcl_abapgit_log_viewer=>to_html( li_log ) ). " shows eg. list of unsupported objects
          ri_html->add( '</div>' ).
        ENDIF.

        ri_html->add( '<div class="repo_container">' ).

        CLEAR lv_msg.

        IF mo_repo->is_offline( ) = abap_true
            AND mo_repo->has_remote_source( ) = abap_true
            AND lv_lstate IS INITIAL AND lv_rstate IS INITIAL.
          " Offline match banner
          lv_msg = 'ZIP source is attached and completely <b>matches</b> the local state'.
        ELSEIF lines( lt_repo_items ) = 0.
          " Online match banner
          IF mv_changes_only = abap_true.
            lv_msg = 'Local state completely <b>matches</b> the remote repository'.
          ELSE.
            lv_msg = |Package is empty. Show { build_dir_jump_link( 'parent' ) } package|.
          ENDIF.
        ELSE.
          " Repo content table
          ri_html->add( '<table class="repo_tab">' ).

          IF zcl_abapgit_path=>is_root( mv_cur_dir ) = abap_false.
            ri_html->add( render_parent_dir( ) ).
          ENDIF.

          ri_html->add( render_order_by( ) ).

          LOOP AT lt_repo_items ASSIGNING <ls_item>.
            IF mv_max_lines > 0 AND sy-tabix > mv_max_lines.
              lv_max = abap_true.
              EXIT. " current loop
            ENDIF.
            ri_html->add( render_item( is_item = <ls_item>
                                       iv_render_transports = lv_render_transports ) ).
          ENDLOOP.

          ri_html->add( '</table>' ).
        ENDIF.

        IF NOT lv_msg IS INITIAL.
          ri_html->add( |<div class="panel success repo_banner">{ lv_msg }</div>| ).
        ENDIF.

        IF lv_max = abap_true.
          ri_html->add( '<div class = "dummydiv">' ).
          IF mv_max_lines = 1.
            lv_max_str = '1 object'.
          ELSE.
            lv_max_str = |first { mv_max_lines } objects|.
          ENDIF.
          lv_add_str = |+{ mv_max_setting }|.
          ri_html->add( |Only { lv_max_str } shown in list. Display {
            ri_html->a( iv_txt = lv_add_str
                        iv_act = c_actions-display_more )
            } more. (Set in Advanced > {
            ri_html->a( iv_txt = 'Settings'
                        iv_act = zif_abapgit_definitions=>c_action-go_settings )
            } )| ).
          ri_html->add( '</div>' ).
        ENDIF.

        ri_html->add( '</div>' ).
        ri_html->add( '</div>' ).
      CATCH zcx_abapgit_exception INTO lx_error.
        " Reset 'last shown repo' so next start will go to repo overview
        " and allow troubleshooting of issue
        zcl_abapgit_persistence_user=>get_instance( )->set_repo_show( || ).

        ri_html->add(
          render_head_line(
            iv_lstate = lv_lstate
            iv_rstate = lv_rstate ) ).
        ri_html->add( zcl_abapgit_gui_chunk_lib=>render_error(
          iv_extra_style = 'repo_banner'
          ix_error = lx_error ) ).
    ENDTRY.

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.