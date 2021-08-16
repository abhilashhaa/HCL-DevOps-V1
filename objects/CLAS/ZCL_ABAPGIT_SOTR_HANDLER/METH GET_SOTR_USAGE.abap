  METHOD get_sotr_usage.

    DATA: lv_obj_name TYPE trobj_name.

    lv_obj_name = iv_obj_name.

    " Objects with multiple components
    IF iv_pgmid = 'LIMU' AND ( iv_object = 'WDYV' OR iv_object = 'WAPP' ).
      lv_obj_name+30 = '%'.
    ENDIF.

    CALL FUNCTION 'SOTR_USAGE_READ'
      EXPORTING
        pgmid          = iv_pgmid
        object         = iv_object
        obj_name       = lv_obj_name
      IMPORTING
        sotr_usage     = rt_sotr_use
      EXCEPTIONS
        no_entry_found = 1
        error_in_pgmid = 2
        OTHERS         = 3.
    IF sy-subrc = 0.
      SORT rt_sotr_use.
    ENDIF.

  ENDMETHOD.