  METHOD assert_exp_charc_values.

    DATA(lt_characteristic_value_act) = it_act.
    DATA(lt_characteristic_value_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_characteristic_value_act BY charcinternalid charcvaluepositionnumber.
    SORT lt_characteristic_value_exp BY charcinternalid charcvaluepositionnumber.

    cl_abap_unit_assert=>assert_equals(
      act = lt_characteristic_value_act
      exp = lt_characteristic_value_exp
      msg = |Expected characteristic values should be returned| ).

  ENDMETHOD.