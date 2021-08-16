METHOD convert.

  TYPES:
    lrty_mandt         TYPE RANGE OF mandt,
    ltty_named_seltab  TYPE cl_shdb_pfw_seltab=>tt_named_seltab,
    ltty_tabsplit_cols TYPE if_shdb_pfw_package_provider=>tt_cols.

  " package size is set to this value so that using range for deletion of INOB entries will not dump
  CONSTANTS:
    lc_package_size     TYPE i VALUE 1000.

  DATA:
    ls_tabsplit         TYPE cl_shdb_pfw_pack_base=>ts_tables,
    lr_table_splitter   TYPE REF TO if_shdb_pfw_table_splitter,
    lt_tabsplit_packsel TYPE if_shdb_pfw_package_provider=>tt_packsel.

  " The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
  " it is best pratice to issue a log message with date and time information at the start and end of each logical data conversion phase.
  MESSAGE i035(upgba) WITH 'Starting to cleanup table INOB. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT .
  cl_upgba_logger=>log->trace_single( iv_flush = abap_true ).

  " To split the worklist into equaly sized packages, we are re-using the segmentation function of the parallelization framework
  TRY.
      lr_table_splitter = cl_shdb_pfw_factory=>new_table_splitter( iv_appl_name = mv_appl_name ).
      ls_tabsplit-tabname = mv_inconinob_name.
      ls_tabsplit-category = if_shdb_pfw_package_provider=>mc_cat-default.
      ls_tabsplit-pkg_size = lc_package_size.
      ls_tabsplit-range_fields_incl = VALUE ltty_tabsplit_cols( ( 'CUOBJ' ) ).
      DATA(lt_sel_mandt) = VALUE lrty_mandt( ( sign = 'I' option = 'EQ' low = mv_client high = mv_client ) ).
      ls_tabsplit-filter = VALUE ltty_named_seltab(
        ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
      ).

      TEST-SEAM get_packsel_seam.
        lt_tabsplit_packsel = lr_table_splitter->get_packsel( is_tables = ls_tabsplit ).
      END-TEST-SEAM.
      me->process_package( lt_tabsplit_packsel ).

      MESSAGE i035(upgba) WITH 'Cleanup of table INOB finished. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT .
      cl_upgba_logger=>log->trace_single( ).

    CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
      cl_upgba_logger=>log->error( ix_root = lx_shdb_pfw_exception iv_incl_srcpos = abap_true ).
    CATCH cx_shdb_pfw_appl_error ##no_handler.
      " cannot be thrown as parallelization framework is not used for processing
  ENDTRY.

ENDMETHOD.