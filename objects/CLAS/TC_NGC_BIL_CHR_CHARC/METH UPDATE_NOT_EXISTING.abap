  METHOD update_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_update) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_update(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_char_name
        charcstatus     = '2'
        %control        = VALUE #(
          charcstatus   = cl_abap_behavior_handler=>flag_changed
          charcdatatype = cl_abap_behavior_handler=>flag_null ) )
      " No change
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name
        %control        = VALUE #( ) ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~update_charc(
      EXPORTING
        it_update   = lt_charc_update
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_charc_update )
      msg = 'Expected number of failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_charc_update )
      msg = 'Expected number of reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_change_data
      msg = 'Empty buffer expected' ).

  ENDMETHOD.