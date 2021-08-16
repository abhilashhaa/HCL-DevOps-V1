  METHOD zif_abapgit_object~exists.

    TRY.
        CALL METHOD ('CL_SMTG_EMAIL_TEMPLATE')=>get
          EXPORTING
            iv_id = mv_template_id.

        rv_bool = abap_true.

      CATCH cx_root.
        rv_bool = abap_false.
    ENDTRY.

  ENDMETHOD.