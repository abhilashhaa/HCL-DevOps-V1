  METHOD get_statuses_for_classtype.

    CLEAR: es_incomplete_status, es_incomplete_system_status, es_locked_status, es_released_status.

    DATA(lt_clf_status) = mo_clf_persistency->read_clf_statuses( iv_classtype ).

    IF es_released_status IS REQUESTED.
      READ TABLE lt_clf_status
       INTO es_released_status
        WITH KEY
          frei  = abap_true.
    ENDIF.

    IF es_locked_status IS REQUESTED.
      READ TABLE lt_clf_status
       INTO es_locked_status
        WITH KEY
          gesperrt = abap_true.
    ENDIF.

    IF es_incomplete_status IS REQUESTED.
      READ TABLE lt_clf_status
       INTO es_incomplete_status
        WITH KEY
          unvollstm = abap_true.
    ENDIF.

    IF es_incomplete_system_status IS REQUESTED.
      READ TABLE lt_clf_status
       INTO es_incomplete_system_status
        WITH KEY
          unvollsts = abap_true.
    ENDIF.

  ENDMETHOD.