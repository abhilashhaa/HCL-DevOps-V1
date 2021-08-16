  METHOD zif_abapgit_object~changed_by.

    SELECT SINGLE lstuser INTO rv_user
      FROM dm02l
      WHERE entid = me->mv_entity_id
      AND as4local = c_active_state.

    IF sy-subrc <> 0.
      rv_user = c_user_unknown.
    ENDIF.

  ENDMETHOD.