  METHOD check_errors_initial.

    cl_abap_unit_assert=>assert_initial(
      act = it_reported
      msg = 'Initial reported expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = it_failed
      msg = 'Initial failed expected' ).

  ENDMETHOD.