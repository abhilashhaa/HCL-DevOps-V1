  METHOD get_stage_logic.

    IF gi_stage_logic IS INITIAL.
      CREATE OBJECT gi_stage_logic
        TYPE zcl_abapgit_stage_logic.
    ENDIF.

    ri_logic = gi_stage_logic.

  ENDMETHOD.