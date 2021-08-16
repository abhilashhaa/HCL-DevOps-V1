  METHOD delete_charc.

    me->delete_characteristic( ms_chr_multiple-charcinternalid ).

    SELECT SINGLE @abap_true FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum )
      INTO @DATA(lv_exists)
      WHERE
        charcinternalid = @ms_chr_multiple-charcinternalid.

    cl_abap_unit_assert=>assert_false(
      act = lv_exists
      msg = |characteristic should not exist| ).

  ENDMETHOD.