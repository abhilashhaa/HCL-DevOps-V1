  METHOD create_empty.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    me->get_exporting_parameters(
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_desc(
      EXPORTING
        it_create   = VALUE #( )
      IMPORTING
        et_failed   = lt_failed
        et_reported = lt_reported
        et_mapped   = lt_mapped ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'No failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'No reported expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_mapped
      msg = 'No mapped expected' ).

  ENDMETHOD.