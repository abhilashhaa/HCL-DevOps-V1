  METHOD get.

    DATA: lt_e070use TYPE STANDARD TABLE OF e070use.

    CALL FUNCTION 'TR_TASK_GET'
      TABLES
        tt_e070use       = lt_e070use
      EXCEPTIONS
        invalid_username = 1
        invalid_category = 2
        invalid_client   = 3
        OTHERS           = 4.

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Error from TR_TASK_GET. Subrc = { sy-subrc }| ).
    ENDIF.

    READ TABLE lt_e070use INTO rs_default_task
                          INDEX 1.

  ENDMETHOD.