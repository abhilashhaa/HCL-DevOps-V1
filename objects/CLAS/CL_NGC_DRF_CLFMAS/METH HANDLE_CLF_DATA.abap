METHOD HANDLE_CLF_DATA.

  DELETE ct_clf_data FROM iv_packet_size + 1.

  LOOP AT ct_clf_data ASSIGNING FIELD-SYMBOL(<ls_clf_data>).
    DELETE mt_clf_data
      WHERE objekt = <ls_clf_data>-objekt
        AND anzaus = <ls_clf_data>-anzaus
        AND mafid  = <ls_clf_data>-mafid
        AND obtab  = <ls_clf_data>-obtab
        AND klart  = <ls_clf_data>-klart.
  ENDLOOP.

ENDMETHOD.