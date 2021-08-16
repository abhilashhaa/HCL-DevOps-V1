METHOD get_clstype_ech.

  READ TABLE mt_clstype_ech ASSIGNING FIELD-SYMBOL(<ls_clstype_ech>) WITH TABLE KEY klart = iv_klart  obtab = iv_obtab.
  IF sy-subrc EQ 0.
    rv_aediezuord = <ls_clstype_ech>-aediezuord.
  ELSE.
    " So the customizing does not contain this class type. (db inconsistency)
    rv_aediezuord = abap_false.
  ENDIF.

ENDMETHOD.