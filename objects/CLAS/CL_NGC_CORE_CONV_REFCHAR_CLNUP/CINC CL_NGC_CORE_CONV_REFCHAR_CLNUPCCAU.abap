CLASS ltc_ngc_core_conv_refchar_clnu DEFINITION DEFERRED.
CLASS cl_ngc_core_conv_refchar_clnup DEFINITION LOCAL FRIENDS ltc_ngc_core_conv_refchar_clnu.

CLASS ltc_ngc_core_conv_refchar_clnu DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PUBLIC SECTION.

  PRIVATE SECTION.

    CLASS-DATA:
      go_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS:
      class_setup.

    DATA:
      mo_cut              TYPE REF TO cl_ngc_core_conv_refchar_clnup,
      mo_pfw              TYPE REF TO if_ngc_core_conv_pfw,
      mo_package_provider TYPE REF TO if_shdb_pfw_package_provider.

    METHODS:
      setup.

    METHODS:
      before_conversion_nodata       FOR TESTING RAISING cx_dd_ddl_delete cx_cfd_transport_adapter,
      before_conversion_del_error    FOR TESTING RAISING cx_dd_ddl_activate cx_dd_ddl_save cx_cfd_transport_adapter cx_dd_ddl_delete,
      before_conversion_noauth       FOR TESTING,
      before_conversion_create_error        FOR TESTING RAISING cx_dd_ddl_activate cx_dd_ddl_save cx_cfd_transport_adapter cx_dd_ddl_delete,
      before_conversion_success      FOR TESTING,
      after_conversion               FOR TESTING RAISING cx_dd_ddl_delete cx_cfd_transport_adapter,
      after_conversion_error         FOR TESTING RAISING cx_dd_ddl_delete cx_cfd_transport_adapter,
      convert                        FOR TESTING RAISING cx_shdb_pfw_exception,
      convert_run_fail               FOR TESTING RAISING cx_shdb_pfw_exception,
      process_package                FOR TESTING,
      after_package                  FOR TESTING RAISING cx_shdb_pfw_appl_error,
      read_ref_values_error_message  FOR TESTING,
      read_ref_values_obj_not_found  FOR TESTING,
      read_ref_values_foreign_lock   FOR TESTING,
      read_ref_values_system_failure FOR TESTING,
      read_ref_values_cls_exception  FOR TESTING.

    METHODS:
      set_user_authorized
        IMPORTING
          iv_authorized TYPE abap_bool.
ENDCLASS.

