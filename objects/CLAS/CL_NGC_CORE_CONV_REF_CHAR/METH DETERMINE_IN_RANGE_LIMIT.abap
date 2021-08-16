METHOD determine_in_range_limit.

  CONSTANTS:
    lc_highest_try TYPE i VALUE 32000,
    lc_start_clint TYPE i VALUE 6000000.

  DATA:
    lt_base_range  TYPE RANGE OF clint,
    lt_test_range  TYPE RANGE OF clint,
    lt_kssk        TYPE STANDARD TABLE OF kssk ##NEEDED,
    lv_error       TYPE boole_d.

  DO lc_highest_try TIMES.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = lc_start_clint + sy-index ) TO lt_base_range.
  ENDDO.

  rv_range_limit = lc_highest_try.
  lv_error = abap_true.

  WHILE rv_range_limit > 1 AND lv_error = abap_true.
    CLEAR lt_test_range.
    APPEND LINES OF lt_base_range
      FROM 1 TO rv_range_limit
      TO lt_test_range.

    TRY.
      MESSAGE i035(upgba) WITH 'Determining "IN range" limit.' ' Trying with ' rv_range_limit `  Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
      cl_upgba_logger=>log->trace_single( ).

      SELECT *
        FROM kssk
        WHERE clint IN @lt_test_range
        INTO TABLE @lt_kssk.
      lv_error = abap_false.
    CATCH cx_root ##CATCH_ALL.
      rv_range_limit = rv_range_limit / 2.
    ENDTRY.
  ENDWHILE.

  MESSAGE i035(upgba) WITH '"IN range" limit determined.' ' Limit = ' rv_range_limit `  Time: ` && cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

ENDMETHOD.