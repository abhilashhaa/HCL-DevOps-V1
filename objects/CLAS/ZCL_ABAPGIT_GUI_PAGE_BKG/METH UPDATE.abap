  METHOD update.

    DATA lo_persistence TYPE REF TO zcl_abapgit_persist_background.

    CREATE OBJECT lo_persistence.

    IF is_bg_task-method IS INITIAL.
      lo_persistence->delete( is_bg_task-key ).
    ELSE.
      lo_persistence->modify( is_bg_task ).
    ENDIF.

    MESSAGE 'Saved' TYPE 'S'.

    COMMIT WORK.

  ENDMETHOD.