  METHOD create_empty.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    get_responses(
      IMPORTING
        es_mapped        = DATA(ls_mapped)
        es_reported      = DATA(ls_reported)
        es_failed        = DATA(ls_failed) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_clf~create_objcharcval(
      EXPORTING
        it_input    = VALUE #( )
      IMPORTING
        es_mapped   = ls_mapped
        es_failed   = ls_failed
        es_reported = ls_reported ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = ls_failed
      msg = 'No failed entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_reported
      msg = 'No reported entry was expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = ls_mapped
      msg = 'No mapped entry was expected' ).

  ENDMETHOD.