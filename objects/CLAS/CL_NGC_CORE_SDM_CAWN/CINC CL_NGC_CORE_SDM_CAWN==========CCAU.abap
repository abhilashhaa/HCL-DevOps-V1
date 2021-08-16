CLASS ltc_ngc_core_sdm_cawn DEFINITION DEFERRED.
CLASS cl_ngc_core_sdm_cawn DEFINITION LOCAL FRIENDS ltc_ngc_core_sdm_cawn.

CLASS lth_ngc_core_sdm_cawn DEFINITION
  FOR TESTING.

  PUBLIC SECTION.

    TYPES:
      ty_t_cawncds TYPE STANDARD TABLE OF p_clfnsdmcawn WITH EMPTY KEY.

    CLASS-DATA:
      gs_cawn_num               TYPE cawn,
      gs_cawn_num_small           TYPE cawn,
      gs_cawn_num_large           TYPE cawn,
      gs_cawn_num_zero            TYPE cawn,
      gs_cawn_num_near_zero       TYPE cawn,
      gs_cawn_num_rounded1        TYPE cawn,
      gs_cawn_num_rounded2        TYPE cawn,
      gs_cawn_num_uom1            TYPE cawn,

      gs_cawn_e_num_small         TYPE cawn,
      gs_cawn_e_num_large         TYPE cawn,
      gs_cawn_e_num_small2        TYPE cawn,
      gs_cawn_e_num_large2        TYPE cawn,
      gs_cawn_e_num_near_zero     TYPE cawn,
      gs_cawn_e_num_rounded       TYPE cawn,

      gs_cawn_curr                TYPE cawn,
      gs_cawn_curr_wrong          TYPE cawn,

      gs_cawn_date                TYPE cawn,
      gs_cawn_time                TYPE cawn,

      gs_cawn_num_exp             TYPE cawn,
      gs_cawn_num_small_exp       TYPE cawn,
      gs_cawn_num_large_exp       TYPE cawn,
      gs_cawn_num_zero_exp        TYPE cawn,
      gs_cawn_num_near_zero_exp   TYPE cawn,
      gs_cawn_num_rounded1_exp    TYPE cawn,
      gs_cawn_num_rounded2_exp    TYPE cawn,
      gs_cawn_num_uom1_exp        TYPE cawn,
      gs_cawn_e_num_small_exp     TYPE cawn,
      gs_cawn_e_num_large_exp     TYPE cawn,
      gs_cawn_e_num_small2_exp    TYPE cawn,
      gs_cawn_e_num_large2_exp    TYPE cawn,
      gs_cawn_e_num_near_zero_exp TYPE cawn,
      gs_cawn_e_num_rounded_exp   TYPE cawn,
      gs_cawn_curr_exp          TYPE cawn,
      gs_cawn_curr_wrong_exp    TYPE cawn,
      gs_cawn_date_exp          TYPE cawn,
      gs_cawn_time_exp          TYPE cawn,

      gs_cawn_num_cds             TYPE p_clfnsdmcawn,
      gs_cawn_num_small_cds       TYPE p_clfnsdmcawn,
      gs_cawn_num_large_cds       TYPE p_clfnsdmcawn,
      gs_cawn_num_zero_cds        TYPE p_clfnsdmcawn,
      gs_cawn_num_near_zero_cds   TYPE p_clfnsdmcawn,
      gs_cawn_num_rounded1_cds    TYPE p_clfnsdmcawn,
      gs_cawn_num_rounded2_cds    TYPE p_clfnsdmcawn,
      gs_cawn_num_uom1_cds        TYPE p_clfnsdmcawn,
      gs_cawn_e_num_small_cds     TYPE p_clfnsdmcawn,
      gs_cawn_e_num_large_cds     TYPE p_clfnsdmcawn,
      gs_cawn_e_num_small2_cds    TYPE p_clfnsdmcawn,
      gs_cawn_e_num_large2_cds    TYPE p_clfnsdmcawn,
      gs_cawn_e_num_near_zero_cds TYPE p_clfnsdmcawn,
      gs_cawn_e_num_rounded_cds   TYPE p_clfnsdmcawn,
      gs_cawn_curr_cds          TYPE p_clfnsdmcawn,
      gs_cawn_curr_wrong_cds    TYPE p_clfnsdmcawn,
      gs_cawn_date_cds          TYPE p_clfnsdmcawn,
      gs_cawn_time_cds          TYPE p_clfnsdmcawn.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_ngc_core_sdm_cawn IMPLEMENTATION.

  METHOD class_constructor.

