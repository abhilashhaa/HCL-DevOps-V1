  METHOD render_table_head_non_unified.

    ii_html->add( '<th class="num"></th>' ).
    ii_html->add( '<th class="mark"></th>' ).
    ii_html->add( '<th>LOCAL</th>' ).
    ii_html->add( '<th class="num"></th>' ).
    ii_html->add( '<th class="mark"></th>' ).
    ii_html->add( '<th>REMOTE</th>' ).

  ENDMETHOD.