  METHOD render_section_begin.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h1>{ iv_header }</h1>| ).
    ri_html->add( |<div class="settings_section">| ).

  ENDMETHOD.