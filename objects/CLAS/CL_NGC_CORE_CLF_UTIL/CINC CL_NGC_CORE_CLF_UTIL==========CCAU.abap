CLASS ltc_ngc_core_clf_util DEFINITION DEFERRED.
CLASS cl_ngc_core_clf_util DEFINITION LOCAL FRIENDS ltc_ngc_core_clf_util.

CLASS ltc_ngc_core_clf_util DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_core_clf_util.  "class under test

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_clf_statuses FOR TESTING.
    METHODS: get_clf_status_descr_released FOR TESTING.
    METHODS: get_clf_status_descr_locked FOR TESTING.
    METHODS: get_clf_status_descr_inc_sys FOR TESTING.
    METHODS: get_clf_status_descr_inc_man FOR TESTING.
    METHODS: get_next_cuobj_from_nr FOR TESTING.
    METHODS: test_injection_select_tclc.
ENDCLASS.       "ltc_Ngc_Core_Clf_Util


CLASS ltc_ngc_core_clf_util IMPLEMENTATION.

  METHOD class_setup.



  ENDMETHOD.


  METHOD class_teardown.
  ENDMETHOD.


  METHOD setup.

    mo_cut = NEW #( ).

  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD get_clf_statuses.

    test_injection_select_tclc( ).

    DATA(lt_classification_statuses_exp) = VALUE ngct_core_classification_stat( ( mandt     = sy-mandt
                                                                                  klart     = '001'
                                                                                  statu     = '1'
                                                                                  frei      = 'X' )
                                                                                ( mandt     = sy-mandt
                                                                                  klart     = '001'
                                                                                  statu     = '2'
                                                                                  gesperrt  = 'X' )
                                                                                ( mandt     = sy-mandt
                                                                                  klart     = '001'
                                                                                  statu     = '3'
                                                                                  unvollstm = 'X' )
                                                                                ( mandt     = sy-mandt
                                                                                  klart     = '001'
                                                                                  statu     = '4'
                                                                                  unvollsts = 'X' ) ).

    DATA(lt_classification_statuses_act) = mo_cut->if_ngc_core_clf_util~get_clf_statuses( '001' ).

    cl_abap_unit_assert=>assert_equals( act = lt_classification_statuses_act
                                        exp = lt_classification_statuses_act
                                        msg = 'Unexpected classification status has been returned' ).

  ENDMETHOD.


  METHOD get_clf_status_descr_released.

    test_injection_select_tclc( ).

    DATA(lv_clfnstatusdescription) = mo_cut->if_ngc_core_clf_util~get_clf_status_description( iv_classtype  = '001'
                                                                                       iv_clfnstatus = '1' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_clfnstatusdescription
      exp = 'Released'
      msg = 'Unexpected status description returned' ).

  ENDMETHOD.


  METHOD get_clf_status_descr_locked.

    DATA(lv_clfnstatusdescription) = mo_cut->if_ngc_core_clf_util~get_clf_status_description( iv_classtype  = '001'
                                                                                 iv_clfnstatus = '2' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_clfnstatusdescription
      exp = 'Locked'
      msg = 'Unexpected status description returned' ).

  ENDMETHOD.


  METHOD get_clf_status_descr_inc_man.

    test_injection_select_tclc( ).

    DATA(lv_clfnstatusdescription) = mo_cut->if_ngc_core_clf_util~get_clf_status_description( iv_classtype  = '001'
                                                                                 iv_clfnstatus = '3' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_clfnstatusdescription
      exp = 'Incomplete'
      msg = 'Unexpected status description returned' ).

  ENDMETHOD.


  METHOD get_clf_status_descr_inc_sys.

    test_injection_select_tclc( ).

    DATA(lv_clfnstatusdescription) = mo_cut->if_ngc_core_clf_util~get_clf_status_description( iv_classtype  = '001'
                                                                                 iv_clfnstatus = '4' ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_clfnstatusdescription
      exp = 'Incomplete System'
      msg = 'Unexpected status description returned' ).

  ENDMETHOD.


  METHOD get_next_cuobj_from_nr.

    test_injection_select_tclc( ).

    TEST-INJECTION cuobj_get_next_with_nr.
      sy-subrc = 0.
      rv_cuobj = 1.
    END-TEST-INJECTION.

    DATA(lv_cuobj) = mo_cut->if_ngc_core_clf_util~get_next_cuobj_from_nr(  ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_cuobj
      exp = '1'
      msg = 'Unexpected CUOBJ value was returned' ).

  ENDMETHOD.


  METHOD test_injection_select_tclc.
    TEST-INJECTION select_from_tclc.
      DATA(ls_tclc) = VALUE tclc( mandt = sy-mandt
                                  klart = '001'
                                  statu = '1'
                                  frei  = 'X' ).
      APPEND ls_tclc TO lt_tclc.
      CLEAR: ls_tclc.
      ls_tclc = VALUE tclc( mandt    = sy-mandt
                            klart    = '001'
                            statu    = '2'
                            gesperrt = 'X' ).
      APPEND ls_tclc TO lt_tclc.
      CLEAR: ls_tclc.
      ls_tclc = VALUE tclc( mandt     = sy-mandt
                            klart     = '001'
                            statu     = '3'
                            unvollstm = 'X' ).
      APPEND ls_tclc TO lt_tclc.
      CLEAR: ls_tclc.
      ls_tclc = VALUE tclc( mandt     = sy-mandt
                            klart     = '001'
                            statu     = '4'
                            unvollsts = 'X' ).
      APPEND ls_tclc TO lt_tclc.
    END-TEST-INJECTION.
  ENDMETHOD.

ENDCLASS.