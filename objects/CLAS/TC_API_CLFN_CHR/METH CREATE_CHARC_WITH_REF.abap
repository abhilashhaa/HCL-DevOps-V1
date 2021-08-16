  METHOD create_charc_with_ref.

    DATA(ls_charc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charc(
      characteristic      = 'AU_CLFN_CHR_CRE3'
      charcdatatype       = 'CHAR'
      charclength         = 12
      charcstatus         = '1'
    ).

    DATA(lt_charcref) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcref(
      ( charcreferencetable = 'mara' charcreferencetablefield = 'ernam' )
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
        it_charcref  = lt_charcref
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

    SELECT * FROM a_clfncharcrefforkeydate( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_charcref_created) WHERE charcinternalid = @ls_charc_created-charcinternalid.

    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act = lt_charcref_created
        msg = 'Characteristic reference creation failed'
      ).

  ENDMETHOD.