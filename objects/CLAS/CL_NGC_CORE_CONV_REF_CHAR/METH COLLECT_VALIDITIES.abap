METHOD collect_validities.

  DATA:
    ls_refval TYPE lts_refvalidity,
    lv_datuv  TYPE datuv,
    lv_aennr  TYPE aennr.

  LOOP AT it_siblchrs ASSIGNING FIELD-SYMBOL(<ls_siblchr>) WHERE obtab = iv_obtab AND objek = iv_objek.
    " And ensure their interval-edges are not beyond the kssk interval-edges:
    IF <ls_siblchr>-auspdatuv > <ls_siblchr>-ksskdatuv.
      lv_datuv = <ls_siblchr>-auspdatuv.
      lv_aennr = <ls_siblchr>-auspaennr.
    ELSE.
      lv_datuv = <ls_siblchr>-ksskdatuv.
      lv_aennr = <ls_siblchr>-ksskaennr.
    ENDIF.
    " ...We could do the same for datub, but we do not care (use) datub at this point.

    " Collect the datuv and aennr:
    " And we have to avoid duplicates at this point because of the AENNR:
    READ TABLE ct_refvals ASSIGNING FIELD-SYMBOL(<ls_refval>) WITH KEY datuv = lv_datuv.
    IF sy-subrc NE 0.
      CLEAR ls_refval.
      ls_refval-datuv = lv_datuv.
      ls_refval-aennr = lv_aennr.
      INSERT ls_refval INTO TABLE ct_refvals.
    ELSEIF <ls_siblchr>-auspaennr NE '' AND <ls_refval>-aennr = ''.
      " Maybe we can gain an aennr here (this case is probably a DB inconsistency).
      <ls_refval>-aennr = <ls_siblchr>-auspaennr.
    ENDIF.
  ENDLOOP.

ENDMETHOD.