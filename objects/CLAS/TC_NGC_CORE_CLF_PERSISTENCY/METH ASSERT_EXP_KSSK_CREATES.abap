  METHOD ASSERT_EXP_KSSK_CREATES.

    SORT it_act BY classinternalid classpositionnumber.
    SORT it_exp BY classinternalid classpositionnumber.

    cl_abap_unit_assert=>assert_equals(
      act = it_act
      exp = it_exp
      msg = 'Expected KSSK contains incorrect data' ).

  ENDMETHOD.