  METHOD has_important.
    READ TABLE mt_log WITH KEY is_important = abap_true TRANSPORTING NO FIELDS.
    rv_boolean = boolc( sy-subrc IS INITIAL ).
  ENDMETHOD.