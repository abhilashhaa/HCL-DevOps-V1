  METHOD ASSERT_EXP_CHARC_REF.

    DATA(lt_act) = it_act.
    DATA(lt_exp) = it_exp.

    " Order of items is not relevant for us
    SORT lt_act BY charcinternalid charcreferencetable charcreferencetablefield.
    SORT lt_exp BY charcinternalid charcreferencetable charcreferencetablefield.

    cl_abap_unit_assert=>assert_equals(
      act = lt_act
      exp = lt_exp
      msg = 'Expected characteristic references should be returned' ).


  ENDMETHOD.