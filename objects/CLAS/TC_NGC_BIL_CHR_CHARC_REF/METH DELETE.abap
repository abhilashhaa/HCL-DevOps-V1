  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_charc_ref_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcref(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' )
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MTART' ) ).

    DATA(lt_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_delete(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcref = VALUE #(
          ( reference_table = 'MARA'
            reference_field = 'MTART' ) ) ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_ref( lt_charc_ref_existing ).

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