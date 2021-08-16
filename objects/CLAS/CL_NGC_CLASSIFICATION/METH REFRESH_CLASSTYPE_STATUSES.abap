  METHOD refresh_classtype_statuses.

    LOOP AT mt_classtype ASSIGNING FIELD-SYMBOL(<ls_classtype>).
      mo_clf_status->get_classtype_status(
        EXPORTING
          iv_classtype      = <ls_classtype>-classtype
          io_classification = me
        IMPORTING
          ev_inconsistent   = <ls_classtype>-isinconsistent
          ev_released       = <ls_classtype>-isreleased ).
    ENDLOOP.

  ENDMETHOD.