*"* use this source file for your ABAP unit test classes

CLASS lth_drf_access_cust_data DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_cls_key TYPE SORTED TABLE OF ngcs_drf_clsmas_object_key WITH UNIQUE KEY klart class,
      gt_klah    TYPE tt_klah,
      gt_swor    TYPE tt_swor,
      gt_ksml    TYPE tt_ksml,
      gt_cabn    TYPE tt_cabn,
      gt_cabnt   TYPE tt_cabnt,
      gt_cabnz   TYPE tt_cabnz,
      gt_cawn    TYPE tt_cawn,
      gt_cawnt   TYPE tt_cawnt,
      gt_tcme    TYPE tt_tcme.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_drf_access_cust_data IMPLEMENTATION.
  METHOD class_constructor.
    gt_cls_key = VALUE #( ( klart        = '001'
                            class        = 'TEST1' )
                          ( klart        = '001'
                            class        = 'TEST2' )
                          ( klart        = '300'
                            class        = 'TEST3' )
                          ( klart        = if_ngc_drf_c=>gc_ewm_classtype_version
                            class        = 'UNITTEST' ) ).
    APPEND INITIAL LINE TO gt_klah ASSIGNING FIELD-SYMBOL(<gs_klah>).
    <gs_klah>-klart      = if_ngc_drf_c=>gc_ewm_classtype_version.
    <gs_klah>-class      = 'UNITTEST'.
    <gs_klah>-clint      = 1.
    APPEND INITIAL LINE TO gt_swor ASSIGNING FIELD-SYMBOL(<gs_swor>).
    <gs_swor>-clint      = 1.
    <gs_swor>-spras      = 'EN'.
    <gs_swor>-kschg      = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_ksml ASSIGNING FIELD-SYMBOL(<gs_ksml>).
    <gs_ksml>-klart      = if_ngc_drf_c=>gc_ewm_classtype_version.
    <gs_ksml>-aennr      = 'UNITTEST'.
    <gs_ksml>-clint      = 1.
    <gs_ksml>-imerk      = 1.
    <gs_ksml>-omerk      = 2.
    APPEND INITIAL LINE TO gt_ksml ASSIGNING <gs_ksml>.
    <gs_ksml>-klart      = if_ngc_drf_c=>gc_ewm_classtype_version.
    <gs_ksml>-aennr      = 'UNITTEST'.
    <gs_ksml>-clint      = 3.
    <gs_ksml>-imerk      = 3.
    APPEND INITIAL LINE TO gt_cabn ASSIGNING FIELD-SYMBOL(<gs_cabn>).
    <gs_cabn>-atinn = 1.
    <gs_cabn>-atnam = 'UNITTEST'.
    <gs_cabn>-atfor = 'CHAR'.
    <gs_cabn>-anzst = 10.
    <gs_cabn>-attab = if_ngc_drf_c=>gc_product_header_dbtable.
    <gs_cabn>-atfel = 'MATNR'.
    APPEND INITIAL LINE TO gt_cabnt ASSIGNING FIELD-SYMBOL(<gs_cabnt>).
    <gs_cabnt>-atinn = 1.
    <gs_cabnt>-spras = 'EN'.
    <gs_cabnt>-atbez = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_cabnz ASSIGNING FIELD-SYMBOL(<gs_cabnz>).
    <gs_cabnz>-atinn = 1.
    <gs_cabnz>-attab = if_ngc_drf_c=>gc_batch_mat_level_dbtable.
    <gs_cabnz>-atfel = 'MATNR'.
    APPEND INITIAL LINE TO gt_cawn ASSIGNING FIELD-SYMBOL(<gs_cawn>).
    <gs_cawn>-atinn = 1.
    <gs_cawn>-atzhl = 1.
    <gs_cawn>-atwrt = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_cawnt ASSIGNING FIELD-SYMBOL(<gs_cawnt>).
    <gs_cawnt>-atinn = 1.
    <gs_cawnt>-atzhl = 1.
    <gs_cawnt>-spras = 'EN'.
    <gs_cawnt>-atwtb = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_tcme ASSIGNING FIELD-SYMBOL(<gs_tcme>).
    <gs_tcme>-atinn = 1.
    <gs_tcme>-klart = if_ngc_drf_c=>gc_batch_classtype_mat_level.
  ENDMETHOD.
ENDCLASS.


