  METHOD render_icon_scaling.

    DATA:
      BEGIN OF ls_sel,
        auto  TYPE string,
        large TYPE string,
        small TYPE string,
      END OF ls_sel.

    CASE mo_settings->get_icon_scaling( ).
      WHEN zcl_abapgit_settings=>c_icon_scaling-large.
        ls_sel-large = ' selected'.
      WHEN zcl_abapgit_settings=>c_icon_scaling-small.
        ls_sel-small = ' selected'.
      WHEN OTHERS.
        ls_sel-auto = ' selected'.
    ENDCASE.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.

    ri_html->add( |<h2>UI Icon Scaling</h2>| ).
    ri_html->add( |<label for="icon_scaling">High DPI Icon Scaling</label>| ).
    ri_html->add( |<br>| ).
    ri_html->add( |<select name="icon_scaling" size="3">| ).
    ri_html->add( |<option value=""{ ls_sel-auto }>Auto</option>| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_icon_scaling-large }"{ ls_sel-large }>Large</option>| ).
    ri_html->add( |<option value="{ zcl_abapgit_settings=>c_icon_scaling-small }"{ ls_sel-small }>Small</option>| ).
    ri_html->add( |</select>| ).

    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).

  ENDMETHOD.