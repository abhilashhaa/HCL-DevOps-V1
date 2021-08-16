  METHOD create_already_existing_db.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_charc_val_desc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvaluedesc(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        language                 = 'EN'
        charcvaluedescription    = 'DESC01' ) ).

    DATA(lt_charc_val_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charcvalue(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        charcvalue               = 'VALUE01' ) ).

    DATA(lt_charc_existing) = VALUE cl_ngc_bil_chr=>lty_clfn_charc_cds-t_charc(
      ( charcinternalid = th_ngc_bil_chr_data=>cv_charc_num_id
        characteristic  = th_ngc_bil_chr_data=>cv_charc_num_name ) ).

    DATA(lt_create) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_create(
      ( charcinternalid          = th_ngc_bil_chr_data=>cv_charc_num_id
        charcvaluepositionnumber = 1
        %target         = VALUE #(
          ( %cid                  = 'CID_01'
            language              = 'EN'
            charcvaluedescription = 'DESC02' ) ) ) ).

    DATA(lt_reported_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_reported(
      ( %cid = 'CID_01' language = 'EN' ) ).

    DATA(lt_failed_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_failed(
      ( %cid = 'CID_01' language = 'EN' ) ).

    me->set_characteristic( lt_charc_existing ).
    me->set_charc_val( lt_charc_val_existing ).
    me->set_charc_val_desc( lt_charc_val_desc_existing ).

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

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_change_data
      msg = 'Expected change buffer should be read' ).

    cl_abap_unit_assert=>assert_initial(
      act = mo_cut->mt_charc_create_data
      msg = 'Expected create buffer should be read' ).

  ENDMETHOD.