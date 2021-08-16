  METHOD render_section_end.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |</div>| ).

  ENDMETHOD.