  METHOD poheaderset_get_entityset.
    SELECT ebeln bukrs bstyp bsart bsakz
    FROM ekko INTO TABLE et_entityset UP TO 10 ROWS.
  ENDMETHOD.