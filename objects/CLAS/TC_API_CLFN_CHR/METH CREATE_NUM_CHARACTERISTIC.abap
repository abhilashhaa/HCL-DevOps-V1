  METHOD create_num_characteristic.

    DATA(ls_charc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charc(
          characteristic      = 'AU_CLFN_CHR_CRE1'
          charcdatatype       = 'NUM'
          charclength         = 5
          charcdecimals       = 2
          charcstatus         = '1'
    ).


    DATA(lt_charcdesc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcdescription = 'Characteristic description EN' language = 'EN' )
    ).

*--------------------------------------------------------------------*
* Check prerequisites
*--------------------------------------------------------------------*
    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum ) INTO @DATA(ls_charc_created)
      WHERE characteristic = @ls_charc-characteristic.
    IF sy-subrc EQ 0.
      me->delete_characteristic( iv_charcinternalid = ls_charc_created-charcinternalid ).
    ENDIF.

*--------------------------------------------------------------------*
* Call (check is done in service method)
*--------------------------------------------------------------------*
    me->create_characteristic(
        is_charc     = ls_charc
        it_charcdesc = lt_charcdesc
    ).

*--------------------------------------------------------------------*
* Check result from DB
*--------------------------------------------------------------------*
    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum ) INTO @ls_charc_created
      WHERE characteristic = @ls_charc-characteristic.

    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act = ls_charc_created
        msg = 'Characteristic creation failed' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = ls_charc_created-charcdatatype
        exp = 'NUM'
        msg = '"NUM" characteristic data type expected.' ).


    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = ls_charc_created-charclength
        exp = 5
        msg = 'Characteristic value length of 5 was expected' ).

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = ls_charc_created-charcdecimals
        exp = 2
        msg = 'Characteristic value with 2 decimals was expected' ).

  ENDMETHOD.