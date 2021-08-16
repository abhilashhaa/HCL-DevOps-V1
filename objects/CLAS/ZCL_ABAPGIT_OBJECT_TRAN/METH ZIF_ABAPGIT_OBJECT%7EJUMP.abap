  METHOD zif_abapgit_object~jump.

    DATA: lt_bdcdata TYPE TABLE OF bdcdata.

    FIELD-SYMBOLS: <ls_bdcdata> LIKE LINE OF lt_bdcdata.


    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-program  = 'SAPLSEUK'.
    <ls_bdcdata>-dynpro   = '0390'.
    <ls_bdcdata>-dynbegin = abap_true.

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'BDC_OKCODE'.
    <ls_bdcdata>-fval = '=SHOW'.

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'TSTC-TCODE'.
    <ls_bdcdata>-fval = ms_item-obj_name.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                 = 'SE93'
        mode_val              = 'E'
      TABLES
        using_tab             = lt_bdcdata
      EXCEPTIONS
        system_failure        = 1
        communication_failure = 2
        resource_failure      = 3
        OTHERS                = 4
        ##fm_subrc_ok.    "#EC CI_SUBRC

  ENDMETHOD.