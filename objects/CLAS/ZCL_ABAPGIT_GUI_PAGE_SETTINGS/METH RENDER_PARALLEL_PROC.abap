  METHOD render_parallel_proc.

    DATA lv_checked TYPE string.

    IF mo_settings->get_parallel_proc_disabled( ) = abap_true.
      lv_checked = 'checked'.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>Parallel Processing</h2>| ).
    ri_html->add( `<input type="checkbox" name="parallel_proc_disabled" value="X" `
                   && lv_checked && ` > Disable Parallel Processing` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
  ENDMETHOD.