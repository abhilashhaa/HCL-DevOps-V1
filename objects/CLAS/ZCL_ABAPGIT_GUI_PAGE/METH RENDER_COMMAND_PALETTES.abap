  METHOD render_command_palettes.

    ii_html->add( 'var gCommandPalette = new CommandPalette(enumerateToolbarActions, {' ).
    ii_html->add( '  toggleKey: "F1",' ).
    ii_html->add( '  hotkeyDescription: "Command ..."' ).
    ii_html->add( '});' ).

  ENDMETHOD.