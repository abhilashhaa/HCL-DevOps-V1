  METHOD zif_abapgit_object~jump.

    DATA: ls_bcdata TYPE bdcdata,
          lt_bcdata TYPE STANDARD TABLE OF bdcdata.

    ls_bcdata-program  = 'SAPMSSFS'.
    ls_bcdata-dynpro   = '0100'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'SSFSCREENS-SNAME'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=DISPLAY'.
    APPEND ls_bcdata TO lt_bcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode     = 'SMARTSTYLES'
        mode_val  = 'E'
      TABLES
        using_tab = lt_bcdata
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from ABAP4_CALL_TRANSACTION, SSST' ).
    ENDIF.

  ENDMETHOD.