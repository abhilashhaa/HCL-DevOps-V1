  METHOD zif_abapgit_object~jump.

    DATA: ls_dokentry TYPE dokentry,
          ls_bcdata   TYPE bdcdata,
          lt_bcdata   TYPE STANDARD TABLE OF bdcdata.

    " We need to modify dokentry directly, otherwise
    " Batch Input on SE61 wouldn't work because it stores
    " the last seen Document Class in this table. There's
    " no standard function to do this. SE61 does this
    " directly in its dialog modules
    ls_dokentry-username = sy-uname.
    ls_dokentry-langu    = sy-langu.
    ls_dokentry-class    = c_id.
    MODIFY dokentry FROM ls_dokentry.

    ls_bcdata-program  = 'SAPMSDCU'.
    ls_bcdata-dynpro   = '0100'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'RSDCU-OBJECT7'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=SHOW'.
    APPEND ls_bcdata TO lt_bcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode     = 'SE61'
        mode_val  = 'E'
      TABLES
        using_tab = lt_bcdata
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from ABAP4_CALL_TRANSACTION, DOCT' ).
    ENDIF.

  ENDMETHOD.