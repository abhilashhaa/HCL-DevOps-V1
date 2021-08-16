  METHOD render_list.

    DATA: lt_changed_by TYPE ty_changed_by_tt,
          ls_changed_by LIKE LINE OF lt_changed_by,
          lt_transports TYPE ty_transport_tt,
          ls_transport  LIKE LINE OF lt_transports.

    FIELD-SYMBOLS: <ls_remote> LIKE LINE OF ms_files-remote,
                   <ls_status> LIKE LINE OF ms_files-status,
                   <ls_local>  LIKE LINE OF ms_files-local.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( '<table id="stageTab" class="stage_tab w100">' ).

    lt_changed_by = find_changed_by( ms_files-local ).
    lt_transports = find_transports( ms_files-local ).

    " Local changes
    LOOP AT ms_files-local ASSIGNING <ls_local>.
      AT FIRST.
        ri_html->add( '<thead><tr class="local">' ).
        ri_html->add( '<th class="stage-status"></th>' ). " Diff state
        ri_html->add( '<th class="stage-objtype">Type</th>' ).
        ri_html->add( '<th title="Click filename to see diff">File</th>' ).
        ri_html->add( '<th>Changed by</th>' ).
        ri_html->add( '<th>Transport</th>' ).
        ri_html->add( '<th></th>' ). " Status
        ri_html->add( '<th class="cmd">' ).
        ri_html->add( '<a>add</a>&#x2193; <a>reset</a>&#x2193;' ).
        ri_html->add( '</th>' ).
        ri_html->add( '</tr></thead>' ).
        ri_html->add( '<tbody>' ).
      ENDAT.

      READ TABLE lt_changed_by INTO ls_changed_by WITH KEY item = <ls_local>-item. "#EC CI_SUBRC
      READ TABLE lt_transports INTO ls_transport WITH KEY item = <ls_local>-item. "#EC CI_SUBRC
      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = <ls_local>-file-path
          filename = <ls_local>-file-filename.
      ASSERT sy-subrc = 0.

      ri_html->add( render_file(
        iv_context = 'local'
        is_file       = <ls_local>-file
        is_item       = <ls_local>-item
        is_status     = <ls_status>
        iv_changed_by = ls_changed_by-name
        iv_transport  = ls_transport-transport ) ).

      CLEAR ls_transport.

      AT LAST.
        ri_html->add( '</tbody>' ).
      ENDAT.
    ENDLOOP.

    " Remote changes
    LOOP AT ms_files-remote ASSIGNING <ls_remote>.
      AT FIRST.
        ri_html->add( '<thead><tr class="remote">' ).
        ri_html->add( '<th></th>' ). " Diff state
        ri_html->add( '<th></th>' ). " Type
        ri_html->add( '<th colspan="3">Files to remove or non-code</th>' ).
        ri_html->add( '<th></th>' ). " Status
        ri_html->add( '<th class="cmd">' ).
        ri_html->add( '<a>ignore</a>&#x2193; <a>remove</a>&#x2193; <a>reset</a>&#x2193;' ).
        ri_html->add( '</th>' ).
        ri_html->add( '</tr></thead>' ).
        ri_html->add( '<tbody>' ).
      ENDAT.

      READ TABLE ms_files-status ASSIGNING <ls_status>
        WITH TABLE KEY
          path     = <ls_remote>-path
          filename = <ls_remote>-filename.
      ASSERT sy-subrc = 0.

      ri_html->add( render_file(
        iv_context = 'remote'
        is_status  = <ls_status>
        is_file    = <ls_remote> ) ).

      AT LAST.
        ri_html->add( '</tbody>' ).
      ENDAT.
    ENDLOOP.

    ri_html->add( '</table>' ).

  ENDMETHOD.