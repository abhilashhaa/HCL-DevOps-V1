  METHOD render_event_as_form.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add(
      |<form id='form_{ is_event-name }' method={ is_event-method } action='sapevent:{ is_event-name }'></form>| ).

  ENDMETHOD.