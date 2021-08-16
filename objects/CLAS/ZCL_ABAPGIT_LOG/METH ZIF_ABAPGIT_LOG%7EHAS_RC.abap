  METHOD zif_abapgit_log~has_rc.
* todo, this method is only used in unit tests

    READ TABLE mt_log WITH KEY rc = iv_rc TRANSPORTING NO FIELDS.
    rv_yes = boolc( sy-subrc = 0 ).
  ENDMETHOD.