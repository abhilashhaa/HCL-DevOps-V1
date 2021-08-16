METHOD if_ngc_drf_ewm_util~cif_/sapapo/cif_chr30_inb.
  CLEAR: ct_return.

  CALL FUNCTION '/SAPAPO/CIF_CHR30_INB'
    IN BACKGROUND TASK DESTINATION iv_rfc_dest
    EXPORTING
      is_control_parameter = is_control_parameter
    TABLES
      it_cabn              = ct_cabn
      it_cabnt             = ct_cabnt
      it_cawn              = ct_cawn
      it_cawnt             = ct_cawnt
      it_cabnz             = ct_cabnz
      it_tcme              = ct_tcme
*     IT_ATNAM_MATCH       =
      et_return            = ct_return
      it_extensionin       = ct_extensionin.

  IF 1 = 2.
    CALL FUNCTION '/SAPAPO/CIF_CHR30_INB'
      DESTINATION iv_rfc_dest
      EXPORTING
        is_control_parameter = is_control_parameter
      TABLES
        it_cabn              = ct_cabn
        it_cabnt             = ct_cabnt
        it_cawn              = ct_cawn
        it_cawnt             = ct_cawnt
        it_cabnz             = ct_cabnz
        it_tcme              = ct_tcme
*       IT_ATNAM_MATCH       =
        et_return            = ct_return
        it_extensionin       = ct_extensionin.
  ENDIF.
ENDMETHOD.