  METHOD render_content.

    DATA: ls_diff_file LIKE LINE OF mt_diff_files,
          li_progress  TYPE REF TO zif_abapgit_progress.


    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    li_progress = zcl_abapgit_progress=>get_instance( lines( mt_diff_files ) ).

    ri_html->add( `<div class="repo">` ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_repo_top( mo_repo ) ).
    ri_html->add( `</div>` ).

    ri_html->add( |<div id="diff-list" data-repo-key="{ mv_repo_key }">| ).
    ri_html->add( zcl_abapgit_gui_chunk_lib=>render_js_error_banner( ) ).
    LOOP AT mt_diff_files INTO ls_diff_file.
      li_progress->show(
        iv_current = sy-tabix
        iv_text    = |Render Diff - { ls_diff_file-filename }| ).

      ri_html->add( render_diff( ls_diff_file ) ).
    ENDLOOP.
    IF sy-subrc <> 0.
      ri_html->add( |No more diffs| ).
    ENDIF.
    ri_html->add( '</div>' ).

    register_deferred_script( render_scripts( ) ).

  ENDMETHOD.