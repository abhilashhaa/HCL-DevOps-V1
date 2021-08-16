METHOD convert_client.

  TYPES:
    ltty_updtabs      TYPE STANDARD TABLE OF tabname WITH DEFAULT KEY,
    ltty_cols         TYPE if_shdb_pfw_package_provider=>tt_cols,
    lrty_mandt        TYPE RANGE OF mandt,
    lrty_objek        TYPE RANGE OF cuobn,
    ltty_named_seltab TYPE cl_shdb_pfw_seltab=>tt_named_seltab.

  CONSTANTS:
    lc_package_size   TYPE i VALUE 200000.

  DATA:
    lv_success        TYPE boole_d,
    lt_objek_first    TYPE TABLE OF cuobn.

  IF mv_rework EQ abap_false.
    " Determine the first DATUB=00000000 to avoid reprocessing the previously processed rows
    SELECT objek FROM kssk CLIENT SPECIFIED
      INTO TABLE @lt_objek_first
      UP TO 1 ROWS
      WHERE mandt = @mv_client AND datub = '00000000'
      ORDER BY objek.
  ENDIF.

  IF mv_rework EQ abap_true OR lines( lt_objek_first ) GT 0.
    TRY.
*     The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
*     it is bets pratice to issue a log message with date and time information at the start and end of each logical data conversion phase.
      MESSAGE i035(upgba) WITH 'Starting to update DATUB in KSSK. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).

      DATA(gr_msg) = NEW cl_shdb_pfw_logging( ir_logger = cl_upgba_logger=>log ).
      DATA(gr_pfw) = cl_shdb_pfw_factory=>register( iv_appl_name = mv_appl_name
                                                    ir_logwriter = gr_msg ).
      "create the package provider configuration
      DATA(gr_tab_conf) = NEW cl_shdb_pfw_config( ).
      "specify updated tables
      gr_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-upd_tables
                        iv_val = VALUE ltty_updtabs( ( 'KSSK' ) ) ).
      "expicit package size
      gr_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-pkg_size
                        iv_val = lc_package_size ).
      "explicit range determination field (optional)
      gr_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-range_fields_incl
                        iv_val = VALUE ltty_cols( ( 'OBJEK' ) ) ).
      "specify the filter condition
      DATA(lt_sel_mandt) = VALUE lrty_mandt( ( sign = 'I' option = 'EQ' low = mv_client high = mv_client ) ).
      IF mv_rework EQ abap_true.
        gr_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-filter
                          iv_val = VALUE ltty_named_seltab(
                            ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
                          )
                        ).
      ELSE.
        DATA(lt_sel_objek) = VALUE lrty_objek( ( sign = 'I' option = 'GE' low = lt_objek_first[ 1 ] high = lt_objek_first[ 1 ] ) ).
        gr_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-filter
                          iv_val = VALUE ltty_named_seltab(
                            ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
                            ( name = 'OBJEK' dref = REF #( lt_sel_objek ) )
                          )
                        ).
      ENDIF.
      "create the package provider
      DATA(gr_packprov) = cl_shdb_pfw_factory=>new_package_provider( ).
      gr_packprov->add_table( iv_tabname = 'KSSK'
                              ir_conf = gr_tab_conf ).

      "bind the package provider to the specific worker implementations
      "PROCESS_PACKAGE
      DATA(lr_param_process) = NEW cl_shdb_pfw_params( ).
      lr_param_process->put( iv_name     = 'IT_PACKSEL'
                             iv_kind     = cl_shdb_pfw_params=>mc_kind-package
                             ir_packager = gr_packprov ).
      gr_pfw->add_phase( iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-parallel
                         ir_instance = me
                         iv_method   = 'PROCESS_PACKAGE'
                         ir_params   = lr_param_process ).
      "AFTER PACKAGE
      DATA(lr_param_after) = NEW cl_shdb_pfw_params( ).
      gr_pfw->add_phase( iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-after_package
                         ir_instance = me
                         iv_method   = 'AFTER_PACKAGE'
                         ir_params   = lr_param_after ).

      "finally start the parallel processing
      gr_pfw->run( ).
      gr_pfw->status( ).
      gr_pfw->cleanup( ).

      MESSAGE i035(upgba) WITH 'Update finished for DATUB in KSSK. Client:' mv_client 'Time:' cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).

      lv_success = abap_true.

    CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
      cl_upgba_logger=>log->error( ix_root = lx_shdb_pfw_exception  iv_incl_srcpos = abap_true ).
    ENDTRY.
  ELSE.
    lv_success = abap_true.
  ENDIF.

  " update also VCH_UPD_STATUS table
  me->update_vch_upd_status( lv_success ).

ENDMETHOD.