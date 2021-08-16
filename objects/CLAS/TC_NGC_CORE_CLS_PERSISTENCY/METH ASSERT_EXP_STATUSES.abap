  METHOD assert_exp_statuses.

    DATA(lt_act) = it_act.
    DATA(lt_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_act BY classtype classstatus.
    SORT lt_exp BY classtype classstatus.

    cl_abap_unit_assert=>assert_equals(
      act = lt_act
      exp = lt_exp
      msg = 'Expected class statuses should be returned' ).

  ENDMETHOD.