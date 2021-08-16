  METHOD delete_invalid_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_curr_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_curr_name ) ).

    DATA(lt_charc_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_curr_id
        language         = 'EN'
        charcdescription = 'Desc EN' ) ).

    DATA(lt_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_delete(
      " Not existing
*      ( charcinternalid = lv_charc_num_id
*        language        = 'HU' )
      " Not existing charc
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        language        = 'HU' )
      " Only one description exists
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        language        = 'EN' ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_desc( lt_charc_desc_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~delete_charc_desc(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_delete )
      msg = 'Expected number of failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_delete )
      msg = 'Expected number of reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_change_data
      msg = 'No buffered charc expected' ).

  ENDMETHOD.