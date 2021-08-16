  METHOD delete_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_delete(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~delete_charc(
      EXPORTING
        it_delete   = lt_charc_delete
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_charc_delete )
      msg = 'Expected number of failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_charc_delete )
      msg = 'Expected number of reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = lines( mo_cut->mt_charc_delete_data )
      msg = 'No delete buffer expected' ).

  ENDMETHOD.