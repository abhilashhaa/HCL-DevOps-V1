  METHOD create_already_existing_buffer.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_create(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        %target         = VALUE #(
          ( %cid                  = 'CID_01'
            language              = 'EN'
            charcvaluedescription = 'DESC02' ) ) )
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber = 1
        %target         = VALUE #(
          ( %cid                  = 'CID_02'
            language              = 'EN'
            charcvaluedescription = 'DESC02' ) ) ) ).

    DATA(lt_change_buffer) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc        = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcval     = VALUE #(
          ( value_char               = 'VALUE01'
            charcvaluepositionnumber = 1 ) )
        charcvaldesc = VALUE #(
          ( description  = 'DESC01'
            language_int = 'EN' ) ) ) ).

    DATA(lt_create_buffer) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc        = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_char_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_char_name
          value_assignment = 'S' )
        charcval     = VALUE #(
          ( value_char               = 'VALUE01'
            charcvaluepositionnumber = 1 ) )
        charcvaldesc = VALUE #(
          ( description  = 'DESC01'
            language_int = 'EN' ) ) ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_reported(
      ( %cid = 'CID_01' language = 'EN' )
      ( %cid = 'CID_02' language = 'EN' ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_failed(
      ( %cid = 'CID_01' language = 'EN' )
      ( %cid = 'CID_02' language = 'EN' ) ).

    mo_cut->mt_charc_change_data = lt_change_buffer.
    mo_cut->mt_charc_create_data = lt_create_buffer.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~create_charc_val_desc(
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
      exp = lt_change_buffer
      msg = 'Expected change buffer should be read' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_charc_create_data
      exp = lt_create_buffer
      msg = 'Expected create buffer should be read' ).

  ENDMETHOD.