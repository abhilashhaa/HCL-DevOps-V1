  METHOD constructor.

    ASSERT NOT is_data-key IS INITIAL.

    ms_data = is_data.
    mv_request_remote_refresh = abap_true.

  ENDMETHOD.