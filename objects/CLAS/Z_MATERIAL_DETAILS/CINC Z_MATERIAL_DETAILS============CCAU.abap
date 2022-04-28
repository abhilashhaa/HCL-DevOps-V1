*"* use this source file for your ABAP unit test classes
class lcl_mat definition for testing.
  "#AU Risk_Level Harmless
  "#AU Duration Short
  public section.
    methods: matnr_werks for testing.
  private section.
    methods: setup.
    methods: teardown.
endclass.

class lcl_mat implementation.
  method matnr_werks.
*    DATA: o_cut TYPE REF TO lcl_main.
    data: lv_matnr type matnr value 'RM02',
          lv_werks type werks_d value '1110'.
    types: begin of ty_check1,
             matnr type matnr,
             werks type werks_d,
           end of ty_check1.

    data : li_find type standard table of ty_check1,
           li_mat  type standard table of ty_check1.
*
**    CREATE OBJECT o_cut.
    zmaterial_details=>matnr_werks( changing li_mat = li_find ).
*
    data: lw type ty_check1.
*    **Comment
*    CLEAR: li_mat.
    lw-matnr = lv_matnr.
    lw-werks = lv_werks.
    append lw to li_MAT.


    cl_abap_unit_assert=>assert_equals(
    exp = li_mat
    act = li_find
    msg = 'Incorrect Material Details'
    ).
  endmethod.

  method setup.
  endmethod.

  method teardown.
  endmethod.
endclass.