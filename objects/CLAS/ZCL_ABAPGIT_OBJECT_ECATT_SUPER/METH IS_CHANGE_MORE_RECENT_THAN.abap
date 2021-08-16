  METHOD is_change_more_recent_than.

    IF is_currently_changed-ldate > is_last_changed-ldate
      OR (     is_currently_changed-ldate = is_last_changed-ldate
           AND is_currently_changed-ltime > is_last_changed-ltime ).

      rv_is_change_more_recent = abap_true.

    ENDIF.

  ENDMETHOD.