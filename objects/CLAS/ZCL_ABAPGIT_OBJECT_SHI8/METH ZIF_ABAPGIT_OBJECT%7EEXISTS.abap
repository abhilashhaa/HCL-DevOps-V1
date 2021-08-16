  METHOD zif_abapgit_object~exists.

    CALL FUNCTION 'STREE_SFW_ASSIGNMENT_ID_EXISTS'
      EXPORTING
        assignment_id = mv_assignment_id
      IMPORTING
        exists        = rv_bool.

  ENDMETHOD.