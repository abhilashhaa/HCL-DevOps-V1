CLASS ltc_ngc_core_sdm_clf_hdr DEFINITION DEFERRED.
CLASS cl_ngc_core_sdm_clf_hdr DEFINITION LOCAL FRIENDS ltc_ngc_core_sdm_clf_hdr.

CLASS ltc_ngc_core_sdm_clf_hdr DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.
  PUBLIC SECTION.

  PRIVATE SECTION.
    CLASS-DATA:
      go_osql_env TYPE REF TO if_osql_test_environment.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.

    DATA:
     mo_cut TYPE REF TO cl_ngc_core_sdm_clf_hdr.

    METHODS: setup.
    METHODS: get_package_size FOR TESTING.
    METHODS: get_prerequisites FOR TESTING.
    METHODS: get_selective_field FOR TESTING.
    METHODS: get_status_field FOR TESTING.
    METHODS: get_status_value_done FOR TESTING.
    METHODS: get_table_name FOR TESTING.
    METHODS: migrate_data FOR TESTING.
    METHODS: migrate_data_testmode FOR TESTING.
    METHODS: migrate_data_finished FOR TESTING.
    METHODS: migrate_data_prepare_data.
    METHODS: must_run FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_core_sdm_clf_hdr IMPLEMENTATION.
  METHOD class_setup.

    go_osql_env = cl_osql_test_environment=>create(
      VALUE #( ( 'CLF_HDR' )  ( 'P_CLFNSDMCLFHDR' ) )
    ).

    cl_ngc_core_data_conv=>init_logger( 'UT' ).

  ENDMETHOD.

  METHOD class_teardown.

    go_osql_env->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_osql_env->clear_doubles( ).

    mo_cut = NEW #( ).

  ENDMETHOD.

  METHOD get_package_size.

    DATA:
      lv_size TYPE i.

    " When: I ask for the package size.
    lv_size = mo_cut->if_sdm_migration~get_package_size( ).

    " Then: It should return 100000.
    cl_abap_unit_assert=>assert_equals(
      exp = mo_cut->mc_package_size
      act = lv_size
    ).

  ENDMETHOD.

  METHOD get_prerequisites.

    DATA:
      lt_prerequisites TYPE sdm_prerequisites_tab.

    " When: I ask for the prerequisites.
    lt_prerequisites = mo_cut->if_sdm_migration~get_prerequisites( ).

    " Then: It should return an empty table.
    cl_abap_unit_assert=>assert_initial(
      act = lt_prerequisites
    ).

  ENDMETHOD.

  METHOD get_selective_field.

    DATA:
      lv_field TYPE fieldname.

    " When: I ask for the selective field.
    lv_field = mo_cut->if_sdm_migration~get_selective_field( ).

    " Then: It should return 'OBJEK'
    cl_abap_unit_assert=>assert_equals(
      exp = mo_cut->mc_selective_field
      act = lv_field
    ).

  ENDMETHOD.

  METHOD get_status_field.

    DATA:
      lv_status_field TYPE fieldname.

    " When: I ask for status field.
    lv_status_field = mo_cut->if_sdm_migration~get_status_field( ).

    " Then: It should return 'SDM_STATUS'.
    cl_abap_unit_assert=>assert_equals(
      exp = mo_cut->mc_status_field
      act = lv_status_field
    ).

  ENDMETHOD.

  METHOD get_status_value_done.

    DATA:
      lv_status_value_done TYPE sdm_status_value_done.

    " When: I ask for status=done value.
    lv_status_value_done = mo_cut->if_sdm_migration~get_status_value_done( ).

    " Then: It should return '9'.
    cl_abap_unit_assert=>assert_equals(
      exp = mo_cut->mc_sdm_status-done
      act = lv_status_value_done
    ).

  ENDMETHOD.

  METHOD get_table_name.

    DATA:
      lv_tabname TYPE tabname.

    " When: I ask for the table name.
    lv_tabname = mo_cut->if_sdm_migration~get_table_name( ).

    " Then: It should return the SQL view name 'PSDMCH'.
    cl_abap_unit_assert=>assert_equals(
      exp = mo_cut->mc_view_name
      act = lv_tabname
    ).

  ENDMETHOD.

  METHOD migrate_data.

    DATA:
      lt_clf_hdr_exp       TYPE TABLE OF clf_hdr,
      ls_condition         TYPE cl_shdb_pfw_selset=>ts_selset,
      lt_rng_status        TYPE RANGE OF p_clfnsdmclfhdr-sdm_status,
      lo_dref              TYPE REF TO data,
      lt_filter_conditions TYPE cl_shdb_pfw_selset=>tt_selset.

    FIELD-SYMBOLS:
      <lr_ranges1> TYPE ANY TABLE.

    " Given: There are 3 entries in the CDS View.
    " And: There is one entry in CLF_HDR.
    me->migrate_data_prepare_data( ).

    " And: There is a filter condition.
    CREATE DATA lo_dref LIKE lt_rng_status.
    ASSIGN lo_dref->* TO <lr_ranges1>.
    lt_rng_status = VALUE #( ( sign = 'I' option = 'LT' low = mo_cut->mc_sdm_status-done )  ).
    <lr_ranges1> = lt_rng_status.
    CLEAR ls_condition.
    ls_condition-name1 = mo_cut->mc_status_field.
    GET REFERENCE OF <lr_ranges1> INTO ls_condition-dref1.
    APPEND ls_condition TO lt_filter_conditions.

    " When: I try to migrate the data.
    TRY.
        mo_cut->if_sdm_migration~migrate_data( it_filter_condition = lt_filter_conditions ).

      CATCH cx_static_check INTO DATA(lx_static_check).
        cl_abap_unit_assert=>fail(
          msg = |Unexpected exception occurred in migrate_data()! { lx_static_check->get_text( ) }|
        ).
    ENDTRY.

    SELECT * FROM clf_hdr INTO TABLE @DATA(lt_clf_hdr_act).

    " Then: The OBJEKP fields of CLF_HDR should be filled in the already existing entries.
    " And: The entries from the CDS View are inserted or updated in(to) table CLF_HDR.
    lt_clf_hdr_exp = VALUE #(
      (
        mandt = sy-mandt
        obtab = 'MCH1'
        objek = 'OBJ1'
        mafid = 'O'
        klart = '023'
        objekp = '000000000000000122'
        cuobj = 122
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER'
      )
      (
        mandt = sy-mandt
        obtab = 'MARA'
        objek = 'OBJ2'
        mafid = 'O'
        klart = '023'
        objekp = '000000000000000123'
        cuobj = 123
        tstmp_i = '1'
        user_i = sy-uname
        tstmp_c = ''
        user_c = '' )
    ).
    cl_abap_unit_assert=>assert_equals(
      exp = lt_clf_hdr_exp
      act = lt_clf_hdr_act
    ).

  ENDMETHOD.

  METHOD migrate_data_testmode.

    DATA:
      lt_clf_hdr_exp       TYPE TABLE OF clf_hdr,
      ls_condition         TYPE cl_shdb_pfw_selset=>ts_selset,
      lt_rng_status        TYPE RANGE OF p_clfnsdmclfhdr-sdm_status,
      lo_dref              TYPE REF TO data,
      lt_filter_conditions TYPE cl_shdb_pfw_selset=>tt_selset.

    FIELD-SYMBOLS:
      <lr_ranges1> TYPE ANY TABLE.

    " Given: There are 3 entries in the CDS View.
    " And: There is one entry in CLF_HDR.
    me->migrate_data_prepare_data( ).
    mo_cut->mv_test_mode = abap_true.

    " And: There is a filter condition.
    CREATE DATA lo_dref LIKE lt_rng_status.
    ASSIGN lo_dref->* TO <lr_ranges1>.
    lt_rng_status = VALUE #( ( sign = 'I' option = 'LT' low = mo_cut->mc_sdm_status-done )  ).
    <lr_ranges1> = lt_rng_status.
    CLEAR ls_condition.
    ls_condition-name1 = mo_cut->mc_status_field.
    GET REFERENCE OF <lr_ranges1> INTO ls_condition-dref1.
    APPEND ls_condition TO lt_filter_conditions.

    " When: I try to migrate the data.
    TRY.
        mo_cut->if_sdm_migration~migrate_data( it_filter_condition = lt_filter_conditions ).

      CATCH cx_static_check INTO DATA(lx_static_check).
        cl_abap_unit_assert=>fail(
          msg = |Unexpected exception occurred in migrate_data()! { lx_static_check->get_text( ) }|
        ).
    ENDTRY.

    SELECT * FROM clf_hdr INTO TABLE @DATA(lt_clf_hdr_act).

    " Then: Every entries in CLF_HDR remained intact.
    lt_clf_hdr_exp = VALUE #(
      (
        mandt = sy-mandt
        obtab = 'MCH1'
        objek = 'OBJ1'
        mafid = 'O'
        klart = '023'
        objekp = ''
        cuobj = 122
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER'
      )
    ).
    cl_abap_unit_assert=>assert_equals(
      exp = lt_clf_hdr_exp
      act = lt_clf_hdr_act
    ).

  ENDMETHOD.

  METHOD migrate_data_finished.

    " When: migration of data is finished.
    mo_cut->if_sdm_migration~migrate_data_finished( ).

    " Then: A message was logged.
    cl_abap_unit_assert=>assert_equals(
      exp = 0
      act = 0
    ).

  ENDMETHOD.

  METHOD migrate_data_prepare_data.

    DATA:
      lt_p_clfnsdmclfhdr TYPE TABLE OF p_clfnsdmclfhdr,
      lt_clf_hdr         TYPE TABLE OF clf_hdr.

    lt_p_clfnsdmclfhdr = VALUE #(
      (
        obtab = 'MCH1'
        objek = 'OBJ1'
        mafid = 'O'
        klart = '023'
        objekp = '000000000000000122'
        cuobj = 122
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER'
        sdm_status = '2'
      )
      (
        obtab = 'MARA'
        objek = 'OBJ2'
        mafid = 'O'
        klart = '023'
        objekp = '000000000000000123'
        cuobj = 123
        tstmp_i = '1'
        user_i = sy-uname
        tstmp_c = ''
        user_c = ''
        sdm_status = '4'
      )
      (
        obtab = 'MARA'
        objek = 'OBJ2'
        mafid = 'O'
        klart = '023'
        objekp = '000000000000000124'
        cuobj = 124
        tstmp_i = '1'
        user_i = sy-uname
        tstmp_c = ''
        user_c = ''
        sdm_status = '4' )
    ).
    go_osql_env->insert_test_data( lt_p_clfnsdmclfhdr ).

    lt_clf_hdr = VALUE #(
      (
        mandt = sy-mandt
        obtab = 'MCH1'
        objek = 'OBJ1'
        mafid = 'O'
        klart = '023'
        objekp = ''
        cuobj = 122
        tstmp_i = '1'
        user_i = 'TESTUSER'
        tstmp_c = '1'
        user_c = 'TESTUSER' )
    ).
    go_osql_env->insert_test_data( lt_clf_hdr ).

  ENDMETHOD.

  METHOD must_run.

    DATA:
      lv_must_run TYPE abap_bool.

    " When: I ask for whether the SDM must run.
    lv_must_run = mo_cut->if_sdm_migration~must_run( ).

    " Then: It should return true or false depending on whether the system is on-premise or cloud
    IF cl_cos_utilities=>is_cloud( ) = abap_true.
      cl_abap_unit_assert=>assert_equals(
        exp = abap_false
        act = lv_must_run
      ).
    ELSE.
      cl_abap_unit_assert=>assert_equals(
        exp = abap_true
        act = lv_must_run
      ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.