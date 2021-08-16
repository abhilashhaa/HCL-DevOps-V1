  METHOD update.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_charc_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        charcdescription = 'Desc HU' )
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'EN'
        charcdescription = 'Desc EN' ) ).

    DATA(lt_update) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_update(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        charcdescription = 'Desc UPD'
        %control         = VALUE #(
          charcdescription = cl_abap_behavior_handler=>flag_changed ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcdesc = VALUE #(
          ( description  = 'Desc UPD'
            language_int = 'HU' )
          ( description  = 'Desc EN'
            language_int = 'EN' ) ) ) ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'No failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'No reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_change_data
      exp = lt_buffer_exp
      msg = 'Expected charac should be buffered' ).

  ENDMETHOD.