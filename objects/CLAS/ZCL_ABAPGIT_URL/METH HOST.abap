  METHOD host.

    regex( EXPORTING iv_url = iv_url
           IMPORTING ev_host = rv_host ).

  ENDMETHOD.