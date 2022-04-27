*&---------------------------------------------------------------------*
*& Include ZHCL_TEST_CLASS
*&---------------------------------------------------------------------*
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_check,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check.
    DATA: li_find TYPE STANDARD TABLE OF ty_check.
    TYPES: tt_mat TYPE STANDARD TABLE OF ty_check.

    METHODS: test_matnr_werks
      CHANGING li_test TYPE tt_mat.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD test_matnr_werks.
    SELECT matnr
      werks FROM marc
      INTO TABLE li_test.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_test DEFINITION FOR TESTING.
  PUBLIC SECTION.
    METHODS: test_matnr_werks FOR TESTING.
ENDCLASS.

CLASS lcl_test IMPLEMENTATION.
  METHOD test_matnr_werks.
    DATA: o_cut TYPE REF TO lcl_main.
    TYPES: BEGIN OF ty_check1,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check1.

    DATA : li_find TYPE STANDARD TABLE OF ty_check1,
           li_test TYPE STANDARD TABLE OF ty_check1.

    CREATE OBJECT o_cut.
    o_cut->test_matnr_werks( CHANGING li_test = li_find ).

    DATA: lw TYPE ty_check1.
    lw_matnr = '112'.
    lw_werks = '1110'.
    APPEND lw TO li_test.

    cl_abap_unit_assert=>assert_equals(
    exp = li_test
    act = li_find
    msg = 'Incorrect Data'
    ).
  ENDMETHOD.
ENDCLASS.