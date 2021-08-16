METHOD convert_core.

  TYPES:
    ltty_updtabs      TYPE STANDARD TABLE OF tabname WITH DEFAULT KEY,
    ltty_cols         TYPE if_shdb_pfw_package_provider=>tt_cols,
    ltty_named_seltab TYPE cl_shdb_pfw_seltab=>tt_named_seltab,
    lrty_mandt        TYPE RANGE OF mandt.

  CONSTANTS:
    lc_max_pll_degree TYPE i VALUE 16.

  DATA:
    lt_event_count    TYPE ltt_event_count,
    lv_data_exists    TYPE boole_d,
    lt_obtab_filter   TYPE REF TO ltr_obtab.

  " Let's check if we have relevant data at all.
  lt_obtab_filter = io_refval_reader->get_obtab_filter( ).
  lv_data_exists = abap_false.
  SELECT SINGLE @abap_true INTO @lv_data_exists FROM (mv_refbo_name) WHERE obtab IN @lt_obtab_filter->*. "#EC CI_DYNTAB
  IF lv_data_exists = abap_false.
    " Ok, do not initialize the Parallel FrameWork for nothing.
    RETURN.
  ENDIF.

  mo_refval_reader = io_refval_reader.

  DATA(lo_pfw) = cl_shdb_pfw_factory=>register( iv_appl_name = mv_appl_name && '_' && sy-mandt && '_' && mo_refval_reader->get_reader_id( )
                                                ir_logwriter = io_logger ).

  " Create the package provider configuration.
  DATA(lo_tab_conf) = NEW cl_shdb_pfw_config( ).
  " Specify updated tables
  lo_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-upd_tables
                    iv_val = VALUE ltty_updtabs( ( 'AUSP' ) ) ).
  " Explicit package size.
  lo_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-pkg_size
                    iv_val = iv_package_size ).
  " abap_max_wp
  lo_tab_conf->set( iv_key = if_shdb_pfw_resource_provider=>mc_conf-abap_max_wp
                    iv_val = lc_max_pll_degree ).
  " Explicit range determination field (optional).
  lo_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-range_fields_incl
                    iv_val = VALUE ltty_cols( ( 'OBJEK' ) ) ).
  " Specify the filter condition.
  " This is a client specific migration report, so we work only in the current client.
  " We have to define the mandt as a condition, because without this filter the pfw would make packages of ALL mandants.
  DATA(lt_sel_mandt) = VALUE lrty_mandt( ( sign = 'I' option = 'EQ'  low = sy-mandt ) ).
  lo_tab_conf->set( iv_key = if_shdb_pfw_package_provider=>mc_conf-filter
                    iv_val = VALUE ltty_named_seltab(
                      ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
                      ( name = 'OBTAB' dref = lt_obtab_filter )
                    )
                  ).
  " Create the package provider.
  DATA(lo_packprov) = cl_shdb_pfw_factory=>new_package_provider( ).
  lo_packprov->add_table( iv_tabname = mv_refbo_name
                          ir_conf = lo_tab_conf ).

  " Bind the package provider to the specific worker implementations.
  " PROCESS_PACKAGE
  DATA(lr_param_process) = NEW cl_shdb_pfw_params( ).
  lr_param_process->put( iv_name     = 'IT_PACKSEL'
                         iv_kind     = cl_shdb_pfw_params=>mc_kind-package
                         ir_packager = lo_packprov ).
  lr_param_process->put( iv_name = 'RT_EVENTS'
                         iv_kind = cl_shdb_pfw_params=>mc_kind-returning
                         ir_ref  = REF #( lt_event_count ) ).
  lo_pfw->add_phase( iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-parallel
                     ir_instance = me
                     iv_method   = 'PROCESS_PACKAGE'
                     ir_params   = lr_param_process ).
  " AFTER PACKAGE
  DATA(lr_param_after) = NEW cl_shdb_pfw_params( ).
  " Pipe the content of result parameter RT_EVENTS into the IT_EVENTS parameter:
  lr_param_after->pipe( iv_from_phase = if_shdb_pfw_def=>mc_pfw_phase-parallel
                        iv_from_param = 'RT_EVENTS'
                        iv_into_param = 'IT_EVENTS' ).
  lo_pfw->add_phase( iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-after_package
                     ir_instance = me
                     iv_method   = 'AFTER_PACKAGE'
                     ir_params   = lr_param_after ).

  " Finally start the parallel processing.
  lo_pfw->run( ).
  lo_pfw->status( ).
  lo_pfw->cleanup( ).

ENDMETHOD.