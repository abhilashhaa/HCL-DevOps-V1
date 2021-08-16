  METHOD convert.

    TYPES:
      ltty_updtabs      TYPE STANDARD TABLE OF tabname WITH DEFAULT KEY,
      ltty_cols         TYPE if_shdb_pfw_package_provider=>tt_cols,
      ltty_named_seltab TYPE cl_shdb_pfw_seltab=>tt_named_seltab,
      lrty_mandt        TYPE RANGE OF mandt.

    CONSTANTS:
      lc_max_pll_degree TYPE i VALUE 16.

    DATA:
      lt_event_count TYPE ltt_event_count,
      lv_valid_flag  TYPE c LENGTH 1.

    IF mv_lock = abap_true AND mv_testmode = abap_false.
      DATA(lv_lock_error) = me->lock_tables( ).

      IF lv_lock_error = abap_true.
        RETURN.
      ENDIF.
    ENDIF.

    mo_conv_util->get_print_parameters(
      EXPORTING
        iv_line_size      = gc_line_size
        iv_no_dialog      = abap_true
      IMPORTING
        es_out_parameters = ms_print_parameters
        ev_valid          = lv_valid_flag
        ev_sy_subrc       = DATA(lv_sy_subrc)
    ).

    " The upgrade logger does not enrich log messages with timestamps. To allow at least high-level runtime analysis at customer side,
    " it is best practice to issue a log message with date and time information at the start and end of each logical data conversion phase.
    IF lv_valid_flag = 'X' AND lv_sy_subrc = 0.
      IF mv_testmode = abap_true.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'I'
          iv_number = '035'
          iv_param1 = 'Starting to enumerate Reference Characteristic'
          iv_param2 = ' values for Nodes in AUSP. Client:'
          iv_param3 = CONV #( sy-mandt )
          iv_param4 = `Time: ` && cl_ngc_core_data_conv=>get_current_time( )
        ) ##NO_TEXT.
      ELSE.
        mo_conv_logger->log_message(
          iv_id     = 'UPGBA'
          iv_type   = 'I'
          iv_number = '035'
          iv_param1 = 'Starting to delete Reference Characteristic values'
          iv_param2 = ' for Nodes in AUSP. Client:'
          iv_param3 = CONV #( sy-mandt )
          iv_param4 = `Time: ` && cl_ngc_core_data_conv=>get_current_time( )
        ) ##NO_TEXT.
      ENDIF.
    ELSE.
      mo_conv_logger->log_message(
        iv_id     = 'UPGBA'
        iv_type   = 'I'
        iv_number = '034'
        iv_param1 = `GET_PRINT_PARAMETERS error!`
        iv_param2 = ` lv_valid_flag = '` && lv_valid_flag && `', sy-subrc = ` && sy-subrc
        iv_param3 = ` Time: ` && cl_ngc_core_data_conv=>get_current_time( )
      ) ##NO_TEXT.

      RETURN.
    ENDIF.

    TRY.
        mv_1_cond_p_line_limit  = 16000 ##NUMBER_OK. " me->determine_dyn_where_limit( ).
        mv_2_cond_p_line_limit  = mv_1_cond_p_line_limit / 2.
        mv_3_cond_p_line_limit  = mv_1_cond_p_line_limit / 3.

        DATA(lo_pfw) = cl_ngc_core_conv_pfw_fact=>get_pfw( mv_appl_name && '_' && sy-mandt ).

        " Create the package provider configuration.
        DATA(lo_tab_conf) = NEW cl_shdb_pfw_config( ).

        " Specify updated tables
        lo_tab_conf->set(
          iv_key = if_shdb_pfw_package_provider=>mc_conf-upd_tables
          iv_val = VALUE ltty_updtabs( ( 'AUSP' ) )
        ).

        " Explicit package size.
        lo_tab_conf->set(
          iv_key = if_shdb_pfw_package_provider=>mc_conf-pkg_size
          iv_val = mv_package_size
        ).

        " Maximum work package size.
        lo_tab_conf->set(
          iv_key = if_shdb_pfw_resource_provider=>mc_conf-abap_max_wp
          iv_val = lc_max_pll_degree
        ).

        " Explicit range determination field (optional).
        lo_tab_conf->set(
          iv_key = if_shdb_pfw_package_provider=>mc_conf-range_fields_incl
          iv_val = VALUE ltty_cols( ( 'OBJEK' ) )
        ).

        " Specify the filter condition.
        " This is a client specific migration report, so we work only in the current client.
        " We have to define the mandt as a condition, because without this filter the pfw would make packages of ALL mandants.
        DATA(lt_sel_mandt) = VALUE lrty_mandt( ( sign = 'I' option = 'EQ'  low = sy-mandt ) ).
        IF lines( mtr_objek ) = 0.
          lo_tab_conf->set(
            iv_key = if_shdb_pfw_package_provider=>mc_conf-filter
            iv_val = VALUE ltty_named_seltab(
              ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
            )
          ).
        ELSE.
          lo_tab_conf->set(
            iv_key = if_shdb_pfw_package_provider=>mc_conf-filter
            iv_val = VALUE ltty_named_seltab(
              ( name = 'MANDT' dref = REF #( lt_sel_mandt ) )
              ( name = 'OBJEK' dref = REF #( mtr_objek ) )
            )
          ).
        ENDIF.

        " Create the package provider.
        DATA(lo_packprov) = cl_ngc_core_conv_pfw_fact=>get_new_package_provider( ).
        lo_packprov->add_table(
          iv_tabname = gv_refchars_name
          ir_conf    = lo_tab_conf
        ).

        " Bind the package provider to the specific worker implementations.
        " PROCESS_PACKAGE
        DATA(lr_param_process) = NEW cl_shdb_pfw_params( ).
        lr_param_process->put(
          iv_name     = 'IT_PACKSEL'
          iv_kind     = cl_shdb_pfw_params=>mc_kind-package
          ir_packager = lo_packprov
        ).
        lr_param_process->put(
          iv_name = 'RT_EVENTS'
          iv_kind = cl_shdb_pfw_params=>mc_kind-returning
          ir_ref  = REF #( lt_event_count )
        ).
        lo_pfw->add_phase(
          iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-parallel
          ir_instance = me
          iv_method   = 'PROCESS_PACKAGE'
          ir_params   = lr_param_process
        ).

        " AFTER PACKAGE
        DATA(lr_param_after) = NEW cl_shdb_pfw_params( ).

        " Pipe the content of result parameter RT_EVENTS into the IT_EVENTS parameter.
        lr_param_after->pipe(
          iv_from_phase = if_shdb_pfw_def=>mc_pfw_phase-parallel
          iv_from_param = 'RT_EVENTS'
          iv_into_param = 'IT_EVENTS'
        ).
        lo_pfw->add_phase(
          iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-after_package
          ir_instance = me
          iv_method   = 'AFTER_PACKAGE'
          ir_params   = lr_param_after
        ).

        " Finally start the parallel processing.
        lo_pfw->run( ).
        lo_pfw->status( ).
        lo_pfw->cleanup( ).

        " Let's see what events do we have as a summary.
        SORT mt_event_count BY event param.
        LOOP AT mt_event_count REFERENCE INTO DATA(lr_event_count).
          CASE lr_event_count->event.
            WHEN gc_ev_obj_chk_nexist.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'W'
                iv_number   = '000'
                iv_severity = 'P'
                iv_param1   = lr_event_count->param
              ) ##NO_TEXT.

            WHEN gc_ev_bo_nexist.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'W'
                iv_number   = '001'
                iv_severity = 'P'
                iv_param1   = CONV #( lr_event_count->count )
              ) ##NO_TEXT.

            WHEN gc_ev_bo_flock.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'W'
                iv_number   = '002'
                iv_severity = 'P'
                iv_param1   = CONV #( lr_event_count->count )
              ) ##NO_TEXT.

            WHEN gc_ev_bo_sysfail.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'E'
                iv_number   = '003'
                iv_param1   = CONV #( lr_event_count->count )
              ) ##NO_TEXT.

            WHEN gc_ev_bo_errmsg.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'W'
                iv_number   = '004'
                iv_severity = 'P'
                iv_param1   = CONV #( lr_event_count->count )
              ) ##NO_TEXT.

            WHEN gc_ev_type_conv_fail.
              mo_conv_logger->log_message(
                iv_id       = 'NGC_CORE_DB'
                iv_type     = 'W'
                iv_number   = '005'
                iv_severity = 'P'
                iv_param1   = CONV #( lr_event_count->count )
              ) ##NO_TEXT.

            WHEN gc_ev_num_del_entries.
              IF mv_testmode = abap_true.
                mo_conv_logger->log_message(
                  iv_id       = 'NGC_CORE_DB'
                  iv_type     = 'W'
                  iv_number   = '012'
                  iv_param1   = 'AUSP'
                  iv_param2   = CONV #( lr_event_count->count )
                ) ##NO_TEXT.
              ELSE.
                mo_conv_logger->log_message(
                  iv_id       = 'NGC_CORE_DB'
                  iv_type     = 'W'
                  iv_number   = '010'
                  iv_param1   = 'AUSP'
                  iv_param2   = CONV #( lr_event_count->count )
                ) ##NO_TEXT.
              ENDIF.

          ENDCASE.
        ENDLOOP.

        IF mv_testmode = abap_true.
          mo_conv_logger->log_message(
            iv_id       = 'UPGBA'
            iv_type     = 'I'
            iv_number   = '035'
            iv_param1   = 'Enumerating Reference Characteristic values'
            iv_param2   = ' for Nodes in AUSP finished. Client:'
            iv_param3   = CONV #( sy-mandt )
            iv_param4   = `Time: ` && cl_ngc_core_data_conv=>get_current_time( )
          ) ##NO_TEXT.
        ELSE.
          mo_conv_logger->log_message(
            iv_id       = 'UPGBA'
            iv_type     = 'I'
            iv_number   = '035'
            iv_param1   = 'Deleting Reference Characteristic values'
            iv_param2   = ' for Nodes in AUSP finished. Client:'
            iv_param3   = CONV #( sy-mandt )
            iv_param4   = `Time: ` && cl_ngc_core_data_conv=>get_current_time( )
          ) ##NO_TEXT.
        ENDIF.

      CATCH cx_shdb_pfw_exception INTO DATA(lx_shdb_pfw_exception).
        mo_conv_logger->log_error( lx_shdb_pfw_exception ).
    ENDTRY.

    IF mv_lock = abap_true AND mv_testmode = abap_false.
      me->unlock_tables( ).
    ENDIF.

  ENDMETHOD.