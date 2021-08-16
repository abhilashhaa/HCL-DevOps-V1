  METHOD render_link_hints.

    DATA: lv_checked       TYPE string,
          lv_link_hint_key TYPE c LENGTH 1.

    IF mo_settings->get_link_hints_enabled( ) = abap_true.
      lv_checked = 'checked'.
    ENDIF.

    lv_link_hint_key = mo_settings->get_link_hint_key( ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>Vimium-like Link Hints</h2>| ).
    ri_html->add( `<input type="checkbox" name="link_hints_enabled" value="X" `
                   && lv_checked && ` > Enable Vimium-like Link Hints` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<input type="text" name="link_hint_key" size="1" maxlength="1" value="{ lv_link_hint_key }" |
               && |> Key to Activate Links| ).

    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).

  ENDMETHOD.