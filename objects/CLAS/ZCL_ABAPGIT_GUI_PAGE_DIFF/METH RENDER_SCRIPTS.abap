  METHOD render_scripts.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->set_title( cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ) ).

    ri_html->add( 'restoreScrollPosition();' ).
    ri_html->add( 'var gHelper = new DiffHelper({' ).
    ri_html->add( |  seed:        "{ mv_seed }",| ).
    ri_html->add( '  ids: {' ).
    ri_html->add( '    jump:        "jump",' ).
    ri_html->add( '    diffList:    "diff-list",' ).
    ri_html->add( '    filterMenu:  "diff-filter",' ).
    ri_html->add( '  }' ).
    ri_html->add( '});' ).

    ri_html->add( 'addMarginBottom();' ).

    ri_html->add( 'var gGoJumpPalette = new CommandPalette(enumerateJumpAllFiles, {' ).
    ri_html->add( '  toggleKey: "F2",' ).
    ri_html->add( '  hotkeyDescription: "Jump to file ..."' ).
    ri_html->add( '});' ).

    " Feature for selecting ABAP code by column and copy to clipboard
    ri_html->add( 'var columnSelection = new DiffColumnSelection();' ).

  ENDMETHOD.