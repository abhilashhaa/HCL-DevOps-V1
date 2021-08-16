  METHOD delete.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_charc_val_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvalue(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        charcvalue               = 'VALUE01' )
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 2
        charcvalue               = 'VALUE02' ) ).

    DATA(lt_charc_val_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvaluedesc(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        language                 = 'EN'
        charcvaluedescription    = 'DESC01' )
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 2
        language                 = 'EN'
        charcvaluedescription    = 'DESC02' ) ).

    DATA(lt_delete) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_delete(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 2
        language                 = 'EN' ) ).

    DATA(lt_buffer_exp) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charcinternalid  = th_ngc_bil_chr_data=>cv_charc_num_id
          charact_name     = th_ngc_bil_chr_data=>cv_charc_num_name
          value_assignment = 'S' )
        charcval = VALUE #(
          ( charcvalue = 'VALUE01' value_char = 'VALUE01' charcvaluepositionnumber = 1 value_relation = 1 )
          ( charcvalue = 'VALUE02' value_char = 'VALUE02' charcvaluepositionnumber = 2 value_relation = 1 ) )
        charcvaldesc = VALUE #(
          ( description = 'DESC01' language_int = 'EN' value_char = 'VALUE01' ) ) ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_val( lt_charc_val_existing ).
    me->set_charc_val_desc( lt_charc_val_desc_existing ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_bil_chr~delete_charc_val_desc(
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