  METHOD zif_abapgit_object~jump.

    DATA: lv_mdl_technical_name TYPE c LENGTH 32,
          lv_version            TYPE bdc_fval,
          lt_bdcdata            TYPE TABLE OF bdcdata.

    FIELD-SYMBOLS: <ls_bdcdata> LIKE LINE OF lt_bdcdata.

    lv_mdl_technical_name = ms_item-obj_name.
    lv_version = ms_item-obj_name+32(4).

    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-program  = '/IWBEP/R_DST_MODEL_BUILDER'.
    <ls_bdcdata>-dynpro   = '0100'.
    <ls_bdcdata>-dynbegin = 'X'.
    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'GS_MODEL_SCREEN_100-TECHNICAL_NAME'.
    <ls_bdcdata>-fval = lv_mdl_technical_name.
    APPEND INITIAL LINE TO lt_bdcdata ASSIGNING <ls_bdcdata>.
    <ls_bdcdata>-fnam = 'GS_MODEL_SCREEN_100-VERSION'.
    <ls_bdcdata>-fval = lv_version.

    CALL FUNCTION 'ABAP4_CALL_TRANSACTION'
      STARTING NEW TASK 'GIT'
      EXPORTING
        tcode                   = '/IWBEP/REG_MODEL'
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