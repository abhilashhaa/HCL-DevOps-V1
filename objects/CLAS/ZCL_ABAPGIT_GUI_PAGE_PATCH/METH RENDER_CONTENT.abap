  METHOD render_content.

    CLEAR: mv_section_count.

    IF mv_pushed = abap_true.
      refresh_full( ).
      calculate_diff( ).
      CLEAR: mv_pushed.
    ENDIF.

    gui_services( )->get_hotkeys_ctl( )->register_hotkeys( me ).
    ri_html = super->render_content( ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.