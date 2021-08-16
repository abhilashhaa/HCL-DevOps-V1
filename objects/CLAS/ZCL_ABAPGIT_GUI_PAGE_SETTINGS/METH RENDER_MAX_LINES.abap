  METHOD render_max_lines.
    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h2>List size</h2>| ).
    ri_html->add( |<label for="max_lines">Max. # of Objects Listed (0 = All)</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( `<input name="max_lines" type="text" size="5" value="` && mo_settings->get_max_lines( ) && `">` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
  ENDMETHOD.