CLASS ltd_ngc_drf_ewm_util DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES:
      if_ngc_drf_ewm_util PARTIALLY IMPLEMENTED,
      if_ngc_drf_util PARTIALLY IMPLEMENTED.
    CLASS-DATA:
      gt_cabn        TYPE tt_cabn,
      gt_cabnt       TYPE tt_cabnt,
      gt_cabnz       TYPE tt_cabnz,
      gt_cawn        TYPE tt_cawn,
      gt_cawnt       TYPE tt_cawnt,
      gt_tcme        TYPE tt_tcme,
      gv_error_level TYPE i.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_util IMPLEMENTATION.
  METHOD if_ngc_drf_ewm_util~get_class_data.
    CLEAR: et_catchword_tab, et_charact_tab, et_class_header.
    CASE gv_error_level.
      WHEN 0.
        et_class_header = VALUE #( ( class = 'UNITTEST'
                                     klart = if_ngc_drf_c=>gc_ewm_classtype_version
                                     clint = 1 ) ).
        MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_ksml TO et_charact_tab.
        MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_swor TO et_catchword_tab.
      WHEN 1.
      WHEN OTHERS.
        et_class_header = VALUE #( ( class = 'UNITTEST'
                                     klart = if_ngc_drf_c=>gc_ewm_classtype_version ) ).
    ENDCASE.
  ENDMETHOD.
  METHOD if_ngc_drf_util~get_characteristic_data.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabn  TO et_charact_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabnt TO et_charact_descr_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabnz TO et_references_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cawn  TO et_value_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cawnt TO et_value_descr_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_tcme  TO et_restrictions_tab.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~change_classtype_tcme ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~apo_irrelevant_tcme ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~expand_tcme_for_cdp ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~change_classtype_class ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~apo_irrelevant_types_class ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~ale_own_logical_system_get.
    CLEAR ev_own_logical_system.
    ev_subrc = 0.
    IF  gv_error_level = 2.
      ev_subrc = 1.
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~rfc_trfc_set_qin_properties ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_map_clcg_export_mass.
    MOVE-CORRESPONDING it_table TO et_table.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_set_buf ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_reset_buf ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_/sapapo/cif_chr30_inb ##NEEDED.
    MOVE-CORRESPONDING ct_cabn TO gt_cabn.
    MOVE-CORRESPONDING ct_cabnt TO gt_cabnt.
    MOVE-CORRESPONDING ct_cabnz TO gt_cabnz.
    MOVE-CORRESPONDING ct_cawn TO gt_cawn.
    MOVE-CORRESPONDING ct_cawnt TO gt_cawnt.
    MOVE-CORRESPONDING ct_tcme TO gt_tcme.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_cif_functions DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES lif_cif_functions PARTIALLY IMPLEMENTED.
    CLASS-DATA:
      gt_klah TYPE tt_klah,
      gt_swor TYPE tt_swor,
      gt_ksml TYPE tt_ksml.
ENDCLASS.

CLASS ltd_cif_functions IMPLEMENTATION.
  METHOD lif_cif_functions~/sapapo/cif_cla30_inb ##NEEDED.
    CLEAR ev_subrc.
    MOVE-CORRESPONDING ct_klah TO gt_klah.
    MOVE-CORRESPONDING ct_swor TO gt_swor.
    MOVE-CORRESPONDING ct_ksml TO gt_ksml.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_cls_filter DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_drf_filter PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_cls_filter IMPLEMENTATION.
  METHOD if_drf_filter~apply_filter.
    et_filtered_objects = it_unfiltered_objects.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_drf_ewm_cls_out DEFINITION DEFERRED.
CLASS cl_ngc_drf_ewm_cls DEFINITION LOCAL FRIENDS ltc_drf_ewm_cls_out.

CLASS ltc_drf_ewm_cls_out DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_ewm_cls.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.

    METHODS: analyze_changes_by_chg_pointer FOR TESTING.
    METHODS: analyze_changes_by_mdg_cp FOR TESTING.
    METHODS: analyze_changes_by_others FOR TESTING.
    METHODS: apply_node_inst_filter_multi FOR TESTING.
    METHODS: apply_node_inst_filter_single FOR TESTING.
    METHODS: build_parallel_package FOR TESTING.
    METHODS: enrich_filter_criteria FOR TESTING.
    METHODS: finalize FOR TESTING.
    METHODS: initialize FOR TESTING.
    METHODS: map_data2message FOR TESTING.
    METHODS: read_complete_data FOR TESTING.
    METHODS: send_message FOR TESTING.
    METHODS: send_message_eh FOR TESTING.
