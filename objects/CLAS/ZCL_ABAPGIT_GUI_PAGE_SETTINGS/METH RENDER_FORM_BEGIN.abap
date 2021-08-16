  METHOD render_form_begin.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( '<div class="settings_container">' ).
    ri_html->add( `<form id="settings_form" method="post" action="sapevent:` && c_action-save_settings && `">` ).

  ENDMETHOD.