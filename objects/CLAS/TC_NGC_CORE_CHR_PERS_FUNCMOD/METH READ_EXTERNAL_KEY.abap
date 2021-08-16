  METHOD read_external_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_charc_data_external(
      EXPORTING
        it_characteristic_with_keydate = VALUE #(
          ( characteristics = th_ngc_core_chr_pers_data=>get_charc_funcmod_2017( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_characteristic_in  = DATA(lt_characteristic_key)
        et_characteristic_exp = DATA(lt_characteristic_exp) ).

    me->get_charc_value_fm_data(
      EXPORTING
        it_charc_value = th_ngc_core_chr_pers_data=>get_fm_charc_01_values( )
      IMPORTING
        et_charc_value_in  = DATA(lt_fm_char_01_values)
        et_charc_value_exp = DATA(lt_charc_value_exp) ).

    me->set_function_module_existing( |{ th_ngc_core_chr_pers_data=>cv_function_module_01 }_F4| ).
    me->set_charc_phrased( th_ngc_core_chr_pers_data=>cv_function_module_charcid_01 ).
    me->set_phrase_text(
      iv_phrase_key  = CONV #( th_ngc_core_chr_pers_data=>cv_value_01 )
      iv_phrase_code = th_ngc_core_chr_pers_data=>cv_phrase_01 ).
    me->set_function_module_values(
      iv_function_name   = |{ th_ngc_core_chr_pers_data=>cv_function_module_01 }_F4|
      iv_characteristic  = th_ngc_core_chr_pers_data=>cv_function_moduel_charc_01
      iv_charcinternalid = th_ngc_core_chr_pers_data=>cv_function_module_charcid_01
      it_values          = lt_fm_char_01_values ).


    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_persistency~read_by_external_key(
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
        it_exp = lt_characteristic_exp ).

      me->assert_exp_charc_values(
        it_act = lt_characteristic_value
        it_exp = lt_charc_value_exp ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_characteristic_ref
        msg = 'No charateristic references expected' ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = 'No messages expected' ).

    ENDDO.

  ENDMETHOD.