ENDCLASS.       "ltc_drf_ewm_cls_out


CLASS ltc_drf_ewm_cls_out IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    f_cut = NEW cl_ngc_drf_ewm_cls( VALUE #( dlmod = if_drf_const=>mode_directly ) ).
    CREATE OBJECT f_cut->mo_ewm_util TYPE ltd_ngc_drf_ewm_util.
    f_cut->mo_ngc_drf_util ?= f_cut->mo_ewm_util.
    CREATE OBJECT f_cut->mo_cif_functions TYPE ltd_cif_functions.
    CREATE OBJECT f_cut->mo_filter TYPE ltd_cls_filter.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


METHOD analyze_changes_by_chg_pointer.

    DATA:
      lt_change_pointer  TYPE drf_t_bdcp,
      es_stat_info       TYPE drf_s_stat_info,
      ct_changed_objects TYPE ngct_drf_clsmas_object_key.

    f_cut->if_drf_outbound~analyze_changes_by_chg_pointer(
      EXPORTING
        it_change_pointer  = lt_change_pointer
      IMPORTING
        es_stat_info       = es_stat_info
      CHANGING
        ct_changed_objects = ct_changed_objects
    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_stat_info
      msg = 'analyze_changes_by_chg_pointer: ES_STAT_INFO is not valid'
    ).

  ENDMETHOD.

  METHOD analyze_changes_by_mdg_cp.

    DATA:
      lt_change_pointer  TYPE mdg_cp_t_cp,
      es_stat_info       TYPE drf_s_stat_info,
      ct_changed_objects TYPE ngct_drf_clsmas_object_key.

    f_cut->if_drf_outbound~analyze_changes_by_mdg_cp(
      EXPORTING
        it_change_pointer  = lt_change_pointer
      IMPORTING
        es_stat_info       = es_stat_info
      CHANGING
        ct_changed_objects = ct_changed_objects
    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_stat_info
      msg = 'analyze_changes_by_mdg_cp: ES_STAT_INFO is not valid'
    ).

  ENDMETHOD.

  METHOD analyze_changes_by_others.

    DATA:
      es_stat_info       TYPE drf_s_stat_info,
      ct_changed_objects TYPE ngct_drf_clsmas_object_key.

    f_cut->if_drf_outbound~analyze_changes_by_others(
      IMPORTING
        es_stat_info       = es_stat_info
      CHANGING
        ct_changed_objects = ct_changed_objects
    ).

*    cl_abap_unit_assert=>assert_equals(
*      act = ct_changed_objects
*      exp = lth_drf_access_cust_data=>gt_clf_key
*      msg = 'analyze_changes_by_others: CT_CHANGED_OBJECTS is not valid'
*    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_stat_info
      msg = 'analyze_changes_by_others: ES_STAT_INFO is not valid'
    ).

  ENDMETHOD.

  METHOD apply_node_inst_filter_multi.

    DATA:
      it_external_criteria TYPE rsds_trange,
      it_fobj              TYPE drf_t_fobj_impl,
      ct_relevant_objects  TYPE SORTED TABLE OF kssk WITH UNIQUE DEFAULT KEY.

    f_cut->if_drf_outbound~apply_node_inst_filter_multi(
      EXPORTING
        it_external_criteria  = it_external_criteria
        it_fobj               = it_fobj
      CHANGING
        ct_relevant_objects   = ct_relevant_objects
    ).

    cl_abap_unit_assert=>assert_initial(
      act = ct_relevant_objects
      msg = 'apply_node_inst_filter_multi: CT_RELEVANT_OBJECTS is not valid'
    ).

  ENDMETHOD.

  METHOD apply_node_inst_filter_single.

    DATA:
      it_external_criteria TYPE rsds_trange,
      it_fobj              TYPE drf_t_fobj_impl,
      cr_relevant_object   TYPE REF TO data,
      ev_skip_object       TYPE abap_bool.

    f_cut->if_drf_outbound~apply_node_inst_filter_single(
      EXPORTING
        it_external_criteria  = it_external_criteria
        it_fobj               = it_fobj
      IMPORTING
        ev_skip_object        = ev_skip_object
      CHANGING
        cr_relevant_object    = cr_relevant_object
    ).

    cl_abap_unit_assert=>assert_initial(
      act = ev_skip_object
      msg = 'apply_node_inst_filter_single: EV_SKIP_OBJECT is not valid'
    ).

  ENDMETHOD.

  METHOD build_parallel_package.

    DATA:
      ir_prepare_data   TYPE REF TO data ##NEEDED,
      er_package_data   TYPE REF TO data,
      es_task_param     TYPE drf_s_parallel_task_param,
      ev_all_tasks_done TYPE abap_bool.

    f_cut->if_drf_outbound~build_parallel_package(
      EXPORTING
        ir_prepare_data     = ir_prepare_data
      IMPORTING
        er_package_data     = er_package_data
        es_task_param       = es_task_param
        ev_all_tasks_done   = ev_all_tasks_done
    ).

    cl_abap_unit_assert=>assert_initial(
      act = er_package_data
      msg = 'build_parallel_package: ER_PACKAGE_DATA is not valid'
    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_task_param
      msg = 'build_parallel_package: ES_TASK_PARAM is not valid'
    ).

    cl_abap_unit_assert=>assert_initial(
      act = ev_all_tasks_done
      msg = 'build_parallel_package: EV_ALL_TASKS_DONE is not valid'
    ).

  ENDMETHOD.

  METHOD enrich_filter_criteria.

    DATA:
      it_external_criteria     TYPE rsds_trange,
      et_add_external_criteria TYPE rsds_trange,
      es_stat_info             TYPE drf_s_stat_info.

    f_cut->if_drf_outbound~enrich_filter_criteria(
      EXPORTING
        it_external_criteria     = it_external_criteria
      IMPORTING
        et_add_external_criteria = et_add_external_criteria
        es_stat_info             = es_stat_info
    ).

    cl_abap_unit_assert=>assert_initial(
      act = et_add_external_criteria
      msg = 'enrich_filter_criteria: ET_ADD_EXTERNAL_CRITERIA is not valid'
    ).

    cl_abap_unit_assert=>assert_initial(
      act = es_stat_info
      msg = 'enrich_filter_criteria: ES_STAT_INFO is not valid'
    ).

  ENDMETHOD.


  METHOD finalize.

    DATA:
      ev_delete_change_pointer TYPE boole_d.

    f_cut->if_drf_outbound~finalize(
      EXPORTING
        it_relevant_objects     = VALUE ngct_drf_clsmas_object_key( )
        it_erroneous_objects    = VALUE ngct_drf_clsmas_object_key( )
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

    cl_ngc_drf_ewm_cls=>if_drf_outbound~initialize(
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
      act = cl_ngc_drf_ewm_cls=>go_drf_ewm_cls->ms_runtime_param-appl
      exp = 'TESTAPPL'
      msg = 'initialize: CL_CACL_COM_CLSMAS_DRF=>GO_DRF_ewm_cls->MS_RUNTIME_PARAM-APPL is not valid'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = es_runtime_param_out_impl-table_type_name
      exp = cl_ngc_drf_ewm_cls=>gc_cls_key
      msg = 'initialize: table type name not returned in ES_RUNTIME_PARAM_OUT_IMPL'
    ).

  ENDMETHOD.

  METHOD map_data2message.

    DATA:
      ir_relevant_object TYPE REF TO data ##NEEDED.

    f_cut->if_drf_outbound~map_data2message(
      EXPORTING
        ir_relevant_object = ir_relevant_object
    ).

    cl_abap_unit_assert=>assert_initial(
      act = ir_relevant_object
      msg = 'map_data2message: IR_RELEVANT_OBJECT is not valid'
    ).

  ENDMETHOD.


  METHOD read_complete_data.

    DATA:
      lt_relevant_objects TYPE SORTED TABLE OF ngcs_drf_clsmas_object_key WITH UNIQUE KEY klart class,
      lv_prev_runmod      LIKE if_drf_const=>runmod_bypass_filter.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_cls_key.

    lv_prev_runmod = f_cut->ms_runtime_param-runmod.
    f_cut->ms_runtime_param-runmod = if_drf_const=>runmod_bypass_filter.
    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).
    f_cut->ms_runtime_param-runmod = lv_prev_runmod.

    cl_abap_unit_assert=>assert_equals(
      act = lt_relevant_objects
      exp = lth_drf_access_cust_data=>gt_cls_key
      msg = 'read_complete_data: CT_RELEVANT_OBJECTS is changed'
    ).

  ENDMETHOD.


  METHOD send_message.

    DATA:
      is_file_info        TYPE drf_s_file_info,
      is_bus_sys_tech     TYPE mdg_s_bus_sys_tech,
      et_file_data        TYPE drf_t_file_oi_content,
      ct_obj_rep_sta      TYPE drf_t_obj_rep_sta_full,
      lt_relevant_objects TYPE SORTED TABLE OF ngcs_drf_clsmas_object_key WITH UNIQUE KEY klart class,
      lt_ksml_exp         TYPE tt_ksml.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_cls_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    ct_obj_rep_sta = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).

    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info    = is_file_info
        iv_object_count = 4
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

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cabn
      exp = lth_drf_access_cust_data=>gt_cabn
      msg = 'send_message: wrong cabn entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cabnt
      exp = lth_drf_access_cust_data=>gt_cabnt
      msg = 'send_message: wrong cabnt entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cabnz
      exp = lth_drf_access_cust_data=>gt_cabnz
      msg = 'send_message: wrong cabnz entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cawn
      exp = lth_drf_access_cust_data=>gt_cawn
      msg = 'send_message: wrong cawn entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cawnt
      exp = lth_drf_access_cust_data=>gt_cawnt
      msg = 'send_message: wrong cawnt entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_tcme
      exp = lth_drf_access_cust_data=>gt_tcme
      msg = 'send_message: wrong tcme entries'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_cif_functions=>gt_klah
      exp = lth_drf_access_cust_data=>gt_klah
      msg = 'send_message: wrong klah entries'
    ).

    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_ksml TO lt_ksml_exp.
    lt_ksml_exp[ 1 ]-omerk = 0.
    cl_abap_unit_assert=>assert_equals(
      act = ltd_cif_functions=>gt_ksml
      exp = lt_ksml_exp
      msg = 'send_message: wrong ksml entries'
    ).
