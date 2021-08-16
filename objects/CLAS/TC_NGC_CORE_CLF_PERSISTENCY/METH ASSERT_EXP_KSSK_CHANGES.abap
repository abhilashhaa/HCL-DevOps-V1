  METHOD assert_exp_kssk_changes.

    SORT it_act BY classinternalid classpositionnumber.
    SORT it_exp BY classinternalid classpositionnumber.

    cl_abap_unit_assert=>assert_equals(
      act = it_act
      exp = it_exp
      msg = 'Expected KSSK changes should be read' ).

  ENDMETHOD.