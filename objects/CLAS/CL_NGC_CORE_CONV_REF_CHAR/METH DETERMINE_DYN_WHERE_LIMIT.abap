METHOD determine_dyn_where_limit.

  CONSTANTS:
    lc_highest_try TYPE i VALUE 64000,
    lc_start_clint TYPE i VALUE 6000000.

  DATA:
    lv_test_dynwhr TYPE string,
    lt_kssk        TYPE STANDARD TABLE OF kssk ##NEEDED,
    lv_error       TYPE boole_d,
    lv_clint       TYPE clint.

  rv_dyn_where_limit = lc_highest_try.
  lv_error = abap_true.

  WHILE rv_dyn_where_limit > 1 AND lv_error = abap_true.
    CLEAR lv_test_dynwhr.
    DO rv_dyn_where_limit TIMES.
      IF sy-index > 1.
        lv_test_dynwhr = lv_test_dynwhr && ` OR ` ##NO_TEXT.
      ENDIF.
      lv_clint = lc_start_clint + sy-index.
      lv_test_dynwhr = lv_test_dynwhr && `clint = ` && lv_clint ##NO_TEXT.
    ENDDO.

    TRY.
      MESSAGE i035(upgba) WITH 'Determining "dynamic where" limit.' ' Trying with ' rv_dyn_where_limit `  Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).

      SELECT *
        FROM kssk
        WHERE (lv_test_dynwhr) "#EC CI_DYNWHERE
        INTO TABLE @lt_kssk.
      lv_error = abap_false.
    CATCH cx_root ##CATCH_ALL.
      rv_dyn_where_limit = rv_dyn_where_limit / 2.
    ENDTRY.
  ENDWHILE.

  MESSAGE i035(upgba) WITH '"dynamic where" limit determined.' ' Limit = ' rv_dyn_where_limit `  Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

ENDMETHOD.