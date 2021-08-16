  METHOD assert_exp_classes.

    DATA(lt_act) = it_act.
    DATA(lt_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_act BY classinternalid.
    SORT lt_exp BY classinternalid.

    cl_abap_unit_assert=>assert_equals(
      act = lt_act
      exp = lt_exp
      msg = 'Expected classes should be returned' ).

  ENDMETHOD.