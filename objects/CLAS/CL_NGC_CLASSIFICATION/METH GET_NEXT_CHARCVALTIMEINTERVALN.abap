  METHOD get_next_charcvaltimeintervaln.

    rv_timeintervalnumber = '0000'.

    DATA(ls_classtype) = mo_clf_persistency->read_classtype(
      iv_clfnobjecttable = ms_classification_key-technical_object
      iv_classtype       = iv_classtype ).

    IF ls_classtype-clfnnewnumberingisallowed = abap_true.
      rv_timeintervalnumber = '0001'.
    ENDIF.

  ENDMETHOD.