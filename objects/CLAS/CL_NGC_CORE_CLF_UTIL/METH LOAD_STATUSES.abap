  METHOD load_statuses.

    DATA:
      lt_tclc TYPE STANDARD TABLE OF tclc.


    CHECK gts_clf_status IS INITIAL.

    TEST-SEAM select_from_tclc.
      SELECT * FROM tclc INTO CORRESPONDING FIELDS OF TABLE lt_tclc "#EC CI_GENBUFF
        WHERE loeschvorm <> abap_true
        ORDER BY mandt klart statu.
    END-TEST-SEAM.

    LOOP AT lt_tclc ASSIGNING FIELD-SYMBOL(<ls_tclc>).
      DATA(ls_clf_status) = VALUE ts_clf_status( ).
      MOVE-CORRESPONDING <ls_tclc> TO ls_clf_status.
      ls_clf_status-clfnstatusdescription = COND #(
        WHEN <ls_tclc>-frei      = abap_true THEN TEXT-000 " Released
        WHEN <ls_tclc>-gesperrt  = abap_true THEN TEXT-001 " Locked
        WHEN <ls_tclc>-unvollstm = abap_true THEN TEXT-002 " Incomplete
        WHEN <ls_tclc>-unvollsts = abap_true THEN TEXT-003 " Incomplete System
      ).
      INSERT ls_clf_status INTO TABLE gts_clf_status.
    ENDLOOP.

  ENDMETHOD.