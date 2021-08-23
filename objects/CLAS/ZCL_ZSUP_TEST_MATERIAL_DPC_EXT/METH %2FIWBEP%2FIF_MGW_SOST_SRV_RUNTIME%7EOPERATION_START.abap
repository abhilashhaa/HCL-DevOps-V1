  method /IWBEP/IF_MGW_SOST_SRV_RUNTIME~OPERATION_START.
**TRY.
*CALL METHOD SUPER->/IWBEP/IF_MGW_SOST_SRV_RUNTIME~OPERATION_START
**  EXPORTING
**    iv_is_first_request =
**    iv_is_last_request  =
*    .
**  CATCH /iwbep/cx_mgw_tech_exception.
**ENDTRY.
  endmethod.