  METHOD update_invalid_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_charc_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        charcdescription = 'Desc HU' ) ).

    DATA(lt_update) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_update(
      " Not existing charc
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
        language         = 'HU'
        charcdescription = 'Desc UPD'
        %control         = VALUE #(
          charcdescription = cl_abap_behavior_handler=>flag_changed ) )
      " Empty desc
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        %control         = VALUE #(
          charcdescription = cl_abap_behavior_handler=>flag_changed ) ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_desc( lt_charc_desc_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~update_charc_desc(
      EXPORTING
        it_update   = lt_update
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_update )
      msg = 'Expected number of failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_update )
      msg = 'Expected number of reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_change_data
      msg = 'No buffered charc expected' ).

  ENDMETHOD.