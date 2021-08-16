  METHOD post_development_internals.

    mo_settings->set_run_critical_tests( is_post_field_checked( 'critical_tests' ) ).

    mo_settings->set_experimental_features( is_post_field_checked( 'experimental_features' ) ).

    mo_settings->set_activate_wo_popup( is_post_field_checked( 'activate_wo_popup' ) ).

  ENDMETHOD.