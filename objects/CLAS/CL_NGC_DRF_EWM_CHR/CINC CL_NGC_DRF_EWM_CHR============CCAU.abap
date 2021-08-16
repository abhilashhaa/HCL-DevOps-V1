*"* use this source file for your ABAP unit test classes

CLASS lth_drf_access_cust_data DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    CLASS-DATA:
      gt_chr_key TYPE ngct_drf_chrmas_object_key,
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
    gt_chr_key = VALUE #( ( atnam        = 'TEST1' )
                          ( atnam        = 'TEST2' )
                          ( atnam        = 'TEST3' ) ).
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
    <gs_cawn>-atinn = 0.
    <gs_cawn>-atzhl = 1.
    <gs_cawn>-atwrt = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_cawnt ASSIGNING FIELD-SYMBOL(<gs_cawnt>).
    <gs_cawnt>-atinn = 0.
    <gs_cawnt>-atzhl = 1.
    <gs_cawnt>-spras = 'EN'.
    <gs_cawnt>-atwtb = 'UNITTEST'.
    APPEND INITIAL LINE TO gt_tcme ASSIGNING FIELD-SYMBOL(<gs_tcme>).
    <gs_tcme>-atinn = 1.
    <gs_tcme>-klart = if_ngc_drf_c=>gc_batch_classtype_mat_level.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_db_access DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES lif_db_access PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_db_access IMPLEMENTATION.
  METHOD lif_db_access~get_chr_data.
    CLEAR: et_cabn, et_cabnt, et_cabnz, et_cawn, et_cawnt, et_tcme.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_util DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES:
      if_ngc_drf_ewm_util PARTIALLY IMPLEMENTED,
      if_ngc_drf_util PARTIALLY IMPLEMENTED.
    CLASS-DATA:
      gv_error_level TYPE i.
    CLASS-DATA:
      gt_cabn  TYPE tt_cabn,
      gt_cabnt TYPE tt_cabnt,
      gt_cabnz TYPE tt_cabnz,
      gt_cawn  TYPE tt_cawn,
      gt_cawnt TYPE tt_cawnt,
      gt_tcme  TYPE tt_tcme.
    CLASS-METHODS: class_constructor.
    CLASS-METHODS: init.
ENDCLASS.

CLASS ltd_ngc_drf_ewm_util IMPLEMENTATION.
  METHOD class_constructor.
    gv_error_level = 0.
  ENDMETHOD.
  METHOD if_ngc_drf_util~get_characteristic_data.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabn TO et_charact_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabnt TO et_charact_descr_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cabnz TO et_references_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cawn TO et_value_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_cawnt TO et_value_descr_tab.
    MOVE-CORRESPONDING lth_drf_access_cust_data=>gt_tcme TO et_restrictions_tab.
    IF gv_error_level = 1.
      et_charact_tab[ 1 ]-anzst = 40.
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~expand_tcme_for_cdp ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~change_classtype_tcme ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~apo_irrelevant_tcme ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_map_clcg_export_mass.
    CLEAR: et_table.
    LOOP AT it_table ASSIGNING FIELD-SYMBOL(<is_table>).
      APPEND INITIAL LINE TO et_table ASSIGNING FIELD-SYMBOL(<es_table>).
      MOVE-CORRESPONDING <is_table> TO <es_table>.
      ASSIGN COMPONENT is_cuobn_fieldnames-field OF STRUCTURE <is_table> TO FIELD-SYMBOL(<iv_field>).
      IF sy-subrc IS INITIAL.
        ASSIGN COMPONENT is_cuobn_fieldnames-longfield OF STRUCTURE <es_table> TO FIELD-SYMBOL(<ev_field>).
        IF sy-subrc IS INITIAL.
          <ev_field> = <iv_field>.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_set_buf ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~cif_mfle_reset_buf ##NEEDED.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~ale_own_logical_system_get.
    CLEAR ev_own_logical_system.
    ev_subrc = 0.
    IF gv_error_level = 2.
      ev_subrc = 1.
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_drf_ewm_util~rfc_trfc_set_qin_properties.
    ev_subrc = 0.
    IF gv_error_level = 3.
      ev_subrc = 1.
    ENDIF.
  ENDMETHOD.
  METHOD init.
    CLEAR: gt_cabn, gt_cabnt, gt_cabnz, gt_cawn, gt_cawnt, gt_tcme.
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

CLASS ltd_chr_filter DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES if_drf_filter PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_chr_filter IMPLEMENTATION.
  METHOD if_drf_filter~apply_filter.
    et_filtered_objects = it_unfiltered_objects.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_drf_ewm_chr_out DEFINITION DEFERRED.
CLASS cl_ngc_drf_ewm_chr DEFINITION LOCAL FRIENDS ltc_drf_ewm_chr_out.

CLASS ltc_drf_ewm_chr_out DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_ewm_chr.  "class under test

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
ENDCLASS.       "ltc_drf_ewm_chr_out


