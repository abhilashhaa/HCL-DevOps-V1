  METHOD read.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->set_classification(
      it_classification = th_ngc_core_clf_pers_data=>get_classification_2017( )
      iv_keydate        = th_ngc_core_clf_pers_data=>cv_keydate_2017 ).

    me->set_valuation(
      it_valuation = th_ngc_core_clf_pers_data=>get_valuation_2017( )
      iv_keydate   = th_ngc_core_clf_pers_data=>cv_keydate_2017 ).

    me->get_classification_data(
      EXPORTING
        it_classification = VALUE #(
          ( classification = th_ngc_core_clf_pers_data=>get_classification_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
        it_valuation      = VALUE #(
          ( valuation = th_ngc_core_clf_pers_data=>get_valuation_2017( ) keydate = th_ngc_core_clf_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_classification_key = DATA(lt_classification_key)
        et_classification_exp = DATA(lt_classification_exp) ).

    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_clf_persistency~read(
        EXPORTING
          it_keys           = lt_classification_key
        IMPORTING
          et_classification = DATA(lt_classification)
          et_message        = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_equals(
        act = lt_classification
        exp = lt_classification_exp
        msg = 'Expected classification should be returned' ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = 'No messages expected' ).

    ENDDO.

  ENDMETHOD.