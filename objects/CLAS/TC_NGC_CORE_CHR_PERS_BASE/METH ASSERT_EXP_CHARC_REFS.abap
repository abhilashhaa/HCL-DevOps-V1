  METHOD assert_exp_charc_refs.

    DATA(lt_characteristic_ref_act) = it_act.
    DATA(lt_characteristic_ref_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_characteristic_ref_act BY charcinternalid charcreferencetable charcreferencetablefield.
    SORT lt_characteristic_ref_exp BY charcinternalid charcreferencetable charcreferencetablefield.

    cl_abap_unit_assert=>assert_equals(
      act = lt_characteristic_ref_act
      exp = lt_characteristic_ref_exp
      msg = |Expected characteristic value references should be returned| ).

  ENDMETHOD.