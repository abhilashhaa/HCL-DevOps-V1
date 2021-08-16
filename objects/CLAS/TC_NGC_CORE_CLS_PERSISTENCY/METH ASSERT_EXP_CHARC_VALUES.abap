  METHOD assert_exp_charc_values.

    DATA(lt_act) = it_act.
    DATA(lt_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_act BY classinternalid charcinternalid.
    SORT lt_exp BY classinternalid charcinternalid.

    cl_abap_unit_assert=>assert_equals(
      act = lt_act
      exp = lt_exp
      msg = 'Expected characteristic values should be returned' ).


  ENDMETHOD.