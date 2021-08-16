  METHOD startup.

    DATA: lt_events TYPE cntl_simple_events,
          ls_event  LIKE LINE OF lt_events,
          lt_assets TYPE zif_abapgit_gui_asset_manager=>tt_web_assets.

    FIELD-SYMBOLS <ls_asset> LIKE LINE OF lt_assets.


    mi_html_viewer = zcl_abapgit_ui_factory=>get_html_viewer( ).

    IF mi_asset_man IS BOUND.
      lt_assets = mi_asset_man->get_all_assets( ).
      LOOP AT lt_assets ASSIGNING <ls_asset> WHERE is_cacheable = abap_true.
        zif_abapgit_gui_services~cache_asset(
          iv_xdata   = <ls_asset>-content
          iv_url     = <ls_asset>-url
          iv_type    = <ls_asset>-type
          iv_subtype = <ls_asset>-subtype ).
      ENDLOOP.
    ENDIF.

    ls_event-eventid    = mi_html_viewer->m_id_sapevent.
    ls_event-appl_event = abap_true.
    APPEND ls_event TO lt_events.

    mi_html_viewer->set_registered_events( lt_events ).
    SET HANDLER me->on_event FOR mi_html_viewer.

  ENDMETHOD.