CLASS ltc_ngc_core_conv_refchar_clnu IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_osql_test_environment=>create( VALUE #( ( 'AUSP' ) ) ).

  ENDMETHOD.

  METHOD setup.

    DATA:
      lo_conv_util   TYPE REF TO if_ngc_core_conv_util,
      lo_conv_logger TYPE REF TO if_ngc_core_conv_logger.

    go_environment->clear_doubles( ).

    mo_cut = NEW #(
      iv_appl_name = 'UT'
      iv_language  = sy-langu
      iv_lock      = abap_false
      iv_testmode  = abap_false
    ).

    lo_conv_util ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_util' ).
    lo_conv_logger ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_logger' ).
    mo_pfw ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_pfw' ).
    mo_package_provider ?= cl_abap_testdouble=>create( 'if_shdb_pfw_package_provider' ).

    mo_cut->mo_conv_util = lo_conv_util.
    mo_cut->mo_conv_logger = lo_conv_logger.

    th_ngc_core_conv_pfw_fact_inj=>inject_pfw(
      io_instance         = mo_pfw
      iv_application_name = 'UT_' && sy-mandt ).

    th_ngc_core_conv_pfw_fact_inj=>inject_package_provider( mo_package_provider ).

  ENDMETHOD.

  METHOD before_conversion_nodata.

    " Given: There is no data to convert.
    TEST-INJECTION exists_1_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    TEST-INJECTION exists_2_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    " And: The user is authorized.
    me->set_user_authorized( abap_true ).

    " And: I expect delete_view to be called for my created CDS views.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_refchars_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_nodes_name ).

    " And: I don't expect log error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_logger->log_error( NEW cx_cfd_transport_adapter( ) ).

    " When: I execute before_conversion.
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Then: It should return abap_true to exit.
    cl_abap_unit_assert=>assert_true( lv_exit ).

    " And: delete_view should have been called with the expected parameters.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_util ).

    " And: log_error was not called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD before_conversion_del_error.

    DATA(lx_error) = NEW cx_cfd_transport_adapter( ).

    " Given: There is no data to convert.
    TEST-INJECTION exists_1_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    TEST-INJECTION exists_2_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    " And: The user is authorized.
    me->set_user_authorized( abap_true ).

    " And: delete_view fails for both of the CDS views.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->raise_exception( lx_error ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_refchars_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->raise_exception( lx_error ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_nodes_name ).

    " And: I expect log error to be called twice.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_called_times( 2 ).
    mo_cut->mo_conv_logger->log_error( lx_error ).

    " When: I execute before_conversion.
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Then: It should return abap_true to exit.
    cl_abap_unit_assert=>assert_true( lv_exit ).

    " And: log_error was called twice.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD before_conversion_noauth.

    " Given: The user has no authorization.
    me->set_user_authorized( abap_false ).

    " And: I don't expect log error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_logger->log_error( NEW cx_cfd_transport_adapter( ) ).

    " When: I execute before_conversion.
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Then: It should return abap_true to exit.
    cl_abap_unit_assert=>assert_true( lv_exit ).

    " And: log_error was not called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD before_conversion_create_error.

    DATA(lx_error) = NEW cx_cfd_transport_adapter( ).

    " Given: There is no data to convert.
    TEST-INJECTION exists_1_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    TEST-INJECTION exists_2_seam.
      lv_exists = abap_false.
    END-TEST-INJECTION.

    " And: The user is authorized.
    me->set_user_authorized( abap_true ).

    " And: There is an error during the dynamic CDS View creation.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->ignore_all_parameters( )->raise_exception( lx_error ).
    mo_cut->mo_conv_util->create_view(
      iv_view_name   = ''
      iv_view_source = ''
      iv_app_name    = ''
    ).

    " And: I expect delete_view to be called for my created CDS views.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_refchars_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_nodes_name ).

    " And: I expect log error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_logger->log_error( lx_error ).

    " When: I execute before_conversion.
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Then: It should return abap_true to exit.
    cl_abap_unit_assert=>assert_true( lv_exit ).

    " And: delete_view should have been called with the expected parameters.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_util ).

    " And: log_error was called once.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD before_conversion_success.

    " Given: There is data to convert.
    TEST-INJECTION exists_1_seam.
      lv_exists = abap_true.
    END-TEST-INJECTION.

    TEST-INJECTION exists_2_seam.
      lv_exists = abap_true.
    END-TEST-INJECTION.

    " And: The user is authorized.
    me->set_user_authorized( abap_true ).

    " And: I don't expect log error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_logger->log_error( NEW cx_cfd_transport_adapter( ) ).

    " When: I execute before_conversion.
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Then: It should return abap_false to exit.
    cl_abap_unit_assert=>assert_false( lv_exit ).

    " And: log_error was not called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD after_conversion.

    " Given: I expect delete_view to be called for my created CDS views.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_refchars_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_nodes_name ).

    " And: I don't expect log error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_logger->log_error( NEW cx_cfd_transport_adapter( ) ).

    " When: I execute after_conversion.
    mo_cut->after_conversion( ).

    " Then: delete_view should have been called with the expected parameters.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_util ).

    " And: log_error was not called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD after_conversion_error.

    DATA(lx_error) = NEW cx_cfd_transport_adapter( ).

    " Given: delete_view raises exception for both views.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->raise_exception( lx_error ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_refchars_name ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->raise_exception( lx_error ).
    mo_cut->mo_conv_util->delete_view( cl_ngc_core_conv_refchar_clnup=>gv_nodes_name ).

    " And: I expect log_error to be called 2 times.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_called_times( 2 ).
    mo_cut->mo_conv_logger->log_error( lx_error ).

    " When: I execute after_conversion.
    mo_cut->after_conversion( ).

    " Then: log_error was called 2 times.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD convert.

    " Given: Print parameters are valid.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->set_parameter(
      name  = 'ev_valid'
      value = abap_true ).
    mo_cut->mo_conv_util->get_print_parameters(
      iv_line_size = cl_ngc_core_conv_refchar_clnup=>gc_line_size
      iv_no_dialog = abap_true ).

    " And: I expect pfw run to be called.
    cl_abap_testdouble=>configure_call( mo_pfw )->and_expect( )->is_called_once( ).
    mo_pfw->run( ).

    " And: I expect pfw status to be called.
    cl_abap_testdouble=>configure_call( mo_pfw )->and_expect( )->is_called_once( ).
    mo_pfw->status( ).

    " And: I expect pfw cleanup to be called.
    cl_abap_testdouble=>configure_call( mo_pfw )->and_expect( )->is_called_once( ).
    mo_pfw->cleanup( ).

    " And: add_phase is called for pfw the expected way.
    cl_abap_testdouble=>configure_call( mo_pfw )->ignore_parameter( 'ir_params' )->and_expect( )->is_called_once( ).
    mo_pfw->add_phase(
      iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-parallel
      ir_instance = mo_cut
      iv_method   = 'PROCESS_PACKAGE' ).

    cl_abap_testdouble=>configure_call( mo_pfw )->ignore_parameter( 'ir_params' )->and_expect( )->is_called_once( ).
    mo_pfw->add_phase(
      iv_phase    = if_shdb_pfw_def=>mc_pfw_phase-after_package
      ir_instance = mo_cut
      iv_method   = 'AFTER_PACKAGE' ).

    " And: add_table is called for the package provider.
    cl_abap_testdouble=>configure_call( mo_package_provider )->ignore_all_parameters( )->and_expect( )->is_called_once( ).
    mo_package_provider->add_table( '' ).

    " And: I don't expect log_error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_logger->log_error( NEW cx_shdb_pfw_exception( ) ).

    " When: I try to run the convert.
    mo_cut->convert( ).

    " Then: Expected pfw calls were made.
    cl_abap_testdouble=>verify_expectations( mo_pfw ).

    " And: Expected package provider calls were made.
    cl_abap_testdouble=>verify_expectations( mo_package_provider ).

    " And: Expected log methods were called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD convert_run_fail.

    DATA(lx_error) = NEW cx_shdb_pfw_exception( ).

    " Given: Print parameters are valid.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->set_parameter(
      name  = 'ev_valid'
      value = abap_true ).
    mo_cut->mo_conv_util->get_print_parameters(
      iv_line_size = cl_ngc_core_conv_refchar_clnup=>gc_line_size
      iv_no_dialog = abap_true ).

    " And: I pfw run raises exception.
    cl_abap_testdouble=>configure_call( mo_pfw )->raise_exception( lx_error ).
    mo_pfw->run( ).

    " And: add_table is called for the package provider.
    cl_abap_testdouble=>configure_call( mo_package_provider )->ignore_all_parameters( )->and_expect( )->is_called_once( ).
    mo_package_provider->add_table( '' ).

    " And: I expect log_error to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_logger->log_error( lx_error ).

    " When: I try to run the convert.
    mo_cut->convert( ).

    " Then: Expected log methods were called.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

    " And: Expected package provider calls were made.
    cl_abap_testdouble=>verify_expectations( mo_package_provider ).

  ENDMETHOD.

  METHOD process_package.

    DATA:
      lt_ausp_td  TYPE TABLE OF ausp,
      lt_ausp_act TYPE TABLE OF ausp,
      ls_mara     TYPE mara,
      ls_table    TYPE cltable.

    FIELD-SYMBOLS:
      <x1> TYPE x,
      <x2> TYPE x.

    " Given: There are 3 ref.char relevant nodes.
    TEST-INJECTION select_cds_seam.
      lt_refchar_node = VALUE #(
        ( obtab = 'MARA' objek = 'OBJ1' auspobjek = '000000000000000001' atinn = 123 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_1' )
        ( obtab = 'MARA' objek = 'OBJ3' auspobjek = '000000000000000003' atinn = 125 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_3' )
        ( obtab = 'MARA' objek = 'OBJ4' auspobjek = '000000000000000004' atinn = 126 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_4' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION obj_chk_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.

    " And: Reference data exists.
    ls_mara-matnr = 'UT_MATNR_1'.
    ls_table-tname = 'MARA'.

    ASSIGN ls_mara TO <x1> CASTING.
    ASSIGN ls_table-table TO <x2> CASTING.
    <x2> = <x1>.

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->returning(
      VALUE if_ngc_core_conv_util=>tt_object_area(
        ( ls_table ) ) ).
    mo_cut->mo_conv_util->has_object_area( ).

    " And: Data is there in the database.
    lt_ausp_td = VALUE #(
      ( mandt = sy-mandt objek = '000000000000000001' atinn = 123 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_1' )
      ( mandt = sy-mandt objek = '000000000000000003' atinn = 125 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_3' )
      ( mandt = sy-mandt objek = '000000000000000004' atinn = 126 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_4' )
    ).
    go_environment->insert_test_data( lt_ausp_td ).

    " And: The condition limit is only 1.
    mo_cut->mv_1_cond_p_line_limit = 1 ##NUMBER_OK.
    mo_cut->mv_2_cond_p_line_limit = 1 ##NUMBER_OK.
    mo_cut->mv_3_cond_p_line_limit = 1 ##NUMBER_OK.

    " And: I expect db commit to be called twice.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_times( 2 ).
    mo_cut->mo_conv_util->db_commit( ).

    " And: I expect db rollback to be never called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_util->db_rollback( ).

    " When: I try to convert the packages by running the process_package.
    mo_cut->process_package( VALUE #( ( packno = 1 ) ( packno = 2 ) ) ).

    " Then: All 3 lines deleted from AUSP.
    SELECT * FROM ausp INTO TABLE @lt_ausp_act.
    cl_abap_unit_assert=>assert_initial( lt_ausp_act ).

    " And: Util expectations are valid.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_util ).

  ENDMETHOD.

  METHOD after_package.

    " Given: There is already an event recorded.
    mo_cut->mt_event_count = VALUE #(
      ( event = 0 param = '' count = 1 ) ).

    DATA(lt_event_count_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = 0 param = '' count = 2 )
      ( event = 1 param = '' count = 1 ) ).

    " And I expect trace_process_messages to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_logger )->ignore_all_parameters( )->and_expect( )->is_called_once( ).
    mo_cut->mo_conv_logger->trace_process_messages( 0 ).

    " When: I run after_package.
    mo_cut->after_package(
      VALUE #(
        ( event = 0 param = '' count = 1 )
        ( event = 1 param = '' count = 1 ) )
    ).

    " Then: The events should be summarized.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_event_count_exp
      act = mo_cut->mt_event_count
    ).

    " And: Expected logger calls were made.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_logger ).

  ENDMETHOD.

  METHOD read_ref_values_error_message.

    DATA:
      lt_events_act TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count.

    " Given: There is an error_message generated in the OBJECT_CHECK_* FM.
    TEST-INJECTION obj_chk_seam.
      sy-subrc = 1.
    END-TEST-INJECTION.

    DATA(lt_events_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_errmsg param = '' count = 1 )
    ).

    " When: I run read_ref_values.
    mo_cut->read_ref_values(
      EXPORTING
        iv_obtab   = 'MARA'
        iv_objek   = 'OBJ1'
        iv_datuv   = '00000000'
      CHANGING
        ct_events  = lt_events_act
    ).

    " Then: The corresponding event is returned.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_events_exp
      act = lt_events_act
    ).

  ENDMETHOD.

  METHOD read_ref_values_obj_not_found.

    DATA:
      lt_events_act TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count.

    " Given: The object is not found in the OBJECT_CHECK_* FM.
    TEST-INJECTION obj_chk_seam.
      sy-subrc = 2.
    END-TEST-INJECTION.

    DATA(lt_events_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_nexist param = '' count = 1 )
    ).

    " When: I try to run read_ref_values.
    mo_cut->read_ref_values(
      EXPORTING
        iv_obtab   = 'MARA'
        iv_objek   = 'OBJ1'
        iv_datuv   = '00000000'
      CHANGING
        ct_events  = lt_events_act
    ).

    " Then: The corresponding event is returned.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_events_exp
      act = lt_events_act
    ).

  ENDMETHOD.

  METHOD read_ref_values_foreign_lock.

    DATA:
      lt_events_act TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count.

    " Given: There is a foreign lock for the object in the OBJECT_CHECK_* FM.
    TEST-INJECTION obj_chk_seam.
      sy-subrc = 3.
    END-TEST-INJECTION.

    DATA(lt_events_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_flock  param = ''  count = 1 )
    ).

    " When: I try to run read_ref_values.
    mo_cut->read_ref_values(
      EXPORTING
        iv_obtab   = 'MARA'
        iv_objek   = 'OBJ1'
        iv_datuv   = '00000000'
      CHANGING
        ct_events  = lt_events_act
    ).

    " Then: The corresponding event is returned.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_events_exp
      act = lt_events_act
    ).

  ENDMETHOD.

  METHOD read_ref_values_system_failure.

    DATA:
      lt_events_act TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count.

    " Given: There is a system failure for the object in the OBJECT_CHECK_* FM.
    TEST-INJECTION obj_chk_seam.
      sy-subrc = 4.
    END-TEST-INJECTION.

    DATA(lt_events_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail  param = ''  count = 1 )
    ).

    " When: I try to run read_ref_values.
    mo_cut->read_ref_values(
      EXPORTING
        iv_obtab   = 'MARA'
        iv_objek   = 'OBJ1'
        iv_datuv   = '00000000'
      CHANGING
        ct_events  = lt_events_act
    ).

    " Then: The corresponding event is returned.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_events_exp
      act = lt_events_act
    ).

  ENDMETHOD.

  METHOD read_ref_values_cls_exception.

    DATA:
      lt_events_act TYPE cl_ngc_core_conv_refchar_clnup=>ltt_event_count.

    " Given: There is an exception generated for the object in the OBJECT_CHECK_* FM.
    TEST-INJECTION obj_chk_seam.
      DATA(lv_value) = 1 / 0. " Intentional to generate an exception.
    END-TEST-INJECTION.

    DATA(lt_events_exp) = VALUE cl_ngc_core_conv_refchar_clnup=>ltt_event_count(
      ( event = cl_ngc_core_conv_refchar_clnup=>gc_ev_bo_sysfail  param = ''  count = 1 )
    ).

    " When: I try to run read_ref_values.
    mo_cut->read_ref_values(
      EXPORTING
        iv_obtab   = 'MARA'
        iv_objek   = 'OBJ1'
        iv_datuv   = '00000000'
      CHANGING
        ct_events  = lt_events_act
    ).

    " Then: The corresponding event is returned.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_events_exp
      act = lt_events_act
    ).

  ENDMETHOD.

  METHOD set_user_authorized.

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->returning( iv_authorized ).
    mo_cut->mo_conv_util->is_authorized( ).

  ENDMETHOD.

