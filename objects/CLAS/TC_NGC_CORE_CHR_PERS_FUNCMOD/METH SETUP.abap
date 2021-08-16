  METHOD setup.

    me->set_function_module_existing( 'C14K_CHARACT_IS_PHRASED' ).
    me->set_function_module_existing( 'C14X_PHRASE_TEXT_READ' ).

    me->set_characteristics(
      it_characteristic = th_ngc_core_chr_pers_data=>get_charc_funcmod_2017( )
      iv_keydate        = th_ngc_core_chr_pers_data=>cv_keydate_2017 ).

  ENDMETHOD.