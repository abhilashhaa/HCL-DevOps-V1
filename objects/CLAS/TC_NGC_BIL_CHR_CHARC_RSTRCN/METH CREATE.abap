  METHOD create.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_rstr_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcrstrcn(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        classtype        = '300' ) ).

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_create(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        %target         = VALUE #(
          ( %cid      = 'CID_02'
            classtype = '001' ) ) )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_curr_id        " Deep insert
        %cid_ref        = 'CID_REF_01'
        %target         = VALUE #(
          ( %cid      = 'CID_04'
            classtype = '001' ) ) )
*      ( %target         = VALUE #(                                    " Direct create (uncomment later)
*          ( %cid             = 'CID_05'
*            charcinternalid  = th_ngc_bil_chr_data=>cv_charc_date_id
*            charcdescription = 'Desc 01'
*            language         = 'EN' ) ) )
       ).

    mo_cut->mt_charc_create_data = VALUE #(
      ( charc = VALUE #(
          cid              = 'CID_REF_01'
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_curr_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_curr_name
          value_assignment = 'S' ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcrstr = VALUE #(
          ( class_type = '300' )
          ( class_type = '001' ) ) )
*      ( charc = VALUE #(
*          charcinternalid = th_ngc_bil_chr_data=>cv_charc_date_id
*          charact_name    = th_ngc_bil_chr_data=>cv_charc_date_name )
*        charcdesc = VALUE #(
*          ( description  = 'Desc 01'
*            language_int = 'EN' ) ) )
       ).

    me->set_characteristic(
      it_characteristic = lt_charc_existing
      iv_keydate        = sy-datum ).

    me->set_charc_rstr( lt_charc_rstr_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_rstr(
      EXPORTING
        it_create   = lt_create
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
      msg = 'Expected change buffer should be read' ).

  ENDMETHOD.