*    cl_abap_unit_assert=>assert_table_contains(
*      line  = lth_drf_access_cust_data=>gt_ksml[ 1 ]
*      table = ltd_cif_functions=>gt_ksml
*      msg   = 'send_message: wrong ksml entries'
*    ).

    cl_abap_unit_assert=>assert_equals(
      act = ltd_cif_functions=>gt_swor
      exp = lth_drf_access_cust_data=>gt_swor
      msg = 'send_message: wrong swor entries'
    ).

  ENDMETHOD.

  METHOD send_message_eh.

    DATA:
      is_file_info        TYPE drf_s_file_info,
      is_bus_sys_tech     TYPE mdg_s_bus_sys_tech,
      et_file_data        TYPE drf_t_file_oi_content ##NEEDED,
      ct_obj_rep_sta      TYPE drf_t_obj_rep_sta_full,
      lt_relevant_objects TYPE SORTED TABLE OF ngcs_drf_clsmas_object_key WITH UNIQUE KEY klart class.

    CREATE OBJECT f_cut->ms_runtime_param-bal.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_cls_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    ct_obj_rep_sta = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).

    " Testing logging at the end
    f_cut->ms_runtime_param-dlmod = 'I'.
    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info    = is_file_info
        iv_object_count = 4
        is_bus_sys_tech = is_bus_sys_tech
      IMPORTING
        et_file_data    = et_file_data
