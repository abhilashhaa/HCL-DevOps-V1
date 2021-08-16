  METHOD create.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_create(
      ( %cid                     = 'CID_1'
        characteristic           = th_ngc_bil_chr_data=>cv_charc_char_name
        charcdatatype            = if_ngc_c=>gc_charcdatatype-char
        charclength              = 20
        charcstatus              = '1'
        multiplevaluesareallowed = abap_true )
      ( %cid                     = 'CID_2'
        characteristic           = th_ngc_bil_chr_data=>cv_charc_num_name
        charcdatatype            = if_ngc_c=>gc_charcdatatype-num
        charclength              = 5
        charcdecimals            = 2
        charcstatus              = '1'
        charcvalueunit           = 'KG' )
      ( %cid                     = 'CID_3'
        characteristic           = th_ngc_bil_chr_data=>cv_charc_time_name
        charcdatatype            = if_ngc_c=>gc_charcdatatype-time
        charclength              = 6
        charcstatus              = '1' )
      ( %cid                     = 'CID_4'
        characteristic           = th_ngc_bil_chr_data=>cv_charc_date_name
        charcdatatype            = if_ngc_c=>gc_charcdatatype-date
        charclength              = 8
        charcstatus              = '1' )
      ( %cid                     = 'CID_5'
        characteristic           = th_ngc_bil_chr_data=>cv_charc_curr_name
        charcdatatype            = if_ngc_c=>gc_charcdatatype-curr
        charclength              = 6
        charcdecimals            = 3 " 2 should be returned for currency
        charcstatus              = '2'
        currency                 = 'HUF' ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid         = 1
          cid                     = 'CID_1'
          charact_name            = th_ngc_bil_chr_data=>cv_charc_char_name
          data_type               = if_ngc_c=>gc_charcdatatype-char
          length                  = 20
          status                  = '1'
          value_assignment        = 'M' ) )
      ( charc = VALUE #(
          charcinternalid         = 2
          cid                     = 'CID_2'
          charact_name            = th_ngc_bil_chr_data=>cv_charc_num_name
          data_type               = if_ngc_c=>gc_charcdatatype-num
          length                  = 5
          decimals                = 2
          status                  = '1'
          value_assignment        = 'S'
          unit_of_measurement     = 'KG'
          unit_of_measurement_iso = 'KG' ) )
      ( charc = VALUE #(
          charcinternalid         = 3
          cid                     = 'CID_3'
          charact_name            = th_ngc_bil_chr_data=>cv_charc_time_name
          data_type               = if_ngc_c=>gc_charcdatatype-time
          length                  = 6
          status                  = '1'
          value_assignment        = 'S' ) )
      ( charc = VALUE #(
          charcinternalid         = 4
          cid                     = 'CID_4'
          charact_name            = th_ngc_bil_chr_data=>cv_charc_date_name
          data_type               = if_ngc_c=>gc_charcdatatype-date
          length                  = 8
          status                  = '1'
          value_assignment        = 'S' ) )
       ( charc = VALUE #(
          charcinternalid         = 5
          cid                     = 'CID_5'
          charact_name            = th_ngc_bil_chr_data=>cv_charc_curr_name
          data_type               = if_ngc_c=>gc_charcdatatype-curr
          length                  = 6
          decimals                = 2
          status                  = '2'
          currency                = 'HUF'
          currency_iso            = 'HUF'
          value_assignment        = 'S' ) ) ).

    DATA(lt_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_mapped(
      ( %cid            = 'CID_1'
        charcinternalid = 1 )
      ( %cid            = 'CID_2'
        charcinternalid = 2 )
      ( %cid            = 'CID_3'
        charcinternalid = 3 )
      ( %cid            = 'CID_4'
        charcinternalid = 4 )
      ( %cid            = 'CID_5'
        charcinternalid = 5 ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc(
      EXPORTING
        it_create   = lt_charc
      IMPORTING
        et_failed   = DATA(lt_failed)
        et_reported = DATA(lt_reported)
        et_mapped   = DATA(lt_mapped) ).

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
      act = lt_mapped
      exp = lt_mapped_exp
      msg = 'Expected mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_create_data
      exp = lt_buffer_exp
      msg = 'Expected charc should be buffered' ).

  ENDMETHOD.