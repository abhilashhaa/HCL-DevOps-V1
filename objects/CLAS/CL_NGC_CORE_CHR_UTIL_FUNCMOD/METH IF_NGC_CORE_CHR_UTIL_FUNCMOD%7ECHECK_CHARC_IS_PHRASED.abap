  METHOD if_ngc_core_chr_util_funcmod~check_charc_is_phrased.

    CALL FUNCTION 'C14K_CHARACT_IS_PHRASED'
      EXPORTING
        i_atinn          = iv_charcinternalid
      IMPORTING
        e_flg_phraseable = rv_phrased.

  ENDMETHOD.