  METHOD assert_exp_characteristics.

    DATA(lt_characteristic_act) = it_act.
    DATA(lt_characteristic_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_characteristic_act BY characteristic.
    SORT lt_characteristic_exp BY characteristic.

    cl_abap_unit_assert=>assert_equals(
      act = lt_characteristic_act
      exp = lt_characteristic_exp
      msg = |Expected characteristics should be returned| ).

  ENDMETHOD.