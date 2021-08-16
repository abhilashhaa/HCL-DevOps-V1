*"* use this source file for your ABAP unit test classes

CLASS lth_drf_access_cust_data DEFINITION FINAL.
  PUBLIC SECTION.
    CLASS-DATA: gt_clf_key TYPE ngct_drf_clfmas_object_key.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_drf_access_cust_data IMPLEMENTATION.
  METHOD class_constructor.
    gt_clf_key = VALUE #( ( object_table = 'MARA'
                            klart        = '001'
                            objkey       = 'TEST1' )
                          ( object_table = 'MARA'
                            klart        = '001'
                            objkey       = 'TEST2' )
                          ( object_table = 'MARA'
                            klart        = '300'
                            objkey       = 'TEST3' ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_drf_access_cust_data DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_drf_access_cust_data.
ENDCLASS.

CLASS ltd_drf_access_cust_data IMPLEMENTATION.
  METHOD lif_drf_access_cust_data~select_business_sys_for_appl.
    CLEAR: et_bus_sys, et_bus_sys_appl, et_bus_sys_tech.
    et_bus_sys_tech = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_drf_ale_info DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_drf_ale_info.
ENDCLASS.

CLASS ltd_drf_ale_info IMPLEMENTATION.
  METHOD lif_drf_ale_info~determine_message_type.
    CLEAR: es_message, et_mestyp, ev_mestyp.
    ev_mestyp = 'DUMMY'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_idoc_functions DEFINITION.
  PUBLIC SECTION.
    INTERFACES lif_idoc_functions.
ENDCLASS.

CLASS ltd_idoc_functions IMPLEMENTATION.
  METHOD lif_idoc_functions~masteridoc_create_clfmas.
    CLEAR: created_comm_idocs.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_drf_utility DEFINITION FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_drf_util PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_drf_utility IMPLEMENTATION.
  METHOD if_ngc_drf_util~get_selected_classifications.
    et_clf_key = lth_drf_access_cust_data=>gt_clf_key.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clfmas_drf DEFINITION DEFERRED.
CLASS cl_ngc_drf_clfmas DEFINITION LOCAL FRIENDS ltc_ngc_clfmas_drf.

CLASS ltc_ngc_clfmas_drf DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_clfmas.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.

    METHODS: analyze_changes_by_others FOR TESTING.
    METHODS: finalize FOR TESTING.
    METHODS: initialize FOR TESTING.
    METHODS: read_complete_data FOR TESTING.
    METHODS: send_message FOR TESTING.
ENDCLASS.       "ltc_ngc_clfmas_drf


CLASS ltc_ngc_clfmas_drf IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    CREATE OBJECT f_cut.
    CREATE OBJECT f_cut->mo_ngc_drf_util TYPE ltd_ngc_drf_utility.
    CREATE OBJECT f_cut->mo_drf_access_cust_data TYPE ltd_drf_access_cust_data.
    CREATE OBJECT f_cut->mo_idoc_functions TYPE ltd_idoc_functions.
    CREATE OBJECT f_cut->mo_drf_ale_info TYPE ltd_drf_ale_info.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD analyze_changes_by_others.

    DATA:
      es_stat_info       TYPE drf_s_stat_info,
      ct_changed_objects TYPE ngct_drf_clfmas_object_key.

    f_cut->if_drf_outbound~analyze_changes_by_others(
      IMPORTING
        es_stat_info       = es_stat_info
      CHANGING
        ct_changed_objects = ct_changed_objects ).

    cl_abap_unit_assert=>assert_equals(
      act = ct_changed_objects
      exp = lth_drf_access_cust_data=>gt_clf_key
      msg = 'analyze_changes_by_others: CT_CHANGED_OBJECTS is not valid'
    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_stat_info
      msg = 'analyze_changes_by_others: ES_STAT_INFO is not valid'
    ).

  ENDMETHOD.


  METHOD finalize.

    DATA:
      ev_delete_change_pointer TYPE boole_d.

    f_cut->if_drf_outbound~finalize(
      EXPORTING
        it_relevant_objects     = VALUE ngct_drf_clfmas_object_key( )
        it_erroneous_objects    = VALUE ngct_drf_clfmas_object_key( )
        iv_repeated_initial_run = abap_false
     IMPORTING
       ev_delete_change_pointer = ev_delete_change_pointer
    ).

    cl_abap_unit_assert=>assert_initial(
      act = ev_delete_change_pointer
      msg = 'finalize: EV_DELETE_CHANGE_POINTER is not valid'
    ).

  ENDMETHOD.


  METHOD initialize.

    DATA:
      eo_if_drf_outbound        TYPE REF TO if_drf_outbound,
      es_runtime_param_out_impl TYPE drf_s_runtime_param_out_impl.

    cl_ngc_drf_clfmas=>if_drf_outbound~initialize(
      EXPORTING
        is_runtime_param          = VALUE drf_s_runtime_parameter_ext( appl = 'TESTAPPL' )
      IMPORTING
        eo_if_drf_outbound        = eo_if_drf_outbound
        es_runtime_param_out_impl = es_runtime_param_out_impl
    ).

    cl_abap_unit_assert=>assert_bound(
      act = eo_if_drf_outbound
      msg = 'initialize: EO_IF_DRF_OUTBOUND not bound'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = cl_ngc_drf_clfmas=>go_drf_clfmas->ms_runtime_param-appl
      exp = 'TESTAPPL'
      msg = 'initialize: CL_CACL_COM_CLFMAS_DRF=>GO_DRF_CLFMAS->MS_RUNTIME_PARAM-APPL is not valid'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = es_runtime_param_out_impl-table_type_name
      exp = if_ngc_drf_c=>gc_clfmas_drf_table_type
      msg = 'initialize: table type name not returned in ES_RUNTIME_PARAM_OUT_IMPL'
    ).

  ENDMETHOD.


  METHOD read_complete_data.

    DATA:
      lt_relevant_objects TYPE ngct_drf_clfmas_object_key.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_clf_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_relevant_objects
      exp = lth_drf_access_cust_data=>gt_clf_key
      msg = 'read_complete_data: CT_RELEVANT_OBJECTS is changed'
    ).

  ENDMETHOD.


  METHOD send_message.

    DATA:
      is_file_info        TYPE drf_s_file_info,
      is_bus_sys_tech     TYPE mdg_s_bus_sys_tech,
      et_file_data        TYPE drf_t_file_oi_content,
      ct_obj_rep_sta      TYPE drf_t_obj_rep_sta_full,
      lt_relevant_objects TYPE ngct_drf_clfmas_object_key.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_clf_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    ct_obj_rep_sta = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).

    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info    = is_file_info
        iv_object_count = 2
        is_bus_sys_tech = is_bus_sys_tech
      IMPORTING
        et_file_data    = et_file_data
*       et_message      =
      CHANGING
        ct_obj_rep_sta  = ct_obj_rep_sta
    ).

    cl_abap_unit_assert=>assert_initial(
      act = et_file_data
      msg = 'send_message: ET_FILE_DATA is not initial'
    ).

  ENDMETHOD.

ENDCLASS.