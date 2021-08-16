  METHOD create.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        charcdescription = 'Desc HU' ) ).

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_char_name )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_create(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        %target         = VALUE #(
          ( %cid             = 'CID_01'
            charcdescription = 'Desc 01' ) ) )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        %target         = VALUE #(
          ( %cid             = 'CID_02'
            charcdescription = 'Desc 01'
            language         = 'EN' )
          ( %cid             = 'CID_03'
            charcdescription = 'Desc 02'
            language         = 'DE' ) ) )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_curr_id        " Deep insert
        %cid_ref        = 'CID_REF_01'
        %target         = VALUE #(
          ( %cid             = 'CID_04'
            charcdescription = 'Desc 01'
            language         = 'EN' ) ) )
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
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_char_name
          value_assignment = 'S' )
        charcdesc = VALUE #(
          ( description  = 'Desc 01'
            language_int = sy-langu ) ) )
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcdesc = VALUE #(
          ( description  = 'Desc HU'
            language_int = 'HU' )
          ( description  = 'Desc 01'
            language_int = 'EN' )
          ( description  = 'Desc 02'
            language_int = 'DE' ) ) )
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

    me->set_charc_desc( lt_charc_desc_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_desc(
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