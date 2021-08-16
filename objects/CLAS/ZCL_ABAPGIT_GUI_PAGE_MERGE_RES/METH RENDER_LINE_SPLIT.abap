  METHOD render_line_split.

    DATA: lv_new  TYPE string,
          lv_old  TYPE string,
          lv_mark TYPE string,
          lv_bg   TYPE string.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    " New line
    lv_mark = ` `.
    IF is_diff_line-result = zif_abapgit_definitions=>c_diff-update.
      lv_bg = ' diff_upd'.
      lv_mark = `~`.
    ELSEIF is_diff_line-result = zif_abapgit_definitions=>c_diff-insert.
      lv_bg = ' diff_ins'.
      lv_mark = `+`.
    ENDIF.
    lv_new = |<td class="num" line-num="{ is_diff_line-new_num }"></td>|
          && |<td class="code{ lv_bg }">{ lv_mark }{ is_diff_line-new }</td>|.

    " Old line
    CLEAR lv_bg.
    lv_mark = ` `.
    IF is_diff_line-result = zif_abapgit_definitions=>c_diff-update.
      lv_bg = ' diff_upd'.
      lv_mark = `~`.
    ELSEIF is_diff_line-result = zif_abapgit_definitions=>c_diff-delete.
      lv_bg = ' diff_del'.
      lv_mark = `-`.
    ENDIF.
    lv_old = |<td class="num" line-num="{ is_diff_line-old_num }"></td>|
          && |<td class="code{ lv_bg }">{ lv_mark }{ is_diff_line-old }</td>|.

    " render line, inverse sides if remote is newer
    ri_html->add( '<tr>' ).
    ri_html->add( lv_old ). " Target
    ri_html->add( lv_new ). " Source
    ri_html->add( '</tr>' ).

  ENDMETHOD.