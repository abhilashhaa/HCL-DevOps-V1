  METHOD setup.

    me->set_characteristics(
      it_characteristic = th_ngc_core_chr_pers_data=>get_charc_checktab_2017( )
      iv_keydate        = th_ngc_core_chr_pers_data=>cv_keydate_2017 ).

  ENDMETHOD.