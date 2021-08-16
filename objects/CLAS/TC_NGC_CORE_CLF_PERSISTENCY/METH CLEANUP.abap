  METHOD cleanup.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    mo_cut ?= cl_ngc_core_factory=>get_clf_persistency( ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_clf_persistency~cleanup( ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_loaded_data
      msg = 'No data expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_classtypes
      msg = 'No data expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_kssk_changes
      msg = 'No data expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_inob_changes
      msg = 'No data expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_ausp_changes
      msg = 'No data expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_classes
      msg = 'No data expected' ).

  ENDMETHOD.