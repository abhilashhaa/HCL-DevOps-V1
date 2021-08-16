  METHOD read_internal_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_charc_data_internal(
      EXPORTING
        it_characteristic_with_keydate = VALUE #(
          ( characteristics = th_ngc_core_chr_pers_data=>get_characteristics_2017( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2017 )
          ( characteristics = th_ngc_core_chr_pers_data=>get_characteristics_2018( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2018 ) )
      IMPORTING
        et_characteristic_in  = DATA(lt_characteristic_key)
        et_characteristic_exp = DATA(lt_charateristic_exp) ).

    me->get_charc_value_data(
      EXPORTING
        it_charc_value     = VALUE  #(
          ( charc_values = th_ngc_core_chr_pers_data=>get_charc_value_2017( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2017 )
          ( charc_values = th_ngc_core_chr_pers_data=>get_charc_value_2018( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2018 ) )
      IMPORTING
        et_charc_value_exp = DATA(lt_charc_value_exp) ).

    me->get_charc_ref_data(
      EXPORTING
        it_charc_ref     = VALUE #(
          ( th_ngc_core_chr_pers_data=>get_charc_ref( ) ) )
      IMPORTING
        et_charc_ref_exp = DATA(lt_charc_ref_exp) ).

    " Also test buffering
    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_persistency~read_by_internal_key(
        EXPORTING
          it_key                      = lt_characteristic_key
        IMPORTING
          et_characteristic           = DATA(lt_characteristic)
          et_characteristic_value     = DATA(lt_characteristic_value)
          et_characteristic_reference = DATA(lt_characteristic_ref)
          et_message                  = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      me->assert_exp_characteristics(
        it_act = lt_characteristic
        it_exp = lt_charateristic_exp ).

      me->assert_exp_charc_values(
        it_act = lt_characteristic_value
        it_exp = lt_charc_value_exp ).

      me->assert_exp_charc_refs(
        it_act = lt_characteristic_ref
        it_exp = lt_charc_ref_exp ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = 'No messages expected' ).

    ENDDO.

  ENDMETHOD.