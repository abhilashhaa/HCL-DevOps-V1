  METHOD render_hotkeys.

    DATA lv_hk_id TYPE string.
    DATA lt_hotkeys LIKE mt_default_hotkeys.
    FIELD-SYMBOLS <ls_key> LIKE LINE OF mt_default_hotkeys.

    mt_default_hotkeys = zcl_abapgit_hotkeys=>get_all_default_hotkeys( ). " Cache for save processing
    lt_hotkeys = mt_default_hotkeys.
    zcl_abapgit_hotkeys=>merge_hotkeys_with_settings( CHANGING ct_hotkey_actions = lt_hotkeys ).

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>Hotkeys</h2>| ).

    ri_html->add( '<table class="settings_tab">' ).
    ri_html->add( '<thead><tr><th>Component</th><th>Action</th><th>Key</th></tr></thead>' ).

    LOOP AT lt_hotkeys ASSIGNING <ls_key>.

      ri_html->add( '<tr>' ).
      ri_html->add( |<td>{ <ls_key>-ui_component }</td>| ).
      ri_html->add( |<td>{ <ls_key>-description }</td>| ).
      lv_hk_id = |hk~{ <ls_key>-ui_component }~{ <ls_key>-action }|.
      ri_html->add( |<td><input name="{ lv_hk_id }" maxlength=1 type="text" value="{ <ls_key>-hotkey }"></td>| ).
      ri_html->add( '</tr>' ).

    ENDLOOP.

    ri_html->add( '</table>' ).

  ENDMETHOD.