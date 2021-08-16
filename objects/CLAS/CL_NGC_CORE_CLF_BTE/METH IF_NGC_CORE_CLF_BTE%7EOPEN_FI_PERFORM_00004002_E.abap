  METHOD if_ngc_core_clf_bte~open_fi_perform_00004002_e.

    CALL FUNCTION 'OPEN_FI_PERFORM_00004002_E'
      EXPORTING
        i_ecm_no         = i_ecm_no
      TABLES
        i_allocation_tab = i_allocation_tab
        i_value_tab      = i_value_tab
        i_delob_tab      = i_delob_tab.

  ENDMETHOD.