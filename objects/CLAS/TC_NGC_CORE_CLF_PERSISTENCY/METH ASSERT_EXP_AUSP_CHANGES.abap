  METHOD assert_exp_ausp_changes.

    SORT it_act BY clfnobjectid clfnobjecttype charcinternalid charcvaluepositionnumber.
    SORT it_exp BY clfnobjectid clfnobjecttype charcinternalid charcvaluepositionnumber.

    cl_abap_unit_assert=>assert_equals(
      act = it_act
      exp = it_exp
      msg = 'Expected AUSP changes should be read' ).

  ENDMETHOD.