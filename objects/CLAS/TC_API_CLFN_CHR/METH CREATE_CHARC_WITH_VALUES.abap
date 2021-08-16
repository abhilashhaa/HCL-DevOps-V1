  METHOD CREATE_CHARC_WITH_VALUES.

*---------------------------------------*
*---------------------------------------*
*          CHAR CHARACTERISTIC          *
*---------------------------------------*
*---------------------------------------*

    DATA(ls_charc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charc(
      characteristic      = 'AU_CLFN_CHR_CRE5'
      charcdatatype       = 'CHAR'
      charclength         = 2
      charcstatus         = '1'
    ).

    DATA(lt_charcvalue) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvalue(
      ( charcvalue = 'AB' isdefaultvalue = abap_true )
      ( charcvalue = 'CD' )
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
        it_charcdesc   = lt_charcdesc
        it_charcvalue  = lt_charcvalue
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

    SELECT * FROM a_clfncharcvalueforkeydate( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_charcvalue_created) WHERE charcinternalid = @ls_charc_created-charcinternalid.

    LOOP AT lt_charcvalue ASSIGNING FIELD-SYMBOL(<ls_charcvalue_expected>).
      TRANSLATE <ls_charcvalue_expected>-charcvalue TO UPPER CASE.

      READ TABLE lt_charcvalue_created INTO DATA(ls_charcvalue_created)
        WITH KEY charcvalue            = <ls_charcvalue_expected>-charcvalue
                 charcfromnumericvalue = <ls_charcvalue_expected>-charcfromnumericvalue
                 charctonumericvalue   = <ls_charcvalue_expected>-charctonumericvalue
                 charcvaluedependency  = COND #( WHEN <ls_charcvalue_expected>-charcvaluedependency IS INITIAL THEN 1
                                                 ELSE <ls_charcvalue_expected>-charcvaluedependency )
                 isdefaultvalue        = <ls_charcvalue_expected>-isdefaultvalue
        .

      cl_abap_unit_assert=>assert_not_initial(
        EXPORTING
          act = ls_charcvalue_created
          msg = 'Characteristic value creation failed'
      ).
    ENDLOOP.

*---------------------------------------*
*---------------------------------------*
*         NUMERIC CHARACTERISTIC        *
*---------------------------------------*
*---------------------------------------*

    CLEAR: ls_charc, ls_charc_created, lt_charcdesc, ls_charcvalue_created, lt_charcvalue, lt_charcvalue_created.

    ls_charc = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charc(
      characteristic      = 'AU_CLFN_CHR_CRE6'
      charcdatatype       = 'NUM'
      charclength         = 5
      charcdecimals       = 2
      charcstatus         = '1'
    ).

    lt_charcvalue = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvalue(
      ( charcfromnumericvalue = 145 charcvaluedependency = 1 isdefaultvalue = abap_true )
      ( charcfromnumericvalue = 155 charctonumericvalue = 165 charcvaluedependency = 2 )
      ( charcfromnumericvalue = 165 charctonumericvalue = 175 charcvaluedependency = 3 )
      ( charcfromnumericvalue = 175 charctonumericvalue = 185 charcvaluedependency = 4 )
      ( charcfromnumericvalue = 185 charctonumericvalue = 195 charcvaluedependency = 5 )
      ( charcfromnumericvalue = 195 charcvaluedependency = 6 )
      ( charcfromnumericvalue = 205 charcvaluedependency = 7 )
      ( charcfromnumericvalue = 215 charcvaluedependency = 8 )
      ( charcfromnumericvalue = 225 charcvaluedependency = 9 )
    ).

    lt_charcdesc = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcdescription = 'Characteristic description EN' language = 'EN' )
    ).

*--------------------------------------------------------------------*
* Check prerequisites
*--------------------------------------------------------------------*

    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum ) INTO @ls_charc_created
      WHERE characteristic = @ls_charc-characteristic.
    IF sy-subrc EQ 0.
      me->delete_characteristic( iv_charcinternalid = ls_charc_created-charcinternalid ).
    ENDIF.

*--------------------------------------------------------------------*
* Call (check is done in service method)
*--------------------------------------------------------------------*

    me->create_characteristic(
        is_charc       = ls_charc
        it_charcdesc   = lt_charcdesc
        it_charcvalue  = lt_charcvalue
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

    SELECT * FROM a_clfncharcvalueforkeydate( p_keydate = @sy-datum ) INTO TABLE @lt_charcvalue_created WHERE charcinternalid = @ls_charc_created-charcinternalid.

    LOOP AT lt_charcvalue ASSIGNING <ls_charcvalue_expected>.
      TRANSLATE <ls_charcvalue_expected>-charcvalue TO UPPER CASE.

      READ TABLE lt_charcvalue_created INTO ls_charcvalue_created
        WITH KEY charcvalue            = <ls_charcvalue_expected>-charcvalue
                 charcfromnumericvalue = <ls_charcvalue_expected>-charcfromnumericvalue
                 charctonumericvalue   = <ls_charcvalue_expected>-charctonumericvalue
                 charcvaluedependency  = COND #( WHEN <ls_charcvalue_expected>-charcvaluedependency IS INITIAL THEN 1
                                                 ELSE <ls_charcvalue_expected>-charcvaluedependency )
                 isdefaultvalue        = <ls_charcvalue_expected>-isdefaultvalue
        .

      cl_abap_unit_assert=>assert_not_initial(
        EXPORTING
          act = ls_charcvalue_created
          msg = 'Characteristic value creation failed'
      ).
    ENDLOOP.

  ENDMETHOD.