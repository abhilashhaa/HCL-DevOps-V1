  METHOD reset_remote.
    CLEAR mt_remote.
    mv_request_remote_refresh = abap_true.
    reset_status( ).
  ENDMETHOD.