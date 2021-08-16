  METHOD WRITE_DELETE.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->set_classtypes( th_ngc_core_clf_pers_data=>get_classtypes( ) ).
    me->set_next_cuobj( th_ngc_core_clf_pers_data=>cv_object_intkey_03 ).

    me->get_changes(
      EXPORTING
        it_change_data = th_ngc_core_clf_pers_data=>get_classification_delete_2017( )
        it_kssk_data   = th_ngc_core_clf_pers_data=>get_loaded_kssk_changes_2017( )
        it_inob_data   = th_ngc_core_clf_pers_data=>get_loaded_inob_changes_2017( )
        it_ausp_data   = th_ngc_core_clf_pers_data=>get_loaded_ausp_changes_2017( )
        it_class       = th_ngc_core_clf_pers_data=>get_class_data_2017( )
        it_classtype   = th_ngc_core_clf_pers_data=>get_classtypes( )
      IMPORTING
        et_ausp_change = DATA(lt_ausp_change)
        et_kssk_change = DATA(lt_kssk_change) ).

    mo_cut->mt_kssk_changes = th_ngc_core_clf_pers_data=>get_loaded_kssk_changes_2017( ).
    mo_cut->mt_ausp_changes = th_ngc_core_clf_pers_data=>get_loaded_ausp_changes_2017( ).
    mo_cut->mt_inob_changes = th_ngc_core_clf_pers_data=>get_loaded_inob_changes_2017( ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_clf_persistency~write(
      EXPORTING
        it_classification = th_ngc_core_clf_pers_data=>get_classification_delete_2017( )
        it_class          = th_ngc_core_clf_pers_data=>get_class_data_2017( )
      IMPORTING
        et_message        = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    me->assert_exp_ausp_changes(
      it_act = mo_cut->mt_ausp_changes
      it_exp = lt_ausp_change ).

    " Old created and updated items should be removed
    DELETE lt_kssk_change
      WHERE
        object_state = if_ngc_c=>gc_object_state-created OR
        object_state = if_ngc_c=>gc_object_state-updated.

    me->assert_exp_kssk_changes(
      it_act = mo_cut->mt_kssk_changes
      it_exp = lt_kssk_change ).

*    cl_abap_unit_assert=>assert_equals(
*      act = mo_cut->mt_inob_changes
*      exp = th_ngc_core_clf_pers_data=>get_loaded_inob_changes_2017( )
*      msg = 'Expected INOB changes should be read' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.