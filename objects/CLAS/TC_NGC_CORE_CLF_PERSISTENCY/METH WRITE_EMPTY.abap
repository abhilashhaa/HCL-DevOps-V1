  METHOD write_empty.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_clf_persistency~write(
      EXPORTING
        it_classification = VALUE #( )
        it_class          = VALUE #( )
      IMPORTING
        et_message        = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_ausp_changes
      msg = 'No ausp changes expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_kssk_changes
      msg = 'No kssk expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_inob_changes
      msg = 'No inob expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.