* Mock values for the CAWN DB table before data migration.
    gs_cawn_num = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 3
      atflv = 1
      atflb = 99 ).

    gs_cawn_num_small = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0002'
      adzhl = '0000'
      atcod = 1
      atflv = '-9.9999999999999901E+01' ).

    gs_cawn_num_large = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0003'
      adzhl = '0000'
      atcod = 1
      atflv = '9.9999999999999901E+01' ).

    gs_cawn_num_zero = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0004'
      adzhl = '0000'
      atcod = 1
      atflv = '0.0000000000000000E+00' ).

    gs_cawn_num_near_zero = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0005'
      adzhl = '0000'
      atcod = 1
      atflv = '1.0000000000000000E-13' ).

    gs_cawn_num_rounded1 = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0006'
      adzhl = '0000'
      atcod = 1
      atflv = '1.4999999999999999E-01' ).

    gs_cawn_num_rounded2 = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0007'
      adzhl = '0000'
      atcod = 1
      atflv = '7.3049999999999997E+00' ).

    gs_cawn_num_uom1 = VALUE #(
      mandt = sy-mandt
      atinn = '0000000001'
      atzhl = '0008'
      adzhl = '0000'
      atcod = 1
      atflv = '1.234560000000000E+00'
      atawe = 'G'  ).

    gs_cawn_e_num_small = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 1
      atflv = '-9.9999999999999893E+00' ).

    gs_cawn_e_num_large = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0002'
      adzhl = '0000'
      atcod = 1
      atflv = '9.9999999999999893E+00' ).

    gs_cawn_e_num_small2 = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0003'
      adzhl = '0000'
      atcod = 1
      atflv = '-1.0000000000000000E+100' ).

    gs_cawn_e_num_large2 = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0004'
      adzhl = '0000'
      atcod = 1
      atflv = '9.9999999999999904E+99' ).

    gs_cawn_e_num_near_zero = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0005'
      adzhl = '0000'
      atcod = 1
      atflv = '1.0000000000000000E-99' ).

    gs_cawn_e_num_rounded = VALUE #(
      mandt = sy-mandt
      atinn = '0000000011'
      atzhl = '0006'
      adzhl = '0000'
      atcod = 1
      atflv = '5.5599999999999898E+02' ).

    gs_cawn_curr = VALUE #(
      mandt = sy-mandt
      atinn = '0000000002'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 3
      atflv = 100
      atflb = 10000 ).

    gs_cawn_curr_wrong = VALUE #(
      mandt = sy-mandt
      atinn = '0000000022'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 1
      atflv = 100
      atflb = 0 ).

    gs_cawn_date = VALUE #(
      mandt = sy-mandt
      atinn = '0000000003'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 3
      atflv = 20190101
      atflb = 20191231 ).

    gs_cawn_time = VALUE #(
      mandt = sy-mandt
      atinn = '0000000004'
      atzhl = '0001'
      adzhl = '0000'
      atcod = 3
      atflv = 112233
      atflb = 223344 ).

