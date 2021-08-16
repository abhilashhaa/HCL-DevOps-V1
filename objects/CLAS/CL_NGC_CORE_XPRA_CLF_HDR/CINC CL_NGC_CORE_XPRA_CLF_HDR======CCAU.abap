CLASS ltc_ngc_core_xpra_clf_hdr DEFINITION DEFERRED.
CLASS cl_ngc_core_xpra_clf_hdr DEFINITION LOCAL FRIENDS ltc_ngc_core_xpra_clf_hdr.

CLASS ltc_ngc_core_xpra_clf_hdr DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.
  PUBLIC SECTION.
    DATA:
     mo_cut TYPE REF TO cl_ngc_core_xpra_clf_hdr.

    METHODS: convert_success FOR TESTING.
    METHODS: before_conversion_nodata FOR TESTING.
    METHODS: before_conversion_error FOR TESTING.
    METHODS: after_conversion_success FOR TESTING.

  PRIVATE SECTION.
    CLASS-DATA:
      go_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS: class_setup.

    METHODS: setup.
    METHODS: teardown.
ENDCLASS.

CLASS ltc_ngc_core_xpra_clf_hdr IMPLEMENTATION.
  METHOD class_setup.

    go_environment = cl_osql_test_environment=>create( i_dependency_list =
      VALUE #( ( 'CLF_HDR' ) )
    ).

    cl_ngc_core_data_conv=>init_logger( 'UT' ).
  ENDMETHOD.

  METHOD setup.
    go_environment->clear_doubles( ).

    mo_cut = NEW #( iv_appl_name = 'UT' iv_client = sy-mandt ).
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD convert_success.
    DATA:
      lt_clf_hdr      TYPE TABLE OF clf_hdr,
      lt_clf_hdr_exp  TYPE TABLE OF clf_hdr.

    " Preparation: Test data
    TEST-INJECTION data_exists_seam.
      lv_data_exists = abap_true.
    END-TEST-INJECTION.
    TEST-INJECTION get_packsel_seam.
      APPEND VALUE #( packno = 1 ) TO lt_tabsplit_packsel.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_cm_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_cs_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_k_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_m_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_s_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_cm_seam.
      lt_clf_hdr = VALUE #( ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ1' mafid = 'O' klart = '023' objekp = '' cuobj = 122 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' ) ).
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_cs_seam.
      lt_clf_hdr = VALUE #( ( mandt = sy-mandt obtab = 'MARA' objek = 'OBJ2' mafid = 'O' klart = '023' objekp = '' cuobj = 0   tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER') ).
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_k_seam.
      lt_clf_hdr = VALUE #( ( mandt = sy-mandt obtab = 'MARA' objek = '11' mafid = 'K' klart = '023' objekp = '' cuobj = 0 ) ).
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_m_seam.
      lt_clf_hdr = VALUE #(
        ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ3' mafid = 'O' klart = '023' objekp = '' cuobj = 123 )
        ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ3' mafid = 'O' klart = '023' objekp = '' cuobj = 124 )
      ).
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_s_seam.
      lt_clf_hdr = VALUE #( ( mandt = sy-mandt obtab = 'MARA' objek = 'OBJ4' mafid = 'O' klart = '023' objekp = '' cuobj = 0 ) ).
    END-TEST-INJECTION.
    lt_clf_hdr = VALUE #(
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ1' mafid = 'O' klart = '023' objekp = '' cuobj = 122 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' )
      ( mandt = sy-mandt obtab = 'MARA' objek = 'OBJ2' mafid = 'O' klart = '023' objekp = '' cuobj = 0   tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER')
    ).
    go_environment->insert_test_data( lt_clf_hdr ).
    lt_clf_hdr_exp = VALUE #(
      ( mandt = sy-mandt obtab = 'MARA' objek = 'OBJ2' mafid = 'O' klart = '023' objekp = 'OBJ2' cuobj = 0 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' )
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ1' mafid = 'O' klart = '023' objekp = '000000000000000122' cuobj = 122 tstmp_i = '1' user_i = 'TESTUSER' tstmp_c = '1' user_c = 'TESTUSER' )
      ( mandt = sy-mandt obtab = 'MARA' objek = 'OBJ4' mafid = 'O' klart = '023' objekp = 'OBJ4' cuobj = 0 user_i = sy-uname )
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ3' mafid = 'O' klart = '023' objekp = '000000000000000123' cuobj = 123 user_i = sy-uname )
      ( mandt = sy-mandt obtab = 'MARA' objek = '11' mafid = 'K' klart = '023' objekp = '' cuobj = 0 user_i = sy-uname )
    ).

    " Action
    mo_cut->convert( ).

    " Get the results
    SELECT * FROM clf_hdr INTO TABLE @DATA(lt_clf_hdr_act).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = lines( lt_clf_hdr_exp )
      act = lines( lt_clf_hdr_act )
    ).
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act = lt_clf_hdr_act[ 3 ]-tstmp_i
    ).
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act = lt_clf_hdr_act[ 4 ]-tstmp_i
    ).
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act = lt_clf_hdr_act[ 5 ]-tstmp_i
    ).
    lt_clf_hdr_exp[ 3 ]-tstmp_i = lt_clf_hdr_act[ 3 ]-tstmp_i.
    lt_clf_hdr_exp[ 4 ]-tstmp_i = lt_clf_hdr_act[ 4 ]-tstmp_i.
    lt_clf_hdr_exp[ 5 ]-tstmp_i = lt_clf_hdr_act[ 5 ]-tstmp_i.
    cl_abap_unit_assert=>assert_equals(
      exp = lt_clf_hdr_exp
      act = lt_clf_hdr_act
    ).
  ENDMETHOD.

  METHOD before_conversion_nodata.
    " Preparation: Test data
    TEST-INJECTION auth_check_seam.
      rv_exit = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION exists_1_seam.
      lv_exists_cs = abap_false.
      lv_exists_cm = abap_false.
      lv_exists_s = abap_false.
      lv_exists_m = abap_false.
      lv_exists_k = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION exists_2_seam.
      lv_exists_cs = abap_false.
      lv_exists_cm = abap_false.
      lv_exists_s = abap_false.
      lv_exists_m = abap_false.
      lv_exists_k = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION create_view_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_1_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_2_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_3_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_4_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_5_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION log_close_1_seam.
    END-TEST-INJECTION.
    TEST-INJECTION log_close_2_seam.
    END-TEST-INJECTION.

    " Action
    DATA(lv_exit) = mo_cut->before_conversion( iv_client = sy-mandt ).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = abap_true
      act = lv_exit
    ).
  ENDMETHOD.

  METHOD before_conversion_error.
    " Preparation: Test data
    TEST-INJECTION auth_check_seam.
      rv_exit = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION exists_1_seam.
      lv_exists_cs = abap_false.
      lv_exists_cm = abap_false.
      lv_exists_s = abap_false.
      lv_exists_m = abap_false.
      lv_exists_k = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION exists_2_seam.
      lv_exists_cs = abap_false.
      lv_exists_cm = abap_false.
      lv_exists_s = abap_false.
      lv_exists_m = abap_false.
      lv_exists_k = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION create_view_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_1_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_2_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_3_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_4_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_5_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION log_close_1_seam.
    END-TEST-INJECTION.
    TEST-INJECTION log_close_2_seam.
    END-TEST-INJECTION.

    " Action
    DATA(lv_exit) = mo_cut->before_conversion( iv_client = sy-mandt ).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = abap_true
      act = lv_exit
    ).
  ENDMETHOD.

  METHOD after_conversion_success.
    " Preparation: Test data
    TEST-INJECTION delete_view_1_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_2_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_3_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_4_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_5_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION log_close_3_seam.
    END-TEST-INJECTION.

    " Action
    mo_cut->after_conversion( ).

    " If there were no exceptions until this, we are good.
    cl_abap_unit_assert=>assert_equals(
      exp = 0
      act = 0
    ).
  ENDMETHOD.
ENDCLASS.