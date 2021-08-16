  METHOD delete_charc_not_existing.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_delete(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_reported(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_failed(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~delete_charc_ref(
      EXPORTING
        it_delete   = lt_delete
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lt_failed
      exp = lt_failed_exp
      msg = 'Expected failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_reported
      exp = lt_reported_exp
      msg = 'Expected reported should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_change_data
      msg = 'No buffered charc expected' ).

  ENDMETHOD.