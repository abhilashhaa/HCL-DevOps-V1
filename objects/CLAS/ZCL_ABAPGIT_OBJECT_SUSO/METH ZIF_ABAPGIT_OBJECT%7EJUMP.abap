  METHOD zif_abapgit_object~jump.

    CALL FUNCTION 'SUSR_SHOW_OBJECT'
      EXPORTING
        object = mv_objectname.

  ENDMETHOD.