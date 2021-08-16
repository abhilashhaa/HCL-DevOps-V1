  METHOD create_charc_with_rstrcn.

    DATA(ls_charc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charc(
      characteristic      = 'AU_CLFN_CHR_CRE4'
      charcdatatype       = 'CHAR'
      charclength         = 30
      charcstatus         = '1'
    ).

    DATA(lt_charcrstrcn) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcrstrcn(
      ( classtype = '001' )
      ( classtype = '002' )
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
        is_charc       = ls_charc
        it_charcdesc = lt_charcdesc
        it_charcrstrcn = lt_charcrstrcn
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

    SELECT * FROM a_clfncharcrstrcnforkeydate( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_charcrstrcn_created) WHERE charcinternalid = @ls_charc_created-charcinternalid.

    LOOP AT lt_charcrstrcn ASSIGNING FIELD-SYMBOL(<ls_charcrstrcn_expected>).
      READ TABLE lt_charcrstrcn_created INTO DATA(ls_charcrstrcn_created)
        WITH KEY classtype = <ls_charcrstrcn_expected>-classtype.

      cl_abap_unit_assert=>assert_not_initial(
        EXPORTING
          act = ls_charcrstrcn_created
          msg = 'Characteristic restriction creation failed'
      ).
    ENDLOOP.

  ENDMETHOD.