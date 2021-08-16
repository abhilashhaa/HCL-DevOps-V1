  METHOD render_adt_jump_enabled.

    DATA lv_checked TYPE string.

    IF mo_settings->get_adt_jump_enabled( ) = abap_true.
      lv_checked = 'checked'.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>ABAP Development Tools (ADT)</h2>| ).
    ri_html->add( `<input type="checkbox" name="adt_jump_enabled" value="X" `
                   && lv_checked && ` > Enable Jump to ADT First` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
  ENDMETHOD.