  METHOD read_internal_key_overwrite.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->set_classes(
      it_class   = th_ngc_core_cls_pers_data=>get_classes_2017( )
      iv_keydate = th_ngc_core_cls_pers_data=>cv_keydate_2017 ).
    me->set_class_charcbasic( it_class_charcbasic = th_ngc_core_cls_pers_data=>get_class_charc_basic_ovr_2017( ) ).
    me->set_charcbasic( it_charcbasic = th_ngc_core_cls_pers_data=>get_charc_basic_ovr_2017( ) ).
    me->set_class_superior(
      it_class_superior = th_ngc_core_cls_pers_data=>get_class_superior_ovr_2017( )
      iv_keydate        = th_ngc_core_cls_pers_data=>cv_keydate_2017 ).
    me->set_class_statuses( th_ngc_core_cls_pers_data=>get_class_statuses( ) ).

    me->get_class_data_internal(
      EXPORTING
        it_class_with_keydate = VALUE #(
          ( classes = th_ngc_core_cls_pers_data=>get_classes_2017( ) keydate = th_ngc_core_cls_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_class_in  = DATA(lt_class_key)
        et_class_exp = DATA(lt_class_exp) ).

    me->get_class_charc_data(
      EXPORTING
        it_class_charc_with_kdate  = VALUE #(
          ( class_charcs = th_ngc_core_cls_pers_data=>get_class_charcs_overwr_2017( ) keydate = th_ngc_core_cls_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_class_charc_exp         = DATA(lt_class_charc_exp)
        et_characteristic_key      = DATA(lt_characteristic_key)
        et_characteristic          = DATA(lt_characteristic) ).

    me->get_charc_value_data(
      EXPORTING
        it_class_charc_with_kdate = VALUE #(
          ( class_charcs = th_ngc_core_cls_pers_data=>get_class_charcs_overwr_2017( ) keydate = th_ngc_core_cls_pers_data=>cv_keydate_2017 ) )
        it_charc_value            = th_ngc_core_cls_pers_data=>get_charc_values_overwr( )
      IMPORTING
        et_charc_value_exp        = DATA(lt_charc_value_exp) ).

    me->set_characteristic_data(
      it_charc_key      = lt_characteristic_key
      it_characteristic = lt_characteristic
      it_charc_value    = th_ngc_core_cls_pers_data=>get_charc_values_overwr( ) ).

    " Also test buffering
    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_cls_persistency~read_by_internal_key(
        EXPORTING
          it_keys = lt_class_key
        IMPORTING
          et_classes                     = DATA(lt_class)
          et_class_characteristics       = DATA(lt_class_characteristic)
          et_class_characteristic_values = DATA(lt_class_characteristic_value)
          et_characteristic_reference    = DATA(lt_characteristic_reference)
          et_message                     = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      me->assert_exp_classes(
        it_act = lt_class
        it_exp = lt_class_exp ).

      me->assert_exp_class_charcs(
        it_act = lt_class_characteristic
        it_exp = lt_class_charc_exp ).

      me->assert_exp_charc_values(
        it_act = lt_class_characteristic_value
        it_exp = lt_charc_value_exp ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_characteristic_reference
        msg = 'No references expected' ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = 'No messages expected' ).

    ENDDO.

  ENDMETHOD.