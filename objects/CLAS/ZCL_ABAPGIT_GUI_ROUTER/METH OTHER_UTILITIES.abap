  METHOD other_utilities.

    CASE ii_event->mv_action.
      WHEN zif_abapgit_definitions=>c_action-changed_by.
        zcl_abapgit_services_basis=>test_changed_by( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-performance_test.
        zcl_abapgit_services_basis=>run_performance_test( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
      WHEN zif_abapgit_definitions=>c_action-ie_devtools.
        zcl_abapgit_services_basis=>open_ie_devtools( ).
        rs_handled-state = zcl_abapgit_gui=>c_event_state-no_more_act.
    ENDCASE.

  ENDMETHOD.