* Mock values for the CAWN CDS view before data migration.
    gs_cawn_num_cds = CORRESPONDING #( gs_cawn_num ).
    gs_cawn_num_cds-chr_data_type = 'NUM'.
    gs_cawn_num_cds-length   = 15.
    gs_cawn_num_cds-decimals = 13.
    gs_cawn_num_cds-exp_disp_format = 0.

    gs_cawn_num_large_cds = CORRESPONDING #( gs_cawn_num_large ).
    gs_cawn_num_large_cds-chr_data_type = 'NUM'.
    gs_cawn_num_large_cds-length   = 15.
    gs_cawn_num_large_cds-decimals = 13.
    gs_cawn_num_large_cds-exp_disp_format = 0.

    gs_cawn_num_small_cds = CORRESPONDING #( gs_cawn_num_small ).
    gs_cawn_num_small_cds-chr_data_type = 'NUM'.
    gs_cawn_num_small_cds-length   = 15.
    gs_cawn_num_small_cds-decimals = 13.
    gs_cawn_num_small_cds-exp_disp_format = 0.

    gs_cawn_num_zero_cds = CORRESPONDING #( gs_cawn_num_zero ).
    gs_cawn_num_zero_cds-chr_data_type = 'NUM'.
    gs_cawn_num_zero_cds-length   = 15.
    gs_cawn_num_zero_cds-decimals = 13.
    gs_cawn_num_zero_cds-exp_disp_format = 0.

    gs_cawn_num_near_zero_cds = CORRESPONDING #( gs_cawn_num_near_zero ).
    gs_cawn_num_near_zero_cds-chr_data_type = 'NUM'.
    gs_cawn_num_near_zero_cds-length   = 15.
    gs_cawn_num_near_zero_cds-decimals = 13.
    gs_cawn_num_near_zero_cds-exp_disp_format = 0.

    gs_cawn_num_rounded1_cds = CORRESPONDING #( gs_cawn_num_rounded1 ).
    gs_cawn_num_rounded1_cds-chr_data_type = 'NUM'.
    gs_cawn_num_rounded1_cds-length   = 15.
    gs_cawn_num_rounded1_cds-decimals = 13.
    gs_cawn_num_rounded1_cds-exp_disp_format = 0.

    gs_cawn_num_rounded2_cds = CORRESPONDING #( gs_cawn_num_rounded2 ).
    gs_cawn_num_rounded2_cds-chr_data_type = 'NUM'.
    gs_cawn_num_rounded2_cds-length   = 15.
    gs_cawn_num_rounded2_cds-decimals = 13.
    gs_cawn_num_rounded2_cds-exp_disp_format = 0.

    gs_cawn_num_uom1_cds = CORRESPONDING #( gs_cawn_num_uom1 ).
    gs_cawn_num_uom1_cds-chr_data_type = 'NUM'.
    gs_cawn_num_uom1_cds-length   = 8.
    gs_cawn_num_uom1_cds-decimals = 4.
    gs_cawn_num_uom1_cds-exp_disp_format = 0.
    gs_cawn_num_uom1_cds-msehi = 'KG'.

    gs_cawn_e_num_large_cds = CORRESPONDING #( gs_cawn_e_num_large ).
    gs_cawn_e_num_large_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_large_cds-decimals = 3.
    gs_cawn_e_num_large_cds-exp_disp_format = 1.

    gs_cawn_e_num_small_cds = CORRESPONDING #( gs_cawn_e_num_small ).
    gs_cawn_e_num_small_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_small_cds-decimals = 3.
    gs_cawn_e_num_small_cds-exp_disp_format = 1.

    gs_cawn_e_num_large2_cds = CORRESPONDING #( gs_cawn_e_num_large2 ).
    gs_cawn_e_num_large2_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_large2_cds-length   = 4.
    gs_cawn_e_num_large2_cds-decimals = 3.
    gs_cawn_e_num_large2_cds-exp_disp_format = 1.

    gs_cawn_e_num_small2_cds = CORRESPONDING #( gs_cawn_e_num_small2 ).
    gs_cawn_e_num_small2_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_small2_cds-length   = 4.
    gs_cawn_e_num_small2_cds-decimals = 3.
    gs_cawn_e_num_small2_cds-exp_disp_format = 1.

    gs_cawn_e_num_near_zero_cds = CORRESPONDING #( gs_cawn_e_num_near_zero ).
    gs_cawn_e_num_near_zero_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_near_zero_cds-length   = 4.
    gs_cawn_e_num_near_zero_cds-decimals = 3.
    gs_cawn_e_num_near_zero_cds-exp_disp_format = 1.

    gs_cawn_e_num_rounded_cds = CORRESPONDING #( gs_cawn_e_num_rounded ).
    gs_cawn_e_num_rounded_cds-chr_data_type = 'NUM'.
    gs_cawn_e_num_rounded_cds-length   = 4.
    gs_cawn_e_num_rounded_cds-decimals = 3.
    gs_cawn_e_num_rounded_cds-exp_disp_format = 1.

    gs_cawn_curr_cds = CORRESPONDING #( gs_cawn_curr ).
    gs_cawn_curr_cds-chr_data_type = 'CURR'.
    gs_cawn_curr_cds-msehi         = 'EUR'.

    gs_cawn_curr_wrong_cds = CORRESPONDING #( gs_cawn_curr_wrong ).
    gs_cawn_curr_wrong_cds-chr_data_type = 'CURR'.
    gs_cawn_curr_wrong_cds-msehi         = 'XYZ'. " Non-existing currency.

    gs_cawn_date_cds = CORRESPONDING #( gs_cawn_date ).
    gs_cawn_date_cds-chr_data_type = 'DATE'.

    gs_cawn_time_cds = CORRESPONDING #( gs_cawn_time ).
    gs_cawn_time_cds-chr_data_type = 'TIME'.

