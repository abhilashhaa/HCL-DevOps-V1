  METHOD zif_abapgit_gui_renderable~render.

    DATA: li_script TYPE REF TO zif_abapgit_html.

    gui_services( )->register_event_handler( me ).

    " Real page
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<!DOCTYPE html>' ).
    ri_html->add( '<html>' ).
    ri_html->add( html_head( ) ).
    ri_html->add( '<body>' ).
    ri_html->add( title( ) ).

    ri_html->add( render_content( ) ). " TODO -> render child

    ri_html->add( render_hotkey_overview( ) ).
    ri_html->add( render_error_message_box( ) ).

    render_deferred_parts(
      ii_html          = ri_html
      iv_part_category = c_html_parts-hidden_forms ).

    ri_html->add( footer( ) ).
    ri_html->add( '</body>' ).

    li_script = scripts( ).

    IF li_script IS BOUND AND li_script->is_empty( ) = abap_false.
      ri_html->add( '<script type="text/javascript">' ).
      ri_html->add( li_script ).
      ri_html->add( 'confirmInitialized();' ).
      ri_html->add( '</script>' ).
    ENDIF.

    ri_html->add( '</html>' ).

  ENDMETHOD.