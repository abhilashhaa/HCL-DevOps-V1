  METHOD visit.

    IF NOT iv_parent IS INITIAL.
      READ TABLE ct_visit FROM iv_parent TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        APPEND iv_parent TO ct_visit.
      ENDIF.
    ENDIF.

  ENDMETHOD.