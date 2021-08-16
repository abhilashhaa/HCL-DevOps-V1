  METHOD read_empty_external.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_exporting_parameters(
      IMPORTING
        et_characteristic       = DATA(lt_characteristic)
        et_characteristic_value = DATA(lt_characteristic_value)
        et_characteristic_ref   = DATA(lt_characteristic_ref)
        et_message              = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_persistency~read_by_external_key(
      EXPORTING
        it_key = VALUE #( )
      IMPORTING
        et_characteristic           = lt_characteristic
        et_characteristic_value     = lt_characteristic_value
        et_characteristic_reference = lt_characteristic_ref
        et_message                  = lt_message ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.