  METHOD zif_abapgit_object~jump.

    DATA: lv_technical_name TYPE c LENGTH 35,
          lv_version        TYPE bdc_fval,
          lt_bdcdata        TYPE TABLE OF bdcdata.

    FIELD-SYMBOLS: <ls_bdcdata> LIKE LINE OF lt_bdcdata.

    lv_technical_name = ms_item-obj_name(36).
    lv_version = ms_item-obj_name+36(4).

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-program  = '/IWBEP/R_DST_SERVICE_BUILDER'.
    <ls_bdcdata>-dynpro   = '0100'.
    <ls_bdcdata>-dynbegin = 'X'.
    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'GS_SCREEN_100-TECHNICAL_NAME'.
    <ls_bdcdata>-fval = lv_technical_name.
    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'GS_SCREEN_100-VERSION'.
    <ls_bdcdata>-fval = lv_version.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                   = '/IWBEP/REG_SERVICE'
        mode_val                = 'E'
      TABLES
        using_tab               = lt_bdcdata
      EXCEPTIONS
        call_transaction_denied = 1
        tcode_invalid           = 2
        OTHERS                  = 3.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from ABAP4_CALL_TRANSACTION. Subrc={ sy-subrc }| ).
    ENDIF.

  ENDMETHOD.