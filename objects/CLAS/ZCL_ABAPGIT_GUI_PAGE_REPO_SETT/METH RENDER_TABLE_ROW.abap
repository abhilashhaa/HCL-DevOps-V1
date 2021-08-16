  METHOD render_table_row.

    rv_html = '<tr>'
      && |<td>{ iv_name }</td>|
      && |<td>{ iv_value }</td>|
      && '</tr>'.

  ENDMETHOD.