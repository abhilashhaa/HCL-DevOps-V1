  METHOD zif_abapgit_object~jump.

    DATA: ls_bcdata TYPE bdcdata,
          lt_bcdata TYPE STANDARD TABLE OF bdcdata.

    ls_bcdata-program  = 'SAPLSPERS_REG_DIALOG'.
    ls_bcdata-dynpro   = '0100'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'SPERS_REG-PERS_KEY'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=PERSDISPLAY'.
    APPEND ls_bcdata TO lt_bcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                   = 'PERSREG'
        mode_val                = 'E'
      TABLES
        using_tab               = lt_bcdata
      EXCEPTIONS
        call_transaction_denied = 1
        tcode_invalid           = 2
        OTHERS                  = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |error from ABAP4_CALL_TRANSACTION, PERSREG. SUBRC= {  sy-subrc }| ).
    ENDIF.

  ENDMETHOD.