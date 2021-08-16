  METHOD zif_abapgit_object~jump.

    DATA: lt_bdcdata TYPE STANDARD TABLE OF bdcdata,
          ls_bdcdata LIKE LINE OF lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-program  = 'SAPMSCDO_NEW'.
    ls_bdcdata-dynpro   = '0100'.
    ls_bdcdata-dynbegin = abap_true.
    APPEND ls_bdcdata TO lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'TCDOB-OBJECT'.
    ls_bdcdata-fval = mv_object.
    APPEND ls_bdcdata TO lt_bdcdata.

    CLEAR: ls_bdcdata.
    ls_bdcdata-fnam = 'BDC_OKCODE'.
    ls_bdcdata-fval = '=DISP'.
    APPEND ls_bdcdata TO lt_bdcdata.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                 = 'SCDO'
        mode_val              = 'E'
      TABLES
        using_tab             = lt_bdcdata
      EXCEPTIONS
        system_failure        = 1
        communication_failure = 2
        resource_failure      = 3
        OTHERS                = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |ERROR: Jump { mv_object }| ).
    ENDIF.

  ENDMETHOD.