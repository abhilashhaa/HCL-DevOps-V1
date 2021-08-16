  METHOD assert_exp_classtypes.

    SORT it_act BY classtype clfnobjecttable.
    SORT it_exp BY classtype clfnobjecttable.

    cl_abap_unit_assert=>assert_equals(
      act = it_act
      exp = it_exp
      msg = 'Expected AUSP changes should be read' ).

  ENDMETHOD.