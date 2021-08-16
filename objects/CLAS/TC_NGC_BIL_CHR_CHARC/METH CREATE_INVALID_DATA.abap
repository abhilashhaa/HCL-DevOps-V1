  METHOD create_invalid_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_existing_charc) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( characteristic  = th_ngc_bil_chr_data=>cv_charc_time_name
        charcinternalid = th_ngc_bil_chr_data=>cv_charc_time_id ) ).

    DATA(lt_charc_with_error) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_create(
      " No name
      ( %cid           = 'CID_1'
        charcdatatype  = if_ngc_c=>gc_charcdatatype-char
        charclength    = 20
        charcstatus    = '1' )
      " No length
      ( %cid           = 'CID_2'
        characteristic = th_ngc_bil_chr_data=>cv_charc_char_name
        charcdatatype  = if_ngc_c=>gc_charcdatatype-char
        charcstatus    = '1' )
      " Invalid data type
      ( %cid           = 'CID_3'
        characteristic = th_ngc_bil_chr_data=>cv_charc_num_name
        charcdatatype  = 'INV'
        charclength    = 20
        charcstatus    = '1' )
      " No status
      ( %cid           = 'CID_4'
        characteristic = th_ngc_bil_chr_data=>cv_charc_curr_name
        charcdatatype  = if_ngc_c=>gc_charcdatatype-char
        charclength    = 20 )
      " Existing charc
      ( %cid           = 'CID_5'
        characteristic = th_ngc_bil_chr_data=>cv_charc_time_name
        charcdatatype  = if_ngc_c=>gc_charcdatatype-time
        charclength    = 20
        charcstatus    = '1' ) ).

    me->set_characteristic(
      it_characteristic = lt_existing_charc
      iv_keydate        = sy-datum ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc(
      EXPORTING
        it_create   = lt_charc_with_error
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_failed )
      exp = lines( lt_charc_with_error )
      msg = 'Expected number of failed should be set' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_reported )
      exp = lines( lt_charc_with_error )
      msg = 'Expected number of reported should be set' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_mapped
      msg = 'No mapped expected' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_create_data
      msg = 'No charc should be buffered' ).

  ENDMETHOD.