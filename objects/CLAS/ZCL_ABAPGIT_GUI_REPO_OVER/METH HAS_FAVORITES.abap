  METHOD has_favorites.
    READ TABLE mt_overview WITH KEY favorite = abap_true TRANSPORTING NO FIELDS.
    IF sy-subrc = 0.
      rv_has_favorites = abap_true.
    ENDIF.
  ENDMETHOD.