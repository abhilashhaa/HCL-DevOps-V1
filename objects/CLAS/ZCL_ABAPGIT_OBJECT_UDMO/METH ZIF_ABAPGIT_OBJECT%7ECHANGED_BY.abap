  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE lstuser INTO rv_user
      FROM dm40l
      WHERE dmoid = me->mv_data_model
      AND as4local = me->mv_activation_state.

    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.