* Expected mock values of the CAWN DB table after data migration.
    gs_cawn_num_exp = gs_cawn_num.
    gs_cawn_num_exp-dec_from = 1.
    gs_cawn_num_exp-dec_to   = 99.

    gs_cawn_num_large_exp = gs_cawn_num_large.
    gs_cawn_num_large_exp-dec_from = '99.9999999999999'.
    gs_cawn_num_large_exp-dec_to   = '99.9999999999999'.

    gs_cawn_num_small_exp = gs_cawn_num_small.
    gs_cawn_num_small_exp-dec_from = '-99.9999999999999'.
    gs_cawn_num_small_exp-dec_to   = '-99.9999999999999'.

    gs_cawn_num_zero_exp = gs_cawn_num_zero.
    gs_cawn_num_zero_exp-dec_from = '0.0000000000000'.
    gs_cawn_num_zero_exp-dec_to   = '0.0000000000000'.

    gs_cawn_num_near_zero_exp = gs_cawn_num_near_zero.
    gs_cawn_num_near_zero_exp-dec_from = '0.0000000000001'.
    gs_cawn_num_near_zero_exp-dec_to   = '0.0000000000001'.

    gs_cawn_num_rounded1_exp = gs_cawn_num_rounded1.
    gs_cawn_num_rounded1_exp-dec_from = '0.1500000000000'.
    gs_cawn_num_rounded1_exp-dec_to   = '0.1500000000000'.

    gs_cawn_num_rounded2_exp = gs_cawn_num_rounded2.
    gs_cawn_num_rounded2_exp-dec_from = '7.3050000000000'.
    gs_cawn_num_rounded2_exp-dec_to   = '7.3050000000000'.

    gs_cawn_num_uom1_exp = gs_cawn_num_uom1.
    gs_cawn_num_uom1_exp-dec_from = '1.23456'.
    gs_cawn_num_uom1_exp-dec_to   = '1.23456'.

    gs_cawn_e_num_large_exp = gs_cawn_e_num_large.
    gs_cawn_e_num_large_exp-dec_from = '1.000E+01'.
    gs_cawn_e_num_large_exp-dec_to   = '1.000E+01'.

    gs_cawn_e_num_small_exp = gs_cawn_e_num_small.
    gs_cawn_e_num_small_exp-dec_from = '-1.000E+01'.
    gs_cawn_e_num_small_exp-dec_to   = '-1.000E+01'.

    gs_cawn_e_num_large2_exp = gs_cawn_e_num_large2.
    gs_cawn_e_num_large2_exp-dec_from = '1.000E+100'.
    gs_cawn_e_num_large2_exp-dec_to   = '1.000E+100'.

    gs_cawn_e_num_small2_exp = gs_cawn_e_num_small2.
    gs_cawn_e_num_small2_exp-dec_from = '-1.000E+100'.
    gs_cawn_e_num_small2_exp-dec_to   = '-1.000E+100'.

    gs_cawn_e_num_near_zero_exp = gs_cawn_e_num_near_zero.
    gs_cawn_e_num_near_zero_exp-dec_from = '1.000E-99'.
    gs_cawn_e_num_near_zero_exp-dec_to   = '1.000E-99'.

    gs_cawn_e_num_rounded_exp = gs_cawn_e_num_rounded.
    gs_cawn_e_num_rounded_exp-dec_from = '556'.
    gs_cawn_e_num_rounded_exp-dec_to   = '556'.

    gs_cawn_curr_exp = gs_cawn_curr.
    gs_cawn_curr_exp-curr_from = 100.
    gs_cawn_curr_exp-curr_to   = 10000.
    gs_cawn_curr_exp-currency  = gs_cawn_curr_cds-msehi.

    gs_cawn_curr_wrong_exp = gs_cawn_curr_wrong.
    gs_cawn_curr_wrong_exp-curr_from = 0.
    gs_cawn_curr_wrong_exp-curr_to   = 0.

    gs_cawn_date_exp = gs_cawn_date.
    gs_cawn_date_exp-date_from = '20190101'.
    gs_cawn_date_exp-date_to   = '20191231'.

    gs_cawn_time_exp = gs_cawn_time.
    gs_cawn_time_exp-time_from = '112233'.
    gs_cawn_time_exp-time_to   = '223344'.

  ENDMETHOD.

ENDCLASS.

