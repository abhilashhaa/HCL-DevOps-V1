*&---------------------------------------------------------------------*
*& Report Z_MATERIAL_DETAILS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_material_details_new.
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
          lv_werks TYPE werks_d VALUE '1100'.
    SELECT matnr,
      werks FROM marc
      WHERE matnr = @lv_matnr
      AND werks = @lv_werks
      INTO TABLE @li_mat.
  ENDMETHOD.
ENDCLASS.

CLASS lcl_mat DEFINITION FOR TESTING
  risk level harmless
  duration short.
  PUBLIC SECTION.
    METHODS: lm_matnr_werks FOR TESTING.
  PRIVATE SECTION.
    METHODS: setup.
    METHODS: teardown.
ENDCLASS.

CLASS lcl_mat IMPLEMENTATION.
  METHOD lm_matnr_werks.
    DATA: o_cut TYPE REF TO lcl_main.
    DATA: lv_matnr TYPE matnr VALUE 'RM04',
          lv_werks TYPE werks_d VALUE '1100'.
    TYPES: BEGIN OF ty_check1,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check1.

    DATA : li_find TYPE STANDARD TABLE OF ty_check1,
           li_mat  TYPE STANDARD TABLE OF ty_check1.

    CREATE OBJECT o_cut.
    o_cut->lm_matnr_werks( CHANGING li_mat = li_find ).

    DATA: lw TYPE ty_check1.
*    CLEAR: li_mat.
    lw-matnr = lv_matnr.
    lw-werks = lv_werks.
    APPEND lw TO li_mat.


    cl_abap_unit_assert=>assert_equals(
    exp = li_mat
    act = li_find
    msg = 'Incorrect Material Details'
    ).
  ENDMETHOD.

  METHOD setup.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.
ENDCLASS.