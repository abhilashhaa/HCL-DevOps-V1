  METHOD create_already_existing_db.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_ref_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcref(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR' ) ).

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_create(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        %target         = VALUE #(
          ( %cid                     = 'CID_02'
            charcreferencetable      = 'MARA'
            charcreferencetablefield = 'MATNR' ) ) ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_reported(
      ( charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR'
        %cid                     = 'CID_02' ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_failed(
      ( charcreferencetable      = 'MARA'
        charcreferencetablefield = 'MATNR'
        %cid                     = 'CID_02' ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_ref( lt_charc_ref_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_ref(
      EXPORTING
        it_create   = lt_create
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
      msg = 'No buffer expected' ).

  ENDMETHOD.