  METHOD refresh.

    mv_request_local_refresh = abap_true.
    reset_remote( ).

    CLEAR mi_log.

    IF iv_drop_cache = abap_true.
      CLEAR: mt_local.
    ENDIF.

  ENDMETHOD.