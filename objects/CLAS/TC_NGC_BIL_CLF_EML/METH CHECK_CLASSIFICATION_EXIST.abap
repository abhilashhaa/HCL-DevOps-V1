  METHOD check_classification_exist.

    SELECT SINGLE @abap_true FROM i_clfnobjectclass
      INTO @DATA(lv_exists)
      WHERE
        clfnobjectid    = @iv_clfnobjectid AND
        clfnobjecttable = 'MARA' AND
        classinternalid = @iv_classinternalid.

    cl_abap_unit_assert=>assert_true(
      act = lv_exists
      msg = 'Class assignment should exist' ).

  ENDMETHOD.