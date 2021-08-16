  METHOD read_internal_object_number.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_classtype)  = th_ngc_core_clf_pers_data=>get_classtypes( ).
    DATA(lv_cuobj_exp)  = CONV cuobj( th_ngc_core_clf_pers_data=>cv_object_intkey_03 ).

    me->set_classtypes( lt_classtype ).
    me->set_next_cuobj( th_ngc_core_clf_pers_data=>cv_object_intkey_03 ).

    DATA(lt_classtype_param) = VALUE ngct_classtype( ( classtype = lt_classtype[ 1 ]-classtype ) ).

    me->set_classification(
      it_classification = th_ngc_core_clf_pers_data=>get_classification_2017( )
      iv_keydate        = th_ngc_core_clf_pers_data=>cv_keydate_2017 ).

    me->get_classification_data(
      EXPORTING
        it_classification = VALUE #(
          ( classification = th_ngc_core_clf_pers_data=>get_classification_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
        it_valuation      = VALUE #(
          ( valuation = th_ngc_core_clf_pers_data=>get_valuation_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_classification_key = DATA(lt_classification_key) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    DO 2 TIMES.
      mo_cut->if_ngc_core_clf_persistency~read_internal_object_number(
        EXPORTING
          is_classification_key = lt_classification_key[ 1 ]
          it_classtype          = lt_classtype_param
         RECEIVING
          rt_obj_int_id         = DATA(lt_obj_int_id_act)
      ).
    ENDDO.
*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_obj_int_id_act[ 1 ]-clfnobjectinternalid
      exp = lv_cuobj_exp ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_obj_int_id_act[ 1 ]-clfnobjectid
      exp = lt_classification_key[ 1 ]-object_key ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_obj_int_id_act[ 1 ]-classtype
      exp = lt_classtype[ 1 ]-classtype ).

  ENDMETHOD.