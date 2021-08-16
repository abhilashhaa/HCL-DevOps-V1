  METHOD adjust_numbers_create.

    DATA:
      lo_cut TYPE REF TO if_ngc_bil_chr_transactional.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    DATA(lt_cabn) = VALUE tt_cabn(
      ( atnam = th_ngc_bil_chr_data=>cv_charc_char_name
        atinn = th_ngc_bil_chr_data=>cv_charc_char_id ) ).

    DATA(lt_create_data) = VALUE cl_ngc_bil_chr=>lty_t_charc_data(
      ( charc = VALUE #(
          charact_name    = th_ngc_bil_chr_data=>cv_charc_char_name
          charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
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
          ( charcvaluepositionnumber = 1 value_char = 'VALUE01' ) )
        charcvaldesc = VALUE #(
          ( language_int = 'EN' description = 'VAL DESC01' value_char = 'VALUE01' )
          ( language_int = 'DE' description = 'VAL DESC02' value_char = 'VALUE01' ) ) ) ).

    DATA(lt_charc_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharctp-t_mapped_late(
      ( %tmp-charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        charcinternalid      = th_ngc_bil_chr_data=>cv_charc_char_id ) ).

    DATA(lt_charc_desc_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcdesctp-t_mapped_late(
      ( %tmp-charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-language        = 'EN'
        charcinternalid      = th_ngc_bil_chr_data=>cv_charc_char_id
        language             = 'EN' ) ).

    DATA(lt_charc_ref_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcreftp-t_mapped_late(
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-charcreferencetable      = 'MARA'
        %tmp-charcreferencetablefield = 'MATNR'
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcreferencetable           = 'MARA'
        charcreferencetablefield      = 'MATNR' ) ).

    DATA(lt_charc_rstr_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcrstrcntp-t_mapped_late(
      ( %tmp-charcinternalid = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-classtype       = '001'
        charcinternalid      = th_ngc_bil_chr_data=>cv_charc_char_id
        classtype            = '001' ) ).

    DATA(lt_charc_val_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaltp-t_mapped_late(
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-charcvaluepositionnumber = 1
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 1 ) ).

    DATA(lt_charc_val_desc_mapped_exp) = VALUE if_ngc_bil_chr_c=>lty_clfncharcvaldesctp-t_mapped_late(
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-charcvaluepositionnumber = 1
        %tmp-language                 = 'EN'
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 1
        language                      = 'EN' )
      ( %tmp-charcinternalid          = th_ngc_bil_chr_data=>cv_charc_char_id_tmp
        %tmp-charcvaluepositionnumber = 1
        %tmp-language                 = 'DE'
        charcinternalid               = th_ngc_bil_chr_data=>cv_charc_char_id
        charcvaluepositionnumber      = 1
        language                      = 'DE' ) ).

    me->set_cabn( lt_cabn ).

    mo_cut->mt_charc_create_data = lt_create_data.

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

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_mapped
      exp = lt_charc_mapped_exp
      msg = 'Expected charc mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_desc_mapped
      exp = lt_charc_desc_mapped_exp
      msg = 'Expected charc desc mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_ref_mapped
      exp = lt_charc_ref_mapped_exp
      msg = 'Expected charc ref mapped should be returned' ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_charc_rstr_mapped
      exp = lt_charc_rstr_mapped_exp
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