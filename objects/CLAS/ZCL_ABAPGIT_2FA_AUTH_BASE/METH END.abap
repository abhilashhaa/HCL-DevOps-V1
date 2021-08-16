  METHOD end.
    IF mv_session_running = abap_false.
      RAISE EXCEPTION TYPE zcx_abapgit_2fa_illegal_state.
    ENDIF.

    mv_session_running = abap_false.
  ENDMETHOD.