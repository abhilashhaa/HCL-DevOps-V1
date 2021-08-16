  METHOD create_already_existing_buffer.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_create(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        %target         = VALUE #(
          ( %cid                     = 'CID_01'
            charcvalue               = 'VALUE01' ) ) )
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
        %target         = VALUE #(
          ( %cid                     = 'CID_02'
            charcvalue               = 'VALUE01' ) ) ) ).

    DATA(lt_buffer_change) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name    = th_ngc_bil_chr_data=>cv_charc_char_name
          data_type       = if_ngc_c=>gc_charcdatatype-char )
        charcval = VALUE #(
          ( charcvalue = 'VALUE01' value_char = 'VALUE01' charcvaluepositionnumber = 1 ) ) ) ).

    DATA(lt_buffer_create) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name    = th_ngc_bil_chr_data=>cv_charc_num_name
          data_type       = if_ngc_c=>gc_charcdatatype-char )
        charcval = VALUE #(
          ( charcvalue = 'VALUE01' value_char = 'VALUE01' charcvaluepositionnumber = 1 ) ) ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_reported(
      ( %cid = 'CID_01' )
      ( %cid = 'CID_02' ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_failed(
      ( %cid = 'CID_01' )
      ( %cid = 'CID_02' ) ).

    mo_cut->mt_charc_create_data = lt_buffer_create.
    mo_cut->mt_charc_change_data = lt_buffer_change.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_val(
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

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_change_data
      exp = lt_buffer_change
      msg = 'Expected change buffer should be read' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_create_data
      exp = lt_buffer_create
      msg = 'Expected create buffer should be read' ).


  ENDMETHOD.