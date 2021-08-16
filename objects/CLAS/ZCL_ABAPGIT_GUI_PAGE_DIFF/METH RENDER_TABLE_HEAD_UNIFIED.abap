  METHOD render_table_head_unified.

    ii_html->add( '<th class="num">old</th>' ).
    ii_html->add( '<th class="num">new</th>' ).
    ii_html->add( '<th class="mark"></th>' ).
    ii_html->add( '<th>code</th>' ).

  ENDMETHOD.