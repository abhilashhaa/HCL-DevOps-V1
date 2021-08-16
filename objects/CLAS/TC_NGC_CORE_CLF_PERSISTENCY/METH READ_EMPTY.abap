  METHOD read_empty.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_read_exporting_parameters(
      IMPORTING
        et_classification = DATA(lt_classification)
        et_message        = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_clf_persistency~read(
      EXPORTING
        it_keys           = VALUE #( )
      IMPORTING
        et_classification = lt_classification
        et_message        = lt_message ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_classification
      msg = 'No classification expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.