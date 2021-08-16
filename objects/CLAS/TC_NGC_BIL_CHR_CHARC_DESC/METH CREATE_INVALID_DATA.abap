  METHOD create_invalid_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcdesc(
      ( charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
        language         = 'HU'
        charcdescription = 'Desc HU' ) ).

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_curr_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_curr_name ) ).

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_create(
      " Already exists in db
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        %target         = VALUE #(
          ( %cid             = 'CID_01'
            charcdescription = 'Desc HU'
            language         = 'HU' ) ) )
      " Already exists in buffer
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        %target         = VALUE #(
          ( %cid             = 'CID_02'
            charcdescription = 'Desc EN'
            language         = 'EN' ) ) )
       " Empty description
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_curr_id
        %target         = VALUE #(
          ( %cid             = 'CID_04'
            language         = 'EN' ) ) ) ).

    mo_cut->mt_charc_change_data = VALUE #(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_char_name
          value_assignment = 'S' )
        charcdesc = VALUE #(
          ( language_int = 'EN'
            description  = 'Desc Existing' ) ) ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_char_name
          value_assignment = 'S' )
        charcdesc = VALUE #(
          ( language_int = 'EN'
            description  = 'Desc Existing' ) ) ) ).

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

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_create )
      msg = 'Expected number of failed should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_create )
      msg = 'Expected number of reported should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_change_data
      exp = lt_buffer_exp
      msg = 'Expected charac should be buffered' ).

  ENDMETHOD.