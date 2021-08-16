  METHOD zif_abapgit_environment~is_restart_required.
    " This method will be used in the context of SAP Cloud Platform:
    " Pull/Push operations are executed in background jobs.
    " In case of the respective application server needs to be restarted,
    " it is required to terminae the background job and reschedule again.
    rv_result = abap_false.
    TRY.
        CALL METHOD ('CL_APJ_SCP_TOOLS')=>('IS_RESTART_REQUIRED')
          RECEIVING
            restart_required = rv_result.
      CATCH cx_sy_dyn_call_illegal_method cx_sy_dyn_call_illegal_class.
        rv_result = abap_false.
    ENDTRY.
  ENDMETHOD.