METHOD UPDATE_CREATOR.

  DATA:
    lv_timestamp TYPE timestampl.

  GET TIME STAMP FIELD lv_timestamp.
  LOOP AT ct_clf_hdr ASSIGNING FIELD-SYMBOL(<cs_clf_hdr>).
    <cs_clf_hdr>-tstmp_i = lv_timestamp.
    <cs_clf_hdr>-user_i  = sy-uname.
  ENDLOOP.

ENDMETHOD.