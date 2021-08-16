  METHOD render_start_up.

    DATA lv_checked TYPE string.

    IF mo_settings->get_show_default_repo( ) = abap_true.
      lv_checked = 'checked'.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>Startup</h2>| ).
    ri_html->add( `<input type="checkbox" name="show_default_repo" value="X" `
                   && lv_checked && ` > Show Last Opened Repository` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
  ENDMETHOD.