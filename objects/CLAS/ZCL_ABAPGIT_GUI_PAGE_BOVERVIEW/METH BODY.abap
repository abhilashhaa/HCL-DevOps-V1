  METHOD body.

    DATA: lv_tag                 TYPE string,
          lv_branch_display_name TYPE string.

    FIELD-SYMBOLS: <ls_commit> LIKE LINE OF mt_commits,
                   <ls_create> LIKE LINE OF <ls_commit>-create.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top(
      io_repo         = mo_repo
      iv_show_package = abap_false
      iv_show_branch  = abap_false ) ).
    ri_html->add( '<br>' ).
    ri_html->add( '<br>' ).

    ri_html->add( render_merge( ) ).

    ri_html->add( '<br>' ).
    ri_html->add( build_menu( )->render( ) ).


    "CSS gitGraph-scrollWrapper, gitGraph-HTopScroller and gitGraph-Wrapper
    " - Used to manage the Horizonal Scroll bar on top of gitGraph Element
    ri_html->add( '<div class="gitGraph-scrollWrapper" onscroll="GitGraphScroller()">' ).
    "see http://stackoverflow.com/questions/6081483/maximum-size-of-a-canvas-element
    ri_html->add( '<div class="gitGraph-HTopScroller"></div>' ).
    ri_html->add( '</div>' ).

    ri_html->add( '<div class="gitGraph-Wrapper">' ).
    ri_html->add( '<canvas id="gitGraph"></canvas>' ).
    ri_html->add( '</div>' ).

    ri_html->add( '<script type="text/javascript" src="https://cdnjs.' &&
      'cloudflare.com/ajax/libs/gitgraph.js/1.14.0/gitgraph.min.js">' &&
      '</script>' ).

    ri_html->add( '<script type="text/javascript">' ).
    ri_html->add( 'var myTemplateConfig = {' ).
    ri_html->add( 'colors: [ "#979797", "#008fb5", "#f1c109", "'
      && '#095256", "#087F8C", "#5AAA95", "#86A873", "#BB9F06" ],' ).
    ri_html->add( 'branch: {' ).
    ri_html->add( '  lineWidth: 8,' ).
    ri_html->add( '  spacingX: 50' ).
    ri_html->add( '},' ).
    ri_html->add( 'commit: {' ).
    ri_html->add( '  spacingY: -40,' ).
    ri_html->add( '  dot: { size: 12 },' ).
    ri_html->add( '  message: { font: "normal 14pt Arial" }' ).
    ri_html->add( '}' ).
    ri_html->add( '};' ).
    ri_html->add( 'var gitgraph = new GitGraph({' ).
    ri_html->add( '  template: myTemplateConfig,' ).
    ri_html->add( '  orientation: "vertical-reverse"' ).
    ri_html->add( '});' ).
    ri_html->add( 'var gBranchOveriew = new BranchOverview();' ).

    LOOP AT mt_commits ASSIGNING <ls_commit>.

      IF sy-tabix = 1.
        " assumption: all branches are created from master, todo
        ri_html->add( |var {
          escape_branch( <ls_commit>-branch ) } = gitgraph.branch("{
          <ls_commit>-branch }");| ).
      ENDIF.

      IF <ls_commit>-branch IS INITIAL.
        CONTINUE. " we skip orphaned commits
      ENDIF.

      IF <ls_commit>-compressed = abap_true.
        ri_html->add( |{ escape_branch( <ls_commit>-branch ) }.commit(\{message: "{
          escape_message( <ls_commit>-message )
          }", dotColor: "black", dotSize: 15, messageHashDisplay: false, messageAuthorDisplay: false\});| ).
      ELSEIF <ls_commit>-merge IS INITIAL.

        " gitgraph doesn't support multiple tags per commit yet.
        " Therefore we concatenate them.
        " https://github.com/nicoespeon/gitgraph.js/issues/143

        lv_tag = concat_lines_of( table = <ls_commit>-tags
                                  sep   = ` | ` ).

        ri_html->add( |{ escape_branch( <ls_commit>-branch ) }.commit(\{message: "{
          escape_message( <ls_commit>-message ) }", long: "{ escape_message( concat_lines_of( table = <ls_commit>-body
                                                                                              sep   = ` ` ) )
          }", author: "{
          <ls_commit>-author }", sha1: "{
          <ls_commit>-sha1(7) }", tag: "{ lv_tag
          }", onClick:gBranchOveriew.onCommitClick.bind(gBranchOveriew)\});| ).
      ELSE.
        ri_html->add( |{ escape_branch( <ls_commit>-merge ) }.merge({
          escape_branch( <ls_commit>-branch ) }, \{message: "{
          escape_message( <ls_commit>-message ) }", long: "{ escape_message( concat_lines_of( table = <ls_commit>-body
                                                                                              sep   = ` ` ) )
          }", author: "{ <ls_commit>-author }", sha1: "{
          <ls_commit>-sha1(7) }", onClick:gBranchOveriew.onCommitClick.bind(gBranchOveriew)\});| ).
      ENDIF.

      LOOP AT <ls_commit>-create ASSIGNING <ls_create>.
        IF <ls_create>-name CS zcl_abapgit_branch_overview=>c_deleted_branch_name_prefix.
          lv_branch_display_name = ''.
        ELSE.
          lv_branch_display_name = <ls_create>-name.
        ENDIF.

        ri_html->add( |var { escape_branch( <ls_create>-name ) } = {
                      escape_branch( <ls_create>-parent ) }.branch("{
                      lv_branch_display_name }");| ).
      ENDLOOP.

    ENDLOOP.

    ri_html->add(
       |gitGraph.addEventListener( "commit:mouseover", gBranchOveriew.showCommit.bind(gBranchOveriew) );| ).
    ri_html->add(
       |gitGraph.addEventListener( "commit:mouseout",  gBranchOveriew.hideCommit.bind(gBranchOveriew) );| ).

    ri_html->add( '</script>' ).

    ri_html->add( '<script>' ).
    ri_html->add( 'setGitGraphScroller();' ).
    ri_html->add( '</script>' ).

    ri_html->add( render_commit_popups( ) ).

  ENDMETHOD.