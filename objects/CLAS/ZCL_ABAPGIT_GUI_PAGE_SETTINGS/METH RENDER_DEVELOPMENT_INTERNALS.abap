  METHOD render_development_internals.

    DATA: lv_critical_tests TYPE string,
          lv_experimental   TYPE string,
          lv_act_wo_popup   TYPE string.

    IF mo_settings->get_run_critical_tests( ) = abap_true.
      lv_critical_tests = 'checked'.
    ENDIF.

    IF mo_settings->get_experimental_features( ) = abap_true.
      lv_experimental = 'checked'.
    ENDIF.

    IF mo_settings->get_activate_wo_popup( ) = abap_true.
      lv_act_wo_popup = 'checked'.
    ENDIF.

    CREATE OBJECT ri_html TYPE zcl_abapgit_html.
    ri_html->add( |<h2>abapGit Development Internals</h2>| ).
    ri_html->add( `<input type="checkbox" name="critical_tests" `
                   && lv_critical_tests && ` > Enable Critical Unit Tests (See LTCL_DANGEROUS)` ).
    ri_html->add( |<br>| ).
    ri_html->add( `<input type="checkbox" name="experimental_features" `
                   && lv_experimental && ` > Enable Experimental Features` ).
    ri_html->add( |<br>| ).
    ri_html->add( `<input type="checkbox" name="activate_wo_popup" `
                   && lv_act_wo_popup && ` > Activate Objects Without Popup` ).
    ri_html->add( |<br>| ).
    ri_html->add( |<br>| ).

  ENDMETHOD.