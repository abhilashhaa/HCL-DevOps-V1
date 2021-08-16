  METHOD get_charcvalposnr.

    SELECT SINGLE charcvaluepositionnumber FROM i_clfnobjectcharcvalue
      INTO @rv_charcvalposnr
      WHERE
        clfnobjectid    = @iv_clfnobjectid AND
        clfnobjecttable = 'MARA' AND
        charcinternalid = @iv_charcinternalid AND
        classtype       = @iv_classtype AND
        charcvalue      = @iv_charcvalue.

    cl_abap_unit_assert=>assert_subrc(
      act = sy-subrc
      exp = 0
      msg = 'Charc value should exist' ).

  ENDMETHOD.