ENDCLASS.


CLASS ltc_ngc_core_conv_refchar_tst DEFINITION DEFERRED.
CLASS cl_ngc_core_conv_refchar_clnup DEFINITION LOCAL FRIENDS ltc_ngc_core_conv_refchar_tst.

CLASS ltc_ngc_core_conv_refchar_tst DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PUBLIC SECTION.

  PRIVATE SECTION.

    CLASS-DATA:
      go_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS:
      class_setup.

    DATA:
      mo_cut              TYPE REF TO cl_ngc_core_conv_refchar_clnup,
      mo_pfw              TYPE REF TO if_ngc_core_conv_pfw,
      mo_package_provider TYPE REF TO if_shdb_pfw_package_provider.

    METHODS:
      setup.

    METHODS:
      process_package FOR TESTING.

ENDCLASS.

CLASS ltc_ngc_core_conv_refchar_tst IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_osql_test_environment=>create( VALUE #( ( 'AUSP' ) ) ).

  ENDMETHOD.

  METHOD setup.

    DATA:
      lo_conv_util   TYPE REF TO if_ngc_core_conv_util,
      lo_conv_logger TYPE REF TO if_ngc_core_conv_logger.

    go_environment->clear_doubles( ).

    mo_cut = NEW #(
      iv_appl_name = 'UT'
      iv_language  = sy-langu
      iv_lock      = abap_false
      iv_testmode  = abap_true
    ).

    lo_conv_util ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_util' ).
    lo_conv_logger ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_logger' ).
    mo_pfw ?= cl_abap_testdouble=>create( 'if_ngc_core_conv_pfw' ).
    mo_package_provider ?= cl_abap_testdouble=>create( 'if_shdb_pfw_package_provider' ).

    mo_cut->mo_conv_util = lo_conv_util.
    mo_cut->mo_conv_logger = lo_conv_logger.

    th_ngc_core_conv_pfw_fact_inj=>inject_pfw(
      io_instance         = mo_pfw
      iv_application_name = 'UT_' && sy-mandt ).

    th_ngc_core_conv_pfw_fact_inj=>inject_package_provider( mo_package_provider ).

  ENDMETHOD.

  METHOD process_package.

    DATA:
      lt_ausp_td  TYPE TABLE OF ausp,
      lt_ausp_act TYPE TABLE OF ausp,
      ls_mara     TYPE mara,
      ls_table    TYPE cltable.

    FIELD-SYMBOLS:
      <x1> TYPE x,
      <x2> TYPE x.

    " Given: There are 3 ref.char relevant nodes.
    TEST-INJECTION select_cds_seam.
      lt_refchar_node = VALUE #(
        ( obtab = 'MARA' objek = 'OBJ1' auspobjek = '000000000000000001' atinn = 123 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_1' )
        ( obtab = 'MARA' objek = 'OBJ3' auspobjek = '000000000000000003' atinn = 125 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_3' )
        ( obtab = 'MARA' objek = 'OBJ4' auspobjek = '000000000000000004' atinn = 126 klart = '023' attab = 'MARA' atfel = 'MATNR' datuv = '00000000' atnam = 'UT_CHAR_4' ) ).
    END-TEST-INJECTION.

    TEST-INJECTION obj_chk_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.

    " And: Reference data exists.
    ls_mara-matnr = 'UT_MATNR_1'.
    ls_table-tname = 'MARA'.

    ASSIGN ls_mara TO <x1> CASTING.
    ASSIGN ls_table-table TO <x2> CASTING.
    <x2> = <x1>.

    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->returning(
      VALUE if_ngc_core_conv_util=>tt_object_area(
        ( ls_table ) ) ).
    mo_cut->mo_conv_util->has_object_area( ).

    " And: Data is there in the database.
    lt_ausp_td = VALUE #(
      ( mandt = sy-mandt objek = '000000000000000001' atinn = 123 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_1' )
      ( mandt = sy-mandt objek = '000000000000000003' atinn = 125 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_3' )
      ( mandt = sy-mandt objek = '000000000000000004' atinn = 126 atzhl = 0 mafid = 'O' klart = '023' adzhl = 0 atwrt = 'UT_VALUE_4' )
    ).
    go_environment->insert_test_data( lt_ausp_td ).

    " And: The condition limit is only 1.
    mo_cut->mv_1_cond_p_line_limit = 1 ##NUMBER_OK.
    mo_cut->mv_2_cond_p_line_limit = 1 ##NUMBER_OK.
    mo_cut->mv_3_cond_p_line_limit = 1 ##NUMBER_OK.

    " And: I don't expect db commit to be called.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_never_called( ).
    mo_cut->mo_conv_util->db_commit( ).

    " And: I expect db rollback to be called twice.
    cl_abap_testdouble=>configure_call( mo_cut->mo_conv_util )->and_expect( )->is_called_times( 2 ).
    mo_cut->mo_conv_util->db_rollback( ).

    " When: I try to convert the packages by running the process_package.
    mo_cut->process_package( VALUE #( ( packno = 1 ) ( packno = 2 ) ) ).

    " Then: All 3 lines deleted from AUSP.
    SELECT * FROM ausp INTO TABLE @lt_ausp_act.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_ausp_act )
      exp = lines( lt_ausp_td ) ).

    " And: Util expectations are valid.
    cl_abap_testdouble=>verify_expectations( mo_cut->mo_conv_util ).

  ENDMETHOD.
ENDCLASS.