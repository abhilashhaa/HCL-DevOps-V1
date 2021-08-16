  METHOD adjust_numbers_change.

    DATA:
      lo_cut TYPE REF TO if_ngc_bil_chr_transactional.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_change_data) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charact_name    = th_ngc_bil_chr_data=>cv_charc_char_name
          charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id
          data_type       = if_ngc_c=>gc_charcdatatype-char
          length          = 20
          status          = '1' )
        charcdesc = VALUE #(
          ( language_int = 'EN' description = 'Desc' ) )
        charcref  = VALUE #(
          ( reference_table = 'MARA' reference_field = 'MATNR' ) )
        charcrstr = VALUE #(
          ( class_type = '001' ) )
        charcval  = VALUE #(
          ( charcvaluepositionnumber = 1 value_char = 'VALUE01' )
          ( charcvaluepositionnumber = 4 value_char = 'VALUE02' created = abap_true ) )
        charcvaldesc = VALUE #(
          ( language_int = 'EN' description = 'VAL DESC01' value_char = 'VALUE02' )
          ( language_int = 'DE' description = 'VAL DESC02' value_char = 'VALUE02' ) ) ) ).

    DATA(lt_charc_val_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_mapped_late(
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id
        %tmp-charcvaluepositionnumber = 4
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 2 ) ).

    DATA(lt_charc_val_desc_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_mapped_late(
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id
        %tmp-charcvaluepositionnumber = 4
        %tmp-language                 = 'EN'
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 2
        language                      = 'EN' )
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id
        %tmp-charcvaluepositionnumber = 4
        %tmp-language                 = 'DE'
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 2
        language                      = 'DE' ) ).

    mo_cut->mt_charc_change_data = lt_change_data.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    lo_cut ?= mo_cut.
    lo_cut->adjust_numbers(
      IMPORTING
        et_charc_mapped          = DATA(lt_charc_mapped)
        et_charc_desc_mapped     = DATA(lt_charc_desc_mapped)
        et_charc_ref_mapped      = DATA(lt_charc_ref_mapped)
        et_charc_rstr_mapped     = DATA(lt_charc_rstr_mapped)
        et_charc_val_mapped      = DATA(lt_charc_val_mapped)
        et_charc_val_desc_mapped = DATA(lt_charc_val_desc_mapped) ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_charc_mapped
      msg = 'Expected charc mapped should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_charc_desc_mapped
      msg = 'Expected charc desc mapped should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_charc_ref_mapped
      msg = 'Expected charc ref mapped should be returned' ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_charc_rstr_mapped
      msg = 'Expected charc rstr mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_val_mapped
      exp = lt_charc_val_mapped_exp
      msg = 'Expected charc val mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_val_desc_mapped
      exp = lt_charc_val_desc_mapped_exp
      msg = 'Expected charc val desc mapped should be returned' ).

  ENDMETHOD.