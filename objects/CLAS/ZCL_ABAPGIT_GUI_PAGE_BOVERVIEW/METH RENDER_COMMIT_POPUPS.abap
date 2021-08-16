  METHOD render_commit_popups.

    DATA: lv_time    TYPE c LENGTH 10,
          lv_date    TYPE sy-datum,
          lv_content TYPE string.

    FIELD-SYMBOLS: <ls_commit> LIKE LINE OF mt_commits.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    LOOP AT mt_commits ASSIGNING <ls_commit>.

      CLEAR: lv_time, lv_date.

      PERFORM p6_to_date_time_tz IN PROGRAM rstr0400
                                 USING <ls_commit>-time
                                       lv_time
                                       lv_date.

      lv_content = |<table class="commit">|
                && |  <tr>|
                && |    <td class="title">Author</td>|
                && |    <td>{ <ls_commit>-author }</td>|
                && |  </tr>|
                && |  <tr>|
                && |    <td class="title">SHA1</td>|
                && |    <td>{ <ls_commit>-sha1 }</td>|
                && |  </tr>|
                && |  <tr>|
                && |    <td class="title">Date/Time</td>|
                && |    <td>{ lv_date DATE = USER }</td>|
                && |  </tr>|
                && |  <tr>|
                && |    <td class="title">Message</td>|
                && |    <td>{ <ls_commit>-message }</td>|
                && |  </tr>|
                && |  <tr>|.

      IF <ls_commit>-body IS NOT INITIAL.
        lv_content = lv_content
                  && |<td class="title">Body</td>|
                  && |<td>{ concat_lines_of( table = <ls_commit>-body
                                             sep   = |<br/>| ) }</td>|.
      ENDIF.

      lv_content = lv_content
                && |  </tr>|
                && |</table>|.

      ri_html->add( zcl_abapgit_gui_chunk_lib=>render_commit_popup(
        iv_id      = <ls_commit>-sha1(7)
        iv_content = lv_content ) ).

    ENDLOOP.

  ENDMETHOD.