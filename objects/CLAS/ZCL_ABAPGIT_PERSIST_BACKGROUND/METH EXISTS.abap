  METHOD exists.

    list( ). " Ensure mt_jobs is populated
    READ TABLE mt_jobs WITH KEY key = iv_key TRANSPORTING NO FIELDS.
    rv_yes = boolc( sy-subrc = 0 ).

  ENDMETHOD.