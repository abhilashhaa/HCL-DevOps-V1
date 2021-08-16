  METHOD write_create_026.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->set_classtypes( th_ngc_core_clf_pers_data=>get_classtypes( ) ).

    me->get_changes(
      EXPORTING
        it_change_data = th_ngc_core_clf_pers_data=>get_classification_create_026( )
        it_kssk_data   = VALUE #( )
        it_inob_data   = th_ngc_core_clf_pers_data=>get_inob_changes_2017_026( )
        it_ausp_data   = VALUE #( )
        it_class       = th_ngc_core_clf_pers_data=>get_class_data_2017_026( )
        it_classtype   = th_ngc_core_clf_pers_data=>get_classtypes( )
      IMPORTING
        et_kssk_change = DATA(lt_kssk_change) ).

    mo_cut->mt_inob_changes = th_ngc_core_clf_pers_data=>get_inob_changes_2017_026( ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_clf_persistency~write(
      EXPORTING
        it_classification = th_ngc_core_clf_pers_data=>get_classification_create_026( )
        it_class          = th_ngc_core_clf_pers_data=>get_class_data_2017_026( )
      IMPORTING
        et_message        = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    me->assert_exp_kssk_creates(
      it_act = mo_cut->mt_kssk_changes
      it_exp = lt_kssk_change ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.