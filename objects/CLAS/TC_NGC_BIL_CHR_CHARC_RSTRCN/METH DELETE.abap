  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_charc_rstr_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcrstrcn(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        classtype        = '001' )
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        classtype        = '300' ) ).

    DATA(lt_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_delete(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        classtype       = '001' ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcrstr = VALUE #(
          ( class_type = '300' ) ) ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_rstr( lt_charc_rstr_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~delete_charc_rstr(
      EXPORTING
        it_delete   = lt_delete
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