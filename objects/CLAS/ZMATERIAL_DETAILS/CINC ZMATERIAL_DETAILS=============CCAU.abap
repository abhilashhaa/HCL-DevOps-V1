*"* use this source file for your ABAP unit test classes
CLASS lcl_mat DEFINITION FOR TESTING.
  "#AU Risk_Level Harmless
  "#AU Duration Short
  PUBLIC SECTION.
    METHODS: matnr_werks FOR TESTING.
  PRIVATE SECTION.
    METHODS: setup.
    METHODS: teardown.
ENDCLASS.

CLASS lcl_mat IMPLEMENTATION.
  METHOD matnr_werks.
*    DATA: o_cut TYPE REF TO lcl_main.
    DATA: lv_matnr TYPE matnr VALUE 'RM04',
          lv_werks TYPE werks_d VALUE '1111'.
    TYPES: BEGIN OF ty_check1,
             matnr TYPE matnr,
             werks TYPE werks_d,
           END OF ty_check1.

    DATA : li_find TYPE STANDARD TABLE OF ty_check1,
           li_mat  TYPE STANDARD TABLE OF ty_check1.

*    CREATE OBJECT o_cut.
    zmaterial_details=>matnr_werks( CHANGING li_mat = li_find ).

    DATA: lw TYPE ty_check1.
*    **Comment
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