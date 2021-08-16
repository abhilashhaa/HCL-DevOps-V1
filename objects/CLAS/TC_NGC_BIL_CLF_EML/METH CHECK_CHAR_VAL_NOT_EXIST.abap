  METHOD check_char_val_not_exist.

    SELECT SINGLE @abap_true FROM i_clfnobjectcharcvalue
      INTO @DATA(lv_value_exists)
      WHERE
        clfnobjectid    = @iv_clfnobjectid AND
        clfnobjecttable = 'MARA' AND
        charcinternalid = @iv_charcinternalid AND
        classtype       = @iv_classtype AND
        charcvalue      = @iv_charcvalue.

    cl_abap_unit_assert=>assert_false(
      act = lv_value_exists
      msg = 'Charc value should not exist' ).

  ENDMETHOD.