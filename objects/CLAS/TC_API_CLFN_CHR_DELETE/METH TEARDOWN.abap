  METHOD teardown.

    mo_chr_bapi_util->delete_characteristic( ms_chr_multiple-characteristic ).
    COMMIT WORK AND WAIT.

    CALL FUNCTION 'CTMV_CHARACT_INIT'.

  ENDMETHOD.