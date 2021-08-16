  METHOD render_scripts.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->set_title( cl_abap_typedescr=>describe_by_object_ref( me )->get_relative_name( ) ).

    ri_html->add( 'var gStageParams = {' ).
    ri_html->add( |  seed:            "{ mv_seed }",| ). " Unique page id
    ri_html->add( |  user:            "{ to_lower( sy-uname ) }",| ).
    ri_html->add( '  formAction:      "stage_commit",' ).
    ri_html->add( |  patchAction:     "{ zif_abapgit_definitions=>c_action-go_patch }",| ).

    ri_html->add( '  ids: {' ).
    ri_html->add( '    stageTab:          "stageTab",' ).
    ri_html->add( '    commitAllBtn:      "commitAllButton",' ).
    ri_html->add( '    commitSelectedBtn: "commitSelectedButton",' ).
    ri_html->add( '    commitFilteredBtn: "commitFilteredButton",' ).
    ri_html->add( '    patchBtn:          "patchBtn",' ).
    ri_html->add( '    objectSearch:      "objectSearch",' ).
    ri_html->add( '  }' ).

    ri_html->add( '}' ).
    ri_html->add( 'var gHelper = new StageHelper(gStageParams);' ).

  ENDMETHOD.