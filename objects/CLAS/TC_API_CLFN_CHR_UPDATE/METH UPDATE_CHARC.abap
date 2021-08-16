  METHOD update_charc.

    DATA(ls_charc_upd) = ms_chr_multiple.
    ls_charc_upd-charcstatus = '2'.

    me->update_characteristic( ls_charc_upd ).

    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum )
      INTO @DATA(ls_charc_data)
      WHERE
        charcinternalid = @ms_chr_multiple-charcinternalid.

    cl_abap_unit_assert=>assert_equals(
      act = ls_charc_data-charcstatus
      exp = ls_charc_upd-charcstatus
      msg = |'charcstatus' should be updated| ).

  ENDMETHOD.