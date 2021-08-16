  METHOD zif_abapgit_object~delete.

    DATA: lo_job_definition TYPE REF TO object,
          lv_name           TYPE c LENGTH 32.

    lv_name = ms_item-obj_name.

    TRY.
        CREATE OBJECT lo_job_definition TYPE ('CL_JR_JOB_DEFINITION')
          EXPORTING
            im_jd_name = lv_name.

        CALL METHOD lo_job_definition->('DELETE_JD').

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |Error deleting JOBD| ).
    ENDTRY.

  ENDMETHOD.