  METHOD read_empty_external.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_exporting_parameters(
      IMPORTING
        et_classes                     = DATA(lt_class)
        et_class_characteristics       = DATA(lt_class_characteristic)
        et_class_characteristic_values = DATA(lt_class_characteristic_value)
        et_characteristic_reference    = DATA(lt_characteristic_reference)
        et_message                     = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_cls_persistency~read_by_external_key(
      EXPORTING
        it_keys = VALUE #( )
      IMPORTING
        et_classes                     = lt_class
        et_class_characteristics       = lt_class_characteristic
        et_class_characteristic_values = lt_class_characteristic_value
        et_characteristic_reference    = lt_characteristic_reference
        et_message                     = lt_message ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_class
      msg = 'No classes expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_class_characteristic
      msg = 'No class characteristics expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_class_characteristic_value
      msg = 'No class characteristic values expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_characteristic_reference
      msg = 'No characteristic references expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.