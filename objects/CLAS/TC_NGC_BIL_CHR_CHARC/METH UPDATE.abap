  METHOD update.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_char_name
        charcdatatype   = if_ngc_c=>gc_charcdatatype-char
        charcstatus     = '1' )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name
        charcstatus     = '2' ) ).

    DATA(lt_charc_update) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_update(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        characteristic  = |{ th_ngc_bil_chr_data=>cv_charc_char_name }_UPD|
        charcstatus     = '2'
        %control        = VALUE #(
          charcstatus    = cl_abap_behavior_handler=>flag_changed
          characteristic = cl_abap_behavior_handler=>flag_null        " Readonly
          charcdatatype  = cl_abap_behavior_handler=>flag_null ) )
      " No change
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name
        %control        = VALUE #( ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_char_name
          status           = '2'
          value_assignment = 'S'
          data_type        = if_ngc_c=>gc_charcdatatype-char ) )
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          status           = '2'
          value_assignment = 'S' ) ) ).

    me->set_characteristic(
      it_characteristic = lt_charc_existing
      iv_keydate        = sy-datum ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'No failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'No reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( mo_cut->mt_charc_change_data )
      exp = 2
      msg = 'Expected charc should be buffered' ).

*    cl_abap_unit_assert=>assert_equals(
*      act = mo_cut->mt_charc_change_data
*      exp = lt_buffer_exp
*      msg = 'Expected charc should be buffered' ).

  ENDMETHOD.