CLASS ltc_ngc_core_xpra_inob_cleanup DEFINITION DEFERRED.
CLASS cl_ngc_core_xpra_inob_cleanup DEFINITION LOCAL FRIENDS ltc_ngc_core_xpra_inob_cleanup.

CLASS ltc_ngc_core_xpra_inob_cleanup DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.
  PUBLIC SECTION.
    DATA:
     mo_cut TYPE REF TO cl_ngc_core_xpra_inob_cleanup.

    METHODS: convert_success FOR TESTING.
    METHODS: convert_lock_err FOR TESTING.
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

CLASS ltc_ngc_core_xpra_inob_cleanup IMPLEMENTATION.
  METHOD class_setup.

    go_environment = cl_osql_test_environment=>create( i_dependency_list =
      VALUE #( ( 'INOB' ) )
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
      lt_inob    TYPE TABLE OF inob.

    " Preparation: Test data
    TEST-INJECTION get_packsel_seam.
      APPEND VALUE #( packno = 1 ) TO lt_tabsplit_packsel.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_seam.
      lt_inconinob = VALUE #(
        ( mandt = sy-mandt  cuobj = 123 )
      ).
    END-TEST-INJECTION.
    TEST-INJECTION lock_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION unlock_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION pp_lock_seam.
      lv_lock_error = lock_entries( ltr_cuobj ).
    END-TEST-INJECTION.
    TEST-INJECTION pp_unlock_seam.
      unlock_entries( ).
    END-TEST-INJECTION.
    lt_inob = VALUE #(
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ1' klart = '023' cuobj = 122 )
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ2' klart = '023' cuobj = 123 )
    ).
    go_environment->insert_test_data( lt_inob  ).

    " Action
    mo_cut->convert( ).

    " Get the results
    SELECT * FROM inob INTO TABLE @DATA(lt_inob_act).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = 1
      act = lines( lt_inob_act )
    ).
    cl_abap_unit_assert=>assert_equals(
      exp = lt_inob[ 1 ]
      act = lt_inob_act[ 1 ]
    ).
  ENDMETHOD.

  METHOD convert_lock_err.
    DATA:
      lt_inob    TYPE TABLE OF inob.

    " Preparation: Test data
    TEST-INJECTION get_packsel_seam.
      APPEND VALUE #( packno = 1 selection = VALUE #( ( name = '1' ) ) ) TO lt_tabsplit_packsel.
      APPEND VALUE #( packno = 2 selection = VALUE #( ( name = '2' ) ) ) TO lt_tabsplit_packsel.
      APPEND VALUE #( packno = 3 selection = VALUE #( ( name = '3' ) ) ) TO lt_tabsplit_packsel.
    END-TEST-INJECTION.
    TEST-INJECTION combine_seltabs_seam.
      lv_packsel_whr = ''.
    END-TEST-INJECTION.
    TEST-INJECTION select_cds_seam.
      CASE <ls_packsel>-selection[ 1 ]-name.
        WHEN '1'.
          lt_inconinob = VALUE #(
            ( mandt = sy-mandt  cuobj = 124 )
          ).
        WHEN '2'.
          lt_inconinob = VALUE #(
            ( mandt = sy-mandt  cuobj = 125 )
          ).
        WHEN '3'.
          lt_inconinob = VALUE #(
            ( mandt = sy-mandt  cuobj = 126 )
          ).
      ENDCASE.
    END-TEST-INJECTION.
    TEST-INJECTION lock_seam.
      IF <ls_inob>-objek = 'OBJ1'.
        sy-subrc = 1.
      ELSE.
        sy-subrc = 2.
      ENDIF.
    END-TEST-INJECTION.
    TEST-INJECTION unlock_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION pp_lock_seam.
      lv_lock_error = lock_entries( ltr_cuobj ).
    END-TEST-INJECTION.
    TEST-INJECTION pp_unlock_seam.
      unlock_entries( ).
    END-TEST-INJECTION.
    lt_inob = VALUE #(
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ1' klart = '023' cuobj = 124 )
      ( mandt = sy-mandt obtab = 'MCH1' objek = 'OBJ2' klart = '023' cuobj = 125 )
    ).
    go_environment->insert_test_data( lt_inob  ).

    " Action
    mo_cut->convert( ).

    " Get the results
    SELECT * FROM inob INTO TABLE @DATA(lt_inob_act).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = lt_inob
      act = lt_inob_act
    ).
  ENDMETHOD.

  METHOD before_conversion_nodata.
    " Preparation: Test data
    TEST-INJECTION auth_check_seam.
      rv_exit = abap_false.
    END-TEST-INJECTION.
    TEST-INJECTION exists_seam.
      lv_exists = 0.
    END-TEST-INJECTION.
    TEST-INJECTION create_view_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_seam.
      sy-subrc = 0.
    END-TEST-INJECTION.

    " Action
    DATA(lv_exit) = mo_cut->before_conversion( ).

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
    TEST-INJECTION exists_seam.
      lv_exists = 0.
    END-TEST-INJECTION.
    TEST-INJECTION create_view_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.
    TEST-INJECTION delete_view_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
    END-TEST-INJECTION.

    " Action
    DATA(lv_exit) = mo_cut->before_conversion( ).

    " Check results
    cl_abap_unit_assert=>assert_equals(
      exp = abap_true
      act = lv_exit
    ).
  ENDMETHOD.

  METHOD after_conversion_success.
    " Preparation: Test data
    TEST-INJECTION delete_view_seam.
      RAISE EXCEPTION TYPE cx_cfd_transport_adapter
        EXPORTING
          textid = cx_cfd_transport_adapter=>transport_object_not_supplied.
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