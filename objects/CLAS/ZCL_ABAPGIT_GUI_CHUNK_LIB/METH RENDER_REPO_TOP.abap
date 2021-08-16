  METHOD render_repo_top.

    DATA: lo_repo_online       TYPE REF TO zcl_abapgit_repo_online,
          lo_pback             TYPE REF TO zcl_abapgit_persist_background,
          lx_error             TYPE REF TO zcx_abapgit_exception,
          lv_hint              TYPE string,
          lv_icon              TYPE string,
          lv_package_jump_data TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    CREATE OBJECT lo_pback.

    IF io_repo->is_offline( ) = abap_true.
      lv_icon = 'plug/darkgrey'.
      lv_hint = 'Offline repository'.
    ELSE.
      lv_icon = 'cloud-upload-alt/blue'.
      lv_hint = 'On-line repository'.
    ENDIF.

    ri_html->add( '<table class="w100"><tr>' ).

    ri_html->add( '<td class="repo_name">' ).

    " Repo type and name
    ri_html->add_icon( iv_name = lv_icon
                       iv_hint = lv_hint ).
    ri_html->add( |<span class="name">{ io_repo->get_name( ) }</span>| ).
    IF io_repo->is_offline( ) = abap_false.
      lo_repo_online ?= io_repo.

      ri_html->add_a( iv_txt   = lo_repo_online->get_url( )
                      iv_act   = |{ zif_abapgit_definitions=>c_action-url }?url=|
                              && |{ lo_repo_online->get_url( ) }|
                      iv_class = |url| ).

      TRY.
          render_repo_top_commit_hash( ii_html        = ri_html
                                       io_repo_online = lo_repo_online ).
        CATCH zcx_abapgit_exception INTO lx_error.
          " In case of missing or wrong credentials, show message in status bar
          lv_hint = lx_error->get_text( ).
          IF lv_hint CS 'credentials'.
            MESSAGE lv_hint TYPE 'S' DISPLAY LIKE 'E'.
          ENDIF.
      ENDTRY.

    ENDIF.

    " News
    IF io_news IS BOUND AND io_news->has_news( ) = abap_true.
      IF io_news->has_updates( ) = abap_true.
        lv_icon = 'arrow-circle-up/warning'.
      ELSE.
        lv_icon = 'arrow-circle-up/grey80'.
      ENDIF.
      ri_html->add_a( iv_act = |toggleDisplay('news')|
                      iv_typ = zif_abapgit_html=>c_action_type-onclick
                      iv_txt = ri_html->icon( iv_name  = lv_icon
                                              iv_class = 'pad-sides'
                                              iv_hint  = 'Display changelog' ) ).
    ENDIF.
    ri_html->add( '</td>' ).

    ri_html->add( '<td class="repo_attr right">' ).

    " Fav
    IF abap_true = zcl_abapgit_persistence_user=>get_instance( )->is_favorite_repo( io_repo->get_key( ) ).
      lv_icon = 'star/blue'.
    ELSE.
      lv_icon = 'star/grey'.
    ENDIF.
    ri_html->add_a( iv_act = |{ zif_abapgit_definitions=>c_action-repo_toggle_fav }?key={ io_repo->get_key( ) }|
                    iv_txt = ri_html->icon( iv_name  = lv_icon
                                            iv_class = 'pad-sides'
                                            iv_hint  = 'Click to toggle favorite' ) ).

    " BG
    IF lo_pback->exists( io_repo->get_key( ) ) = abap_true.
      ri_html->add( '<span class="bg_marker" title="background">BG</span>' ).
    ENDIF.

    " Write protect
    IF io_repo->get_local_settings( )-write_protected = abap_true.
      ri_html->add_icon( iv_name = 'lock/grey70'
                         iv_hint = 'Locked from pulls' ).
    ENDIF.

    " Branch
    IF io_repo->is_offline( ) = abap_false.
      lo_repo_online ?= io_repo.
      IF iv_show_branch = abap_true.
        IF iv_branch IS INITIAL.
          ri_html->add( render_branch_span( iv_branch      = lo_repo_online->get_branch_name( )
                                            io_repo        = lo_repo_online
                                            iv_interactive = iv_interactive_branch ) ).
        ELSE.
          ri_html->add( render_branch_span( iv_branch      = iv_branch
                                            io_repo        = lo_repo_online
                                            iv_interactive = iv_interactive_branch ) ).
        ENDIF.
      ENDIF.
    ENDIF.

    " Package
    IF iv_show_package = abap_true.
      ri_html->add_icon( iv_name = 'box/grey70'
                         iv_hint = 'SAP package' ).
      ri_html->add( '<span>' ).

      lv_package_jump_data = zcl_abapgit_html_action_utils=>jump_encode(
        iv_obj_type = 'DEVC'
        iv_obj_name = io_repo->get_package( ) ).

      ri_html->add_a( iv_txt = io_repo->get_package( )
                      iv_act = |{ zif_abapgit_definitions=>c_action-jump }?{ lv_package_jump_data }| ).
      ri_html->add( '</span>' ).
    ENDIF.

    ri_html->add( '</td>' ).
    ri_html->add( '</tr></table>' ).

  ENDMETHOD.