CLASS ltc_ngc_core_sdm_cawn DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.

    CLASS-DATA:
      go_osql_env      TYPE REF TO if_osql_test_environment.

    DATA:
      mo_cut    TYPE REF TO cl_ngc_core_sdm_cawn,
      mo_logger TYPE REF TO if_sdm_logger.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      teardown.

    METHODS:
      set_cawn_db_table
        IMPORTING
          it_data TYPE tt_cawn,
      set_cawn_cds_view
        IMPORTING
          it_data TYPE lth_ngc_core_sdm_cawn=>ty_t_cawncds.

    METHODS:
      get_status_value_done   FOR TESTING,
      get_status_field        FOR TESTING,
      migrate_correct_data    FOR TESTING RAISING cx_static_check,
      migrate_correct_data_exp FOR TESTING RAISING cx_static_check,
      migrate_incorrect_data   FOR TESTING RAISING cx_static_check,
      get_table_name          FOR TESTING,
      get_selective_field     FOR TESTING,
      must_run                FOR TESTING,
      migrate_data_finished   FOR TESTING,
      get_package_size        FOR TESTING.

ENDCLASS.

CLASS ltc_ngc_core_sdm_cawn IMPLEMENTATION.

  METHOD class_setup.

    go_osql_env = cl_osql_test_environment=>create( VALUE #( ( 'CAWN' ) ( 'P_CLFNSDMCAWN' ) ) ).

    cl_ngc_core_data_conv=>init_logger( 'UT' ).

  ENDMETHOD.

  METHOD class_teardown.

    go_osql_env->destroy( ).

  ENDMETHOD.

  METHOD setup.

    mo_logger ?= cl_abap_testdouble=>create( 'if_sdm_logger' ).

    mo_cut = NEW #( ).

    mo_cut->mo_logger = mo_logger.

  ENDMETHOD.

  METHOD teardown.

    go_osql_env->clear_doubles( ).

  ENDMETHOD.

  METHOD set_cawn_db_table.

    go_osql_env->insert_test_data( it_data ).

  ENDMETHOD.

  METHOD set_cawn_cds_view.

    go_osql_env->insert_test_data( it_data ).

  ENDMETHOD.

  METHOD get_status_value_done.

    " Given: Private constant for status 'Done'.

    " When: The caller retrieve the status value via a dedicated method.
    DATA(lv_status_value_done) = mo_cut->if_sdm_migration~get_status_value_done( ).

    " Then: The appropriate value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_status_value_done
      exp = mo_cut->mc_status_value_done
    ).

  ENDMETHOD.

  METHOD get_status_field.

    " Given: Private constant for the status field name.

    " When: The caller retrieve the name of the status field via a dedicated method.
    DATA(lv_status_field) = mo_cut->if_sdm_migration~get_status_field( ).

    " Then: The appropriate value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_status_field
      exp = mo_cut->mc_status_field_name
    ).

  ENDMETHOD.

  METHOD migrate_correct_data.

    " Given:
    " The characteristic values DB table, the related CDS view and the expected result,
    " filled up with consistent test data.
    " Message logger to add message(s).

    set_cawn_db_table( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_large )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_small )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_zero )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_near_zero )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded1 )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded2 )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_uom1 )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_date )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_time ) ) ).

    set_cawn_cds_view( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_large_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_small_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_zero_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_near_zero_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded1_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded2_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_uom1_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_date_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_time_cds ) ) ).

    DATA(lt_cawn_exp) = VALUE tt_cawn(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_large_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_small_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_zero_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_near_zero_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded1_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_rounded2_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_num_uom1_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_date_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_time_exp ) ).

    cl_abap_testdouble=>configure_call( mo_logger
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_once( ). " Only one final message is expected.
    mo_logger->add_message( ).

    " When: The data migration is executed.
    mo_cut->if_sdm_migration~migrate_data( it_filter_condition = VALUE #( ( ) ) ).

    " Then: The processed data should equal with the expected data and there is one logged message.
    SELECT * FROM cawn INTO TABLE @DATA(lt_cawn_act).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_cawn_exp
      act = lt_cawn_act
    ).

    cl_abap_testdouble=>verify_expectations( double = mo_logger ).

  ENDMETHOD.

  METHOD migrate_correct_data_exp.

    " Given:
    " The characteristic values DB table, the related CDS view and the expected result,
    " filled up with consistent test data.
    " Message logger to add message(s).

    set_cawn_db_table( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large2 )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small2 )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_near_zero )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_rounded ) ) ).

    set_cawn_cds_view( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large2_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small2_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_near_zero_cds )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_rounded_cds ) ) ).

    DATA(lt_cawn_exp) = VALUE tt_cawn(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_large2_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_small2_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_near_zero_exp )
      ( lth_ngc_core_sdm_cawn=>gs_cawn_e_num_rounded_exp ) ).

    cl_abap_testdouble=>configure_call( mo_logger
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_once( ). " Only one final message is expected.
    mo_logger->add_message( ).

    " When: The data migration is executed.
    mo_cut->if_sdm_migration~migrate_data( it_filter_condition = VALUE #( ( ) ) ).

    " Then: The processed data should equal with the expected data and there is one logged message.
    SELECT * FROM cawn INTO TABLE @DATA(lt_cawn_act).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_cawn_exp
      act = lt_cawn_act
    ).

    cl_abap_testdouble=>verify_expectations( double = mo_logger ).

  ENDMETHOD.

  METHOD migrate_incorrect_data.

    " Given:
    " The characteristic values DB table, the related CDS view and the expected result,
    " filled up with incorrect test data.
    " Message logger to add (error) message(s).

    set_cawn_db_table( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr_wrong ) ) ).

    set_cawn_cds_view( VALUE #(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr_wrong_cds ) ) ).

    DATA(lt_cawn_exp) = VALUE tt_cawn(
      ( lth_ngc_core_sdm_cawn=>gs_cawn_curr_wrong_exp ) ).

    cl_abap_testdouble=>configure_call( mo_logger
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_times( times = lines( lt_cawn_exp ) ). " Messages for the incorrect entries is expected
    mo_logger->add_error( ).

    cl_abap_testdouble=>configure_call( mo_logger
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_times( times = 1 ). " And one final message is expected.
    mo_logger->add_message( ).

    " When: The data migration is executed.
    mo_cut->if_sdm_migration~migrate_data( it_filter_condition = VALUE #( ( ) ) ).

    " Then: The processed data should equal with the expected data and there are logged messages.
    SELECT * FROM cawn INTO TABLE @DATA(lt_cawn_act).

    cl_abap_unit_assert=>assert_equals(
      exp = lt_cawn_exp
      act = lt_cawn_act
    ).

    cl_abap_testdouble=>verify_expectations( double = mo_logger ).

  ENDMETHOD.

  METHOD get_table_name.

    " Given: Private constant for the table or view name that is tha basis of the current data migration.

    " When: The caller retrieve the table/view name via a dedicated method.
    DATA(lv_table_name) = mo_cut->if_sdm_migration~get_table_name( ).

    " Then: The appropriate value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_table_name
      exp = mo_cut->mc_db_view_name
    ).

  ENDMETHOD.

  METHOD get_selective_field.

    " Given: Private constant for the selective field which field is used to build packages by the SDM Framework.

    " When: The caller retrieve the selective field via a dedicated method.
    DATA(lv_selective_field) = mo_cut->if_sdm_migration~get_selective_field( ).

    " Then: The appropriate value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_selective_field
      exp = mo_cut->mc_key_field_name
    ).

  ENDMETHOD.

  METHOD must_run.

    " Given: 'must_run' flag is defined as abap_true, data migration can be executed unconditionally.

    " When: The caller retrieve the must_run flag via a dedicated method.
    DATA(lv_must_run) = mo_cut->if_sdm_migration~must_run( ).

    " Then: 'true' value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_must_run
      exp = abap_true
    ).

  ENDMETHOD.

  METHOD migrate_data_finished.

    " Given: Message logger to add (success) message
    cl_abap_testdouble=>configure_call( mo_logger
      )->ignore_all_parameters(
      )->and_expect(
      )->is_called_once( ). " Only one final message is expected.
    mo_logger->add_message( ).

    " When: The data migration is finished.
    mo_cut->if_sdm_migration~migrate_data_finished( ).

    " Then: There is one logged message.
    cl_abap_testdouble=>verify_expectations( double = mo_logger ).

  ENDMETHOD.

  METHOD get_package_size.

    " Given: Package size is defined as private constant.

    " When: The caller retrieve the packge size via a dedicated method.
    DATA(lv_package_size) = mo_cut->if_sdm_migration~get_package_size( ).

    " Then: The appropriate value should be provided.
    cl_abap_unit_assert=>assert_equals(
      act = lv_package_size
      exp = mo_cut->mc_package_size
    ).

  ENDMETHOD.

ENDCLASS.