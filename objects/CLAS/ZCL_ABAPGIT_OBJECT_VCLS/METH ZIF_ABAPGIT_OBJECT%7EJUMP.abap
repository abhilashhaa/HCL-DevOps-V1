  METHOD zif_abapgit_object~jump.

    DATA: ls_bcdata TYPE bdcdata,
          lt_bcdata TYPE STANDARD TABLE OF bdcdata.

    ls_bcdata-program  = 'SAPMSVIM'.
    ls_bcdata-dynpro   = '0050'.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'VIMDYNFLDS-VIEWNAME'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'VIMDYNFLDS-STRUCT_MNT'.
    ls_bcdata-fval     = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=CLUS'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-program  = 'SAPMSVIM'.
    ls_bcdata-dynpro   = '0052 '.
    ls_bcdata-dynbegin = 'X'.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam     = 'VIMDYNFLDS-VCLNAME'.
    ls_bcdata-fval     = ms_item-obj_name.
    APPEND ls_bcdata TO lt_bcdata.

    CLEAR ls_bcdata.
    ls_bcdata-fnam = 'BDC_OKCODE'.
    ls_bcdata-fval = '=CLSH'.
    APPEND ls_bcdata TO lt_bcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode     = 'SE54'
        mode_val  = 'E'
      TABLES
        using_tab = lt_bcdata
      EXCEPTIONS
        OTHERS    = 1.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( 'error from ABAP4_CALL_TRANSACTION, SE35' ).
    ENDIF.

  ENDMETHOD.