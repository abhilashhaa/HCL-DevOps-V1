  METHOD check_charc_val_not_exist.

    SELECT SINGLE @abap_true FROM i_clfnobjectcharcvalue
      INTO @DATA(lv_exists)
      WHERE
        clfnobjectid             = @iv_clfnobjectid AND
        clfnobjecttable          = 'MARA' AND
        charcinternalid          = @iv_charcinternalid AND
        classtype                = @iv_classtype AND
        charcvaluepositionnumber = @iv_charcvalposnr.

    cl_abap_unit_assert=>assert_false(
      act = lv_exists
      msg = 'Charc value should not exist' ).

  ENDMETHOD.