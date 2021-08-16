  METHOD zif_abapgit_object~exists.

    DATA: lv_name TYPE ty_jd_name.

    lv_name = ms_item-obj_name.

    TRY.
        CALL METHOD ('CL_JR_JD_MANAGER')=>('CHECK_JD_EXISTENCE')
          EXPORTING
            im_jd_name     = lv_name
          IMPORTING
            ex_is_existing = rv_bool.

      CATCH cx_root.
        zcx_abapgit_exception=>raise( |JOBD not supported| ).
    ENDTRY.

  ENDMETHOD.