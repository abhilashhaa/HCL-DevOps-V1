  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_char_name ) ).

    DATA(lt_charc_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_delete(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id ) ).

    DATA(lt_charc_delete_data_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_delete_data(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id ) ).

    me->set_characteristic(
      it_characteristic = lt_charc_existing
      iv_keydate        = sy-datum ).

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

    cl_abap_unit_assert=>assert_initial(
      act = lt_failed
      msg = 'No failed expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_reported
      msg = 'No reported expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_delete_data
      exp = lt_charc_delete_data_exp
      msg = 'Expected charc should be buffered' ).

  ENDMETHOD.