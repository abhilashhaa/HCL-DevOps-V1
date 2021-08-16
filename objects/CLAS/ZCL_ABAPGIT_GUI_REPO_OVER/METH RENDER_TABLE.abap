  METHOD render_table.

    ii_html->add( |<div class="db_list repo-overview">| ).
    ii_html->add( |<table class="db_tab w100">| ).

    render_table_header( ii_html ).
    render_table_body( ii_html     = ii_html
                       it_overview = it_overview ).

    ii_html->add( |</table>| ).
    ii_html->add( |</div>| ).

  ENDMETHOD.