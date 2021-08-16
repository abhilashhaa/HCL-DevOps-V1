  METHOD convert_object_id.

    DATA: ls_rmclf TYPE rmclf.

    CHECK iv_object_table_from NE iv_object_table_to.

    ls_rmclf-objek = cv_object_id.

    CALL FUNCTION 'CLCV_CONVERT_OBJECT_TO_FIELDS'
      EXPORTING
        rmclfstru      = ls_rmclf
        table          = iv_object_table_from
      IMPORTING
        rmclfstru      = ls_rmclf
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.
    CHECK sy-subrc EQ 0.

    CALL FUNCTION 'CLCV_CONVERT_FIELDS_TO_OBJECT'
      EXPORTING
        rmclfstru      = ls_rmclf
        table          = iv_object_table_to
      IMPORTING
        rmclfstru      = ls_rmclf
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.
    CHECK sy-subrc EQ 0.

    cv_object_id = ls_rmclf-objek.

  ENDMETHOD.