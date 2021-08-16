  METHOD if_ngc_core_clf_bte~bf_functions_find.

    CALL FUNCTION 'BF_FUNCTIONS_FIND'
      EXPORTING
        i_event       = i_event
        i_intca       = i_intca
        i_applk       = i_applk
      TABLES
        t_fmrfc       = t_fmrfc
      EXCEPTIONS
        nothing_found = 1
        OTHERS        = 2.

  ENDMETHOD.