CLASS ltc_drf_ewm_chr_out IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.
    f_cut = NEW cl_ngc_drf_ewm_chr( VALUE #( dlmod = if_drf_const=>mode_directly ) ).
    CREATE OBJECT f_cut->mo_db_access TYPE ltd_db_access.
    CREATE OBJECT f_cut->mo_ewm_util TYPE ltd_ngc_drf_ewm_util.
    f_cut->mo_ngc_drf_util ?= f_cut->mo_ewm_util.
    CREATE OBJECT f_cut->mo_filter TYPE ltd_chr_filter.
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD analyze_changes_by_chg_pointer.

    DATA:
      lt_change_pointer  TYPE drf_t_bdcp,
      es_stat_info       TYPE drf_s_stat_info,
      ct_changed_objects TYPE ngct_drf_chrmas_object_key.

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
      ct_changed_objects TYPE ngct_drf_chrmas_object_key.

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
      ct_changed_objects TYPE ngct_drf_chrmas_object_key.

    f_cut->if_drf_outbound~analyze_changes_by_others(
      IMPORTING
        es_stat_info       = es_stat_info
      CHANGING
        ct_changed_objects = ct_changed_objects ).

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
      ct_relevant_objects  TYPE SORTED TABLE OF cabn WITH UNIQUE DEFAULT KEY.

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
        it_relevant_objects     = VALUE ngct_drf_chrmas_object_key( )
        it_erroneous_objects    = VALUE ngct_drf_chrmas_object_key( )
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

    cl_ngc_drf_ewm_chr=>if_drf_outbound~initialize(
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
      act = cl_ngc_drf_ewm_chr=>go_drf_ewm_chr->ms_runtime_param-appl
      exp = 'TESTAPPL'
      msg = 'initialize: CL_CACL_COM_CHRMAS_DRF=>GO_drf_ewm_chr->MS_RUNTIME_PARAM-APPL is not valid'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = es_runtime_param_out_impl-table_type_name
      exp = cl_ngc_drf_ewm_chr=>gc_chr_key
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
      lt_relevant_objects TYPE ngct_drf_chrmas_object_key,
      lv_prev_runmod      LIKE if_drf_const=>runmod_bypass_filter.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_chr_key.

    lv_prev_runmod = f_cut->ms_runtime_param-runmod.
    f_cut->ms_runtime_param-runmod = if_drf_const=>runmod_bypass_filter.
    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).
    f_cut->ms_runtime_param-runmod = lv_prev_runmod.

    cl_abap_unit_assert=>assert_equals(
      act = lt_relevant_objects
      exp = lth_drf_access_cust_data=>gt_chr_key
      msg = 'read_complete_data: CT_RELEVANT_OBJECTS is changed'
    ).

  ENDMETHOD.


  METHOD send_message.

    DATA:
      is_file_info        TYPE drf_s_file_info,
      is_bus_sys_tech     TYPE mdg_s_bus_sys_tech,
      et_file_data        TYPE drf_t_file_oi_content,
      ct_obj_rep_sta      TYPE drf_t_obj_rep_sta_full,
      lt_relevant_objects TYPE ngct_drf_chrmas_object_key.

    CREATE OBJECT f_cut->ms_runtime_param-bal.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_chr_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    ct_obj_rep_sta = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).

    ltd_ngc_drf_ewm_util=>init( ).
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

  ENDMETHOD.

  METHOD send_message_eh.

    DATA:
      is_file_info        TYPE drf_s_file_info,
      is_bus_sys_tech     TYPE mdg_s_bus_sys_tech,
      et_file_data        TYPE drf_t_file_oi_content ##NEEDED,
      ct_obj_rep_sta      TYPE drf_t_obj_rep_sta_full,
      lt_relevant_objects TYPE ngct_drf_chrmas_object_key.

    CREATE OBJECT f_cut->ms_runtime_param-bal.

    lt_relevant_objects = lth_drf_access_cust_data=>gt_chr_key.

    f_cut->if_drf_outbound~read_complete_data(
      CHANGING
        ct_relevant_objects = lt_relevant_objects ).

    ct_obj_rep_sta = VALUE #( ( business_system = 'TEST_BUS_SYS' ) ).

    ltd_ngc_drf_ewm_util=>init( ).
    ltd_ngc_drf_ewm_util=>gv_error_level = 1.
    f_cut->ms_runtime_param-dlmod = 'I'. " if_ngc_drf_c=>gc_repl_mode_initial.
    f_cut->mv_processed_relobj_num = 0.
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
*    f_cut->ms_runtime_param-dlmod = if_ngc_drf_c=>gc_repl_mode_direct.
    ltd_ngc_drf_ewm_util=>gv_error_level = 0.

    cl_abap_unit_assert=>assert_initial(
      act = ltd_ngc_drf_ewm_util=>gt_cabn
      msg = 'send_message: cabn is not initial'
    ).

    ltd_ngc_drf_ewm_util=>init( ).
    ltd_ngc_drf_ewm_util=>gv_error_level = 3.
    f_cut->mv_processed_relobj_num = 0.
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
    ltd_ngc_drf_ewm_util=>gv_error_level = 0.

    cl_abap_unit_assert=>assert_initial(
      act = ltd_ngc_drf_ewm_util=>gt_cabn
      msg = 'send_message: cabn is not initial'
    ).

    ltd_ngc_drf_ewm_util=>init( ).
    ltd_ngc_drf_ewm_util=>gv_error_level = 2.
    f_cut->mv_processed_relobj_num = 0.
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
    ltd_ngc_drf_ewm_util=>gv_error_level = 0.

    cl_abap_unit_assert=>assert_equals(
      act = ltd_ngc_drf_ewm_util=>gt_cabn
      exp = lth_drf_access_cust_data=>gt_cabn
      msg = 'send_message: wrong cabn entries'
    ).

  ENDMETHOD.

ENDCLASS.