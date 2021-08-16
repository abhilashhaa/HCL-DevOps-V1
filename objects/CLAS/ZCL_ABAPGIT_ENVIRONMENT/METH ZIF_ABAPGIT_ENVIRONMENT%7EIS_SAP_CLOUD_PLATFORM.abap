  METHOD zif_abapgit_environment~is_sap_cloud_platform.
    IF mv_cloud = abap_undefined.
      TRY.
          CALL METHOD ('CL_COS_UTILITIES')=>('IS_SAP_CLOUD_PLATFORM')
            RECEIVING
              rv_is_sap_cloud_platform = mv_cloud.
        CATCH cx_sy_dyn_call_illegal_method.
          mv_cloud = abap_false.
      ENDTRY.
    ENDIF.
    rv_result = mv_cloud.
  ENDMETHOD.