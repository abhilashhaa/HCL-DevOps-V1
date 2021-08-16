  METHOD render_content.

    DATA: ls_merge  TYPE zif_abapgit_definitions=>ty_merge,
          lt_files  LIKE ls_merge-stree,
          ls_result LIKE LINE OF ls_merge-result.

    FIELD-SYMBOLS: <ls_file> LIKE LINE OF lt_files.

    ls_merge = mo_merge->get_result( ).

    "If now exists no conflicts anymore, conflicts button should disappear
    ms_control-page_menu = build_menu( mo_merge->has_conflicts( ) ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<div id="toc">' ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top(
      io_repo         = mo_repo
      iv_show_package = abap_false
      iv_show_branch  = abap_false ) ).

    ri_html->add( '<table>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td>Source</td>' ).
    ri_html->add( '<td>' ).
    ri_html->add( ls_merge-source-name ).
    ri_html->add( '</td></tr>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td>Target</td>' ).
    ri_html->add( '<td>' ).
    ri_html->add( ls_merge-target-name ).
    ri_html->add( '</td></tr>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td>Ancestor</td>' ).
    ri_html->add( '<td>' ).
    ri_html->add( ls_merge-common-commit ).
    ri_html->add( '</td></tr>' ).
    ri_html->add( '</table>' ).

    ri_html->add( '<br>' ).

    APPEND LINES OF ls_merge-stree TO lt_files.
    APPEND LINES OF ls_merge-ttree TO lt_files.
    APPEND LINES OF ls_merge-ctree TO lt_files.
    SORT lt_files BY path DESCENDING name ASCENDING.
    DELETE ADJACENT DUPLICATES FROM lt_files COMPARING path name.

    ri_html->add( '<table>' ).
    ri_html->add( '<tr>' ).
    ri_html->add( '<td><u>Source</u></td>' ).
    ri_html->add( '<td></td>' ).
    ri_html->add( '<td><u>Target</u></td>' ).
    ri_html->add( '<td></td>' ).
    ri_html->add( '<td><u>Ancestor</u></td>' ).
    ri_html->add( '<td></td>' ).
    ri_html->add( '<td><u>Result</u></td>' ).
    ri_html->add( '<td></td>' ).
    ri_html->add( '</tr>' ).
    LOOP AT lt_files ASSIGNING <ls_file>.
      CLEAR ls_result.
      READ TABLE ls_merge-result INTO ls_result
        WITH KEY path = <ls_file>-path name = <ls_file>-name.

      ri_html->add( '<tr>' ).
      show_file( it_expanded = ls_merge-stree
                 ii_html     = ri_html
                 is_file     = <ls_file>
                 is_result   = ls_result ).
      show_file( it_expanded = ls_merge-ttree
                 ii_html     = ri_html
                 is_file     = <ls_file>
                 is_result   = ls_result ).
      show_file( it_expanded = ls_merge-ctree
                 ii_html     = ri_html
                 is_file     = <ls_file>
                 is_result   = ls_result ).
      show_file( it_expanded = ls_merge-result
                 ii_html     = ri_html
                 is_file     = <ls_file>
                 is_result   = ls_result ).
      ri_html->add( '</tr>' ).
    ENDLOOP.
    ri_html->add( '</table>' ).
    ri_html->add( '<br>' ).
    ri_html->add( '<b>' ).
    ri_html->add( ls_merge-conflict ).
    ri_html->add( '</b>' ).
    ri_html->add( '</div>' ).

  ENDMETHOD.