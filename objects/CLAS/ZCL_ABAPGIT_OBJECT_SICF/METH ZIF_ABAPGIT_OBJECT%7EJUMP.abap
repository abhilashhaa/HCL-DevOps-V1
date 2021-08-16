  METHOD zif_abapgit_object~jump.

    DATA: ls_bcdata TYPE bdcdata,
          lt_bcdata TYPE STANDARD TABLE OF bdcdata.

    ls_bcdata-program  = 'RSICFTREE'.
    ls_bcdata-dynpro   = '1000'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    ls_bcdata-dynpro   = space.
    ls_bcdata-dynbegin = space.
    ls_bcdata-fnam     = 'ICF_SERV'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=ONLI'.
    APPEND ls_bcdata TO lt_bcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode     = 'SICF'
        mode_val  = 'E'
      TABLES
        using_tab = lt_bcdata
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from ABAP4_CALL_TRANSACTION, SICF' ).
    ENDIF.

  ENDMETHOD.