  METHOD check_classification_not_exist.

    SELECT SINGLE @abap_true FROM i_clfnobjectclass
      INTO @DATA(lv_exists)
      WHERE
        clfnobjectid    = @iv_clfnobjectid AND
        clfnobjecttable = 'MARA' AND
        classinternalid = @iv_classinternalid.

    cl_abap_unit_assert=>assert_false(
      act = lv_exists
      msg = 'Class assignment should not exist' ).

  ENDMETHOD.