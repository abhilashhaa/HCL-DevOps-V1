  METHOD update_empty.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_exporting_parameters(
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_cls~update_class(
      EXPORTING
        it_update   = VALUE #( )
      IMPORTING
        et_failed   = lt_failed
        et_reported = lt_reported ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'Initial failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'Initial reported expected' ).

  ENDMETHOD.