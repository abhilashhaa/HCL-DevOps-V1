  METHOD run_inspection.

    io_inspection->run(
      EXPORTING
        p_howtorun            = mv_run_mode
      EXCEPTIONS
        invalid_check_version = 1
        OTHERS                = 2 ).

    IF sy-subrc <> 0.
      zcx_abapgit_exception=>raise( |Code inspector run failed. Subrc = { sy-subrc }| ).
    ENDIF.

    io_inspection->plain_list( IMPORTING p_list = rt_list ).

    SORT rt_list BY objtype objname test code sobjtype sobjname line col.

    DELETE ADJACENT DUPLICATES FROM rt_list.

  ENDMETHOD.