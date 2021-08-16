  METHOD inob_inconsistency.

    FIELD-SYMBOLS:
      <cs_clf_hdr_prev> TYPE clf_hdr.

    SORT ct_clf_hdr BY obtab objek mafid klart cuobj.
    LOOP AT ct_clf_hdr ASSIGNING FIELD-SYMBOL(<cs_clf_hdr>).
      IF <cs_clf_hdr_prev> IS ASSIGNED.
        IF <cs_clf_hdr_prev>-obtab = <cs_clf_hdr>-obtab
        AND <cs_clf_hdr_prev>-objek = <cs_clf_hdr>-objek
        AND <cs_clf_hdr_prev>-mafid = <cs_clf_hdr>-mafid
        AND <cs_clf_hdr_prev>-klart = <cs_clf_hdr>-klart.

          MESSAGE w099(sdmi) WITH
            `DB inconsistency: Multiple CUOBJs for same`
            `klart-obtab-objek in table INOB!`
            |  klart = { <cs_clf_hdr_prev>-klart }  obtab = { <cs_clf_hdr_prev>-obtab }|
            |  objek = { <cs_clf_hdr_prev>-objek }|
            INTO me->mo_logger->mv_logmsg ##NO_TEXT.
          me->mo_logger->add_message( ).

          MESSAGE w099(sdmi) WITH
            |  cuobj-1 = { <cs_clf_hdr_prev>-cuobj }|
            |  cuobj-2 = { <cs_clf_hdr>-cuobj }|
            `  Choosing the first one and skipping the second.`
            INTO me->mo_logger->mv_logmsg ##NO_TEXT.
          me->mo_logger->add_message( ).

          " We do not want duplicates with different CUOBJs, so delete the second.
          DELETE ct_clf_hdr.

          " Go to the next line without updating <cs_clf_hdr_prev>.
          CONTINUE.
        ENDIF.
      ENDIF.
      ASSIGN <cs_clf_hdr> TO <cs_clf_hdr_prev>.
    ENDLOOP.

  ENDMETHOD.