  METHOD has.

    READ TABLE mt_entries TRANSPORTING NO FIELDS WITH KEY k = iv_key.
    rv_has = boolc( sy-subrc IS INITIAL ).

  ENDMETHOD.