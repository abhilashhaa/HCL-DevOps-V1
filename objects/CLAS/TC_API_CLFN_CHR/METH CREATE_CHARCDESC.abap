  METHOD create_charcdesc.

*--------------------------------------------------------------------*
* Prerequisites
*--------------------------------------------------------------------*
    SELECT SINGLE * FROM a_clfncharacteristicforkeydate( p_keydate = @sy-datum ) INTO @DATA(ls_charc)
      WHERE characteristic = 'ZST_CHARC_UT_1'.
    IF sy-subrc <> 0.
      DATA(lv_charcinternalid) = me->create_characteristic( is_charc     = VALUE #( characteristic = 'ZST_CHARC_UT_1'
                                                                                    charcdatatype  = 'CHAR'
                                                                                    charclength    = 10
                                                                                    charcstatus    = '1' )
                                                            it_charcdesc = VALUE #( ( language         = 'EN'
                                                                                      charcdescription = 'Test desc EN' ) ) ).

    ELSE.
      lv_charcinternalid = ls_charc-charcinternalid.
    ENDIF.



*--------------------------------------------------------------------*
* Description to create
*--------------------------------------------------------------------*

    DATA(ls_charcdesc_with_int) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charcdesc(
          charcdescription = 'Test desc DE'
          charcinternalid  = lv_charcinternalid
          language         = 'DE'
    ).

*--------------------------------------------------------------------*
* Call
*--------------------------------------------------------------------*
    me->create_characteristicdesc(
        is_charcdesc = ls_charcdesc_with_int
    ).

*--------------------------------------------------------------------*
* Through navigation property
*--------------------------------------------------------------------*

    DATA(ls_charcdesc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-s_charcdesc(
          charcdescription = 'Test desc HU'
          charcinternalid  = lv_charcinternalid
          language         = 'HU'
    ).

*--------------------------------------------------------------------*
* Call
*--------------------------------------------------------------------*
    me->create_characteristicdesc(
        is_charcdesc  = ls_charcdesc
        iv_navigation = abap_true
    ).

*--------------------------------------------------------------------*
* Asserts
*--------------------------------------------------------------------*

    SELECT * FROM a_clfncharcdescforkeydate( p_keydate = @sy-datum ) INTO TABLE @DATA(lt_charcdesc_created)
      WHERE charcinternalid = @lv_charcinternalid.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lines( lt_charcdesc_created )
        exp = 3
        msg = 'Characteristic description creation failed' ).

    READ TABLE lt_charcdesc_created WITH KEY language = 'D' TRANSPORTING NO FIELDS.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = sy-subrc
        exp = 0
        msg = 'German description is missing' ).

    READ TABLE lt_charcdesc_created WITH KEY language = 'E' TRANSPORTING NO FIELDS.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = sy-subrc
        exp = 0
        msg = 'English description is missing' ).

    READ TABLE lt_charcdesc_created WITH KEY language = 'H' TRANSPORTING NO FIELDS.

    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = sy-subrc
        exp = 0
        msg = 'Hungarian description is missing' ).

*--------------------------------------------------------------------*
* Delete charc
*--------------------------------------------------------------------*

    me->delete_characteristic( iv_charcinternalid = lv_charcinternalid ).


  ENDMETHOD.