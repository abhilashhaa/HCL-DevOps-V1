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

    mo_cut->if_ngc_bil_chr~update_charc_desc(
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
      msg = 'No failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'No reported expected' ).

  ENDMETHOD.