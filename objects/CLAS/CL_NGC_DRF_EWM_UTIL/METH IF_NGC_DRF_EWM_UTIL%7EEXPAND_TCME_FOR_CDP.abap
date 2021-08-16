METHOD if_ngc_drf_ewm_util~expand_tcme_for_cdp.

  DATA:
    lt_atinns TYPE STANDARD TABLE OF cabn-atinn.

  LOOP AT ct_tcme ASSIGNING FIELD-SYMBOL(<cs_tcme>).
    READ TABLE lt_atinns
      TRANSPORTING NO FIELDS
      WITH KEY
        table_line = <cs_tcme>-atinn
      BINARY SEARCH.
    IF NOT sy-subrc IS INITIAL.
      INSERT <cs_tcme>-atinn INTO lt_atinns INDEX sy-tabix.
    ENDIF.
  ENDLOOP.

  " now append entries for CDP (Klart = 400) for all given
  " characteristics
  LOOP AT lt_atinns ASSIGNING FIELD-SYMBOL(<lv_atinn>).
    APPEND INITIAL LINE TO ct_tcme ASSIGNING <cs_tcme>.
    <cs_tcme>-mandt = sy-mandt.
    <cs_tcme>-atinn = <lv_atinn>.
    <cs_tcme>-klart = '400'.
  ENDLOOP.

  SORT ct_tcme.
  DELETE ADJACENT DUPLICATES FROM ct_tcme.

ENDMETHOD.