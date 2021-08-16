  METHOD setup.

    me->set_characteristics(
      it_characteristic = th_ngc_core_chr_pers_data=>get_characteristics_2017( )
      iv_keydate        = th_ngc_core_chr_pers_data=>cv_keydate_2017 ).
    me->set_characteristics(
      it_characteristic = th_ngc_core_chr_pers_data=>get_characteristics_2018( )
      iv_keydate        = th_ngc_core_chr_pers_data=>cv_keydate_2018 ).

    me->set_characteristic_values(
      it_characteristic_value = th_ngc_core_chr_pers_data=>get_charc_value_2017( )
      iv_keydate              = th_ngc_core_chr_pers_data=>cv_keydate_2017 ).
    me->set_characteristic_values(
      it_characteristic_value = th_ngc_core_chr_pers_data=>get_charc_value_2018( )
      iv_keydate              = th_ngc_core_chr_pers_data=>cv_keydate_2018 ).

    me->set_characteristic_refs(
      it_characteristic_ref = th_ngc_core_chr_pers_data=>get_charc_ref( )
      iv_keydate            = th_ngc_core_chr_pers_data=>cv_keydate_2017 ).

  ENDMETHOD.