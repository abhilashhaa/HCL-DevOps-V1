  METHOD begin.
    IF mv_session_running = abap_true.
      RAISE EXCEPTION TYPE zcx_abapgit_2fa_illegal_state.
    ENDIF.

    mv_session_running = abap_true.
  ENDMETHOD.