  METHOD reduce.

    IF cv_prev = iv_cur OR iv_cur IS INITIAL.
      RETURN. " No change
    ELSEIF cv_prev IS INITIAL.
      cv_prev = iv_cur.
    ELSE.
      cv_prev = zif_abapgit_definitions=>c_state-mixed.
    ENDIF.

  ENDMETHOD.