*       et_message      =
      CHANGING
        ct_obj_rep_sta  = ct_obj_rep_sta
    ).
    f_cut->ms_runtime_param-dlmod = if_drf_const=>mode_directly.

    " Testing get_class_data, no class_header
    f_cut->mv_processed_relobj_num = 0.
    ltd_ngc_drf_ewm_util=>gv_error_level = 1.
    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info    = is_file_info
        iv_object_count = 4
        is_bus_sys_tech = is_bus_sys_tech
      IMPORTING
        et_file_data    = et_file_data
*       et_message      =
      CHANGING
        ct_obj_rep_sta  = ct_obj_rep_sta
    ).
    ltd_ngc_drf_ewm_util=>gv_error_level = 0.

    " Testing own_logical_system_get, ev_subrc=1
    f_cut->mv_processed_relobj_num = 0.
    ltd_ngc_drf_ewm_util=>gv_error_level = 2.
    f_cut->if_drf_outbound~send_message(
      EXPORTING
        is_file_info    = is_file_info
        iv_object_count = 4
        is_bus_sys_tech = is_bus_sys_tech
      IMPORTING
        et_file_data    = et_file_data
*       et_message      =
      CHANGING
        ct_obj_rep_sta  = ct_obj_rep_sta
    ).
    ltd_ngc_drf_ewm_util=>gv_error_level = 0.

    cl_abap_unit_assert=>assert_equals(
      act = abap_true
      exp = abap_true
    ).

  ENDMETHOD.

ENDCLASS.