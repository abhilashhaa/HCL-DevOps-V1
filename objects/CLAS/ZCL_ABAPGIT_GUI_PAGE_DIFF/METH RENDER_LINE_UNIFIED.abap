  METHOD render_line_unified.

    FIELD-SYMBOLS <ls_diff_line> LIKE LINE OF mt_delayed_lines.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    " Release delayed subsequent update lines
    IF is_diff_line-result <> zif_abapgit_definitions=>c_diff-update.
      LOOP AT mt_delayed_lines ASSIGNING <ls_diff_line>.
        ri_html->add( '<tr>' ).
        ri_html->add( |<td class="num diff_others" line-num="{ <ls_diff_line>-old_num }"></td>|
                   && |<td class="num diff_others" line-num=""></td>|
                   && |<td class="mark diff_others">-</td>|
                   && |<td class="code diff_del diff_unified">{ <ls_diff_line>-old }</td>| ).
        ri_html->add( '</tr>' ).
      ENDLOOP.
      LOOP AT mt_delayed_lines ASSIGNING <ls_diff_line>.
        ri_html->add( '<tr>' ).
        ri_html->add( |<td class="num diff_others" line-num=""></td>|
                   && |<td class="num diff_others" line-num="{ <ls_diff_line>-new_num }"></td>|
                   && |<td class="mark diff_others">+</td>|
                   && |<td class="code diff_ins diff_others">{ <ls_diff_line>-new }</td>| ).
        ri_html->add( '</tr>' ).
      ENDLOOP.
      CLEAR mt_delayed_lines.
    ENDIF.

    ri_html->add( '<tr>' ).
    CASE is_diff_line-result.
      WHEN zif_abapgit_definitions=>c_diff-update.
        APPEND is_diff_line TO mt_delayed_lines. " Delay output of subsequent updates
      WHEN zif_abapgit_definitions=>c_diff-insert.
        ri_html->add( |<td class="num diff_others" line-num=""></td>|
                   && |<td class="num diff_others" line-num="{ is_diff_line-new_num }"></td>|
                   && |<td class="mark diff_others">+</td>|
                   && |<td class="code diff_ins diff_others">{ is_diff_line-new }</td>| ).
      WHEN zif_abapgit_definitions=>c_diff-delete.
        ri_html->add( |<td class="num diff_others" line-num="{ is_diff_line-old_num }"></td>|
                   && |<td class="num diff_others" line-num=""></td>|
                   && |<td class="mark diff_others">-</td>|
                   && |<td class="code diff_del diff_unified">{ is_diff_line-old }</td>| ).
      WHEN OTHERS. "none
        ri_html->add( |<td class="num diff_others" line-num="{ is_diff_line-old_num }"></td>|
                   && |<td class="num diff_others" line-num="{ is_diff_line-new_num }"></td>|
                   && |<td class="mark diff_others">&nbsp;</td>|
                   && |<td class="code diff_unified">{ is_diff_line-old }</td>| ).
    ENDCASE.
    ri_html->add( '</tr>' ).

  ENDMETHOD.