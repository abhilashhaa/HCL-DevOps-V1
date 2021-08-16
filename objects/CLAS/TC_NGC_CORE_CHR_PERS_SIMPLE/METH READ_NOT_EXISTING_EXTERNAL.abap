  METHOD read_not_existing_external.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_charc_data_external(
      EXPORTING
        it_characteristic_with_keydate = VALUE #(
          ( characteristics = th_ngc_core_chr_pers_data=>get_not_existing_charc( )   keydate = th_ngc_core_chr_pers_data=>cv_keydate_2018 )
          ( characteristics = th_ngc_core_chr_pers_data=>get_characteristics_2017( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2018 ) )
      IMPORTING
        et_characteristic_in  = DATA(lt_characteristic_key) ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_characteristic
      msg = 'No characteristics expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_characteristic_value
      msg = 'No characteristic values expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_characteristic_ref
      msg = 'No characteristic references expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = lines( lt_characteristic_key )
      msg = 'Expected number of messages should be returned' ).

  ENDMETHOD.