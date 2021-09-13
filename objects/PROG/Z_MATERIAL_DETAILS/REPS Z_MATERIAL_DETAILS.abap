*&---------------------------------------------------------------------*
*& Report Z_MATERIAL_DETAILS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_material_details.
*&---------------------------------------------------------------------*
*& Include Z_MATERIAL_DETAILS
*&---------------------------------------------------------------------*

PARAMETERS p_matnr TYPE matnr.
CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    TYPES: BEGIN OF ty_check,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check.
    DATA: li_find TYPE STANDARD TABLE OF ty_check.
    TYPES: tt_mat TYPE STANDARD TABLE OF ty_check.

    METHODS: lm_matnr_werks
      CHANGING li_mat TYPE tt_mat.
ENDCLASS.

CLASS lcl_main IMPLEMENTATION.
  METHOD lm_matnr_werks.
    DATA: lv_matnr TYPE matnr VALUE 'RM02',
          lv_werks TYPE werks_d VALUE '1110'.
    SELECT matnr,
      werks FROM marc
      WHERE matnr = @lv_matnr
      AND werks = @lv_werks
      INTO TABLE @li_mat.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_mat DEFINITION FOR TESTING.
  "#AU Risk_Level Harmless
  "#AU Duration Short
  PUBLIC SECTION.
    METHODS: lm_matnr_werks FOR TESTING.
ENDCLASS.

CLASS lcl_mat IMPLEMENTATION.
  METHOD lm_matnr_werks.
    DATA: o_cut TYPE REF TO lcl_main.
    DATA: lv_matnr TYPE matnr VALUE 'RM02',
          lv_werks TYPE werks_d VALUE '1110'.
    TYPES: BEGIN OF ty_check1,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check1.

    DATA : li_find TYPE STANDARD TABLE OF ty_check1,
           li_mat  TYPE STANDARD TABLE OF ty_check1.

    CREATE OBJECT o_cut.
    o_cut->lm_matnr_werks( CHANGING li_mat = li_find ).

    DATA: lw TYPE ty_check1.
    lw-matnr = lv_matnr.
    lw-werks = lv_werks.
    APPEND lw TO li_mat.

    cl_aunit_assert=>assert_equals(
    exp = li_mat
    act = li_find
    msg = 'Incorrect Material Details'
    ).
  ENDMETHOD.
ENDCLASS.