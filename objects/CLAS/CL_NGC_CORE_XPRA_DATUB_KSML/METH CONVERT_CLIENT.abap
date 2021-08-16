METHOD convert_client.

  TYPES:
    lrty_mandt           TYPE RANGE OF mandt,
    lrty_clint           TYPE RANGE OF clint,
    ltty_named_seltab    TYPE cl_shdb_pfw_seltab=>tt_named_seltab,
    ltty_tabsplit_cols   TYPE if_shdb_pfw_package_provider=>tt_cols.

  CONSTANTS:
    lc_package_size      TYPE i VALUE 200000.

  DATA:
    ls_tabsplit          TYPE cl_shdb_pfw_pack_base=>ts_tables,
    lr_table_splitter    TYPE REF TO if_shdb_pfw_table_splitter,
    lt_tabsplit_packsel  TYPE if_shdb_pfw_package_provider=>tt_packsel,
    lt_clint_first       TYPE TABLE OF clint.

  IF mv_rework EQ abap_false.
    " Determine the first DATUB=00000000 to avoid reprocessing the previously processed rows
    SELECT clint FROM ksml CLIENT SPECIFIED
      INTO TABLE @lt_clint_first
      UP TO 1 ROWS
      WHERE mandt = @mv_client AND datub = '00000000'
      ORDER BY clint.
  ENDIF.

  IF mv_rework EQ abap_true OR lines( lt_clint_first ) GT 0.
    " The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
    " it is bets pratice to issue a log message with date and time information at the start and end of each logical data conversion phase.
    MESSAGE i035(upgba) WITH 'Starting to update DATUB in table KSML. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( iv_flush = abap_true ).

    " To split the worklist into equaly sized packages, we are re-using the segmentation function of the parallelization framework used by XLCAs
    TRY.
      lr_table_splitter = cl_shdb_pfw_factory=>new_table_splitter( iv_appl_name = mv_appl_name ).
      ls_tabsplit-tabname = 'KSML'.
      ls_tabsplit-category = if_shdb_pfw_package_provider=>mc_cat-default.
      ls_tabsplit-pkg_size = lc_package_size.
      ls_tabsplit-range_fields_incl = VALUE ltty_tabsplit_cols( ( 'CLINT' ) ).
      DATA(lt_sel_mandt) = VALUE lrty_mandt( ( sign = 'I' option = 'EQ' low = mv_client high = mv_client ) ).
      IF mv_rework EQ abap_true.
        ls_tabsplit-filter = VALUE ltty_named_seltab(
          ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
        ).
      ELSE.
        DATA(lt_sel_clint) = VALUE lrty_clint( ( sign = 'I' option = 'GE' low = lt_clint_first[ 1 ] high = lt_clint_first[ 1 ] ) ).
        ls_tabsplit-filter = VALUE ltty_named_seltab(
          ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
          ( name = 'CLINT' dref = REF #( lt_sel_clint ) )
        ).
      ENDIF.

      lt_tabsplit_packsel = lr_table_splitter->get_packsel( is_tables = ls_tabsplit ).
      me->process_package( lt_tabsplit_packsel ).

      MESSAGE i035(upgba) WITH 'Update finished for DATUB in KSML. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).

      CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
        cl_upgba_logger=>log->error( ix_root = lx_shdb_pfw_exception  iv_incl_srcpos = abap_true ).
      CATCH cx_shdb_pfw_appl_error INTO DATA(lx_shdb_pfw_appl_error) ##no_handler.
        " cannot be thrown as parallelization framework is not used for processing
    ENDTRY.
  ENDIF.

ENDMETHOD.