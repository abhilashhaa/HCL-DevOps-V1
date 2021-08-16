  METHOD render_ui_theme.

    " TODO: unify with render_icon_scaling, make list component

    DATA:
      BEGIN OF ls_sel,
        default         TYPE string,
        dark            TYPE string,
        belize          TYPE string,
        synced_with_gui TYPE string,
      END OF ls_sel.

    CASE mo_settings->get_ui_theme( abap_false ).
      WHEN zcl_abapgit_settings=>c_ui_theme-default.
        ls_sel-default = ' selected'.
      WHEN zcl_abapgit_settings=>c_ui_theme-dark.
        ls_sel-dark = ' selected'.
      WHEN zcl_abapgit_settings=>c_ui_theme-belize.
        ls_sel-belize = ' selected'.
      WHEN zcl_abapgit_settings=>c_ui_theme-synced_with_gui.
        ls_sel-synced_with_gui = ' selected'.
    ENDCASE.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h2>UI Theme</h2>| ).
    ri_html->add( |<label for="ui_theme">UI Theme</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<select name="ui_theme" size="4">| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_ui_theme-default }"{
      ls_sel-default }>{ zcl_abapgit_settings=>c_ui_theme-default }</option>| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_ui_theme-dark }"{
      ls_sel-dark }>{ zcl_abapgit_settings=>c_ui_theme-dark }</option>| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_ui_theme-belize }"{
      ls_sel-belize }>{ zcl_abapgit_settings=>c_ui_theme-belize }</option>| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_ui_theme-synced_with_gui }"{
      ls_sel-synced_with_gui }>Synced with SAP GUI</option>| ).
    ri_html->add( |</select>| ).

    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).

  ENDMETHOD.