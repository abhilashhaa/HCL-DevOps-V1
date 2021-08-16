  METHOD read_internal_key.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_mara) = th_ngc_core_chr_pers_data=>get_mara_for_checktable( ).
    DATA(lt_makt) = th_ngc_core_chr_pers_data=>get_makt_for_checktable( ).

    me->set_checktable_existing( th_ngc_core_chr_pers_data=>cv_checktable_mara ).
    me->set_checktable_existing( th_ngc_core_chr_pers_data=>cv_texttable_makt ).
    me->set_select_data(
      iv_table_name = th_ngc_core_chr_pers_data=>cv_checktable_mara
      it_values     = lt_mara ).
    me->set_select_data(
      iv_table_name = th_ngc_core_chr_pers_data=>cv_texttable_makt
      it_values     = lt_makt ).
    me->set_text_table(
      iv_table_name = th_ngc_core_chr_pers_data=>cv_checktable_mara
      iv_texttable  = th_ngc_core_chr_pers_data=>cv_texttable_makt
      iv_checkfield = 'MATNR' ).
    me->set_table_details(
      iv_table_name = th_ngc_core_chr_pers_data=>cv_checktable_mara
      it_field_list = VALUE #(
        ( dtyp = 'CLNT' fieldname = 'MANDT' )
        ( dtyp = 'CHAR' fieldname = 'MATNR' )
        ( dtyp = 'CHAR' fieldname = 'MTART' ) ) ).
    me->set_table_details(
      iv_table_name = th_ngc_core_chr_pers_data=>cv_texttable_makt
      it_field_info = VALUE #(
        ( fieldname = 'MANDT' datatype = 'CLNT' inttype = 'C' keyflag = abap_true )
        ( fieldname = 'MATNR' datatype = 'CHAR' inttype = 'C' keyflag = abap_true )
        ( fieldname = 'SPRAS' datatype = 'LANG' inttype = 'C' keyflag = abap_true )
        ( fieldname = 'MAKTX' datatype = 'CHAR' inttype = 'C' keyflag = abap_false ) ) ).

    me->get_charc_data_internal(
      EXPORTING
        it_characteristic_with_keydate = VALUE #(
          ( characteristics = th_ngc_core_chr_pers_data=>get_charc_checktab_2017( ) keydate = th_ngc_core_chr_pers_data=>cv_keydate_2017 ) )
      IMPORTING
        et_characteristic_in  = DATA(lt_characteristic_key)
        et_characteristic_exp = DATA(lt_characteristic_exp) ).


    " Also test buffering
    DO 2 TIMES.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_persistency~read_by_internal_key(
        EXPORTING
          it_key                      = lt_characteristic_key
        IMPORTING
          et_characteristic           = DATA(lt_characteristic)
          et_characteristic_value     = DATA(lt_characteristic_value)
          et_characteristic_reference = DATA(lt_characteristic_ref)
          et_message                  = DATA(lt_message) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      DATA(lt_charc_value_exp) = VALUE ngct_core_charc_value(
        ( charcinternalid = '0000000010' charcvalue = 'MAT_01' charcvaluedependency = '1' charcvaluedescription = 'Test description 01' key_date = '20170101' )
        ( charcinternalid = '0000000010' charcvalue = 'MAT_02' charcvaluedependency = '1' charcvaluedescription = 'Test description 02' key_date = '20170101' ) ).

      me->assert_exp_characteristics(
        it_act = lt_characteristic
        it_exp = lt_characteristic_exp ).

      cl_abap_unit_assert=>assert_equals(
        act = lt_characteristic_value
        exp = lt_charc_value_exp
        msg = 'Expected characteristic values returned' ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_characteristic_ref
        msg = 'No charateristic references expected' ).

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = 'No messages expected' ).

    ENDDO.

  ENDMETHOD.