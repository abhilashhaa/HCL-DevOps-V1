*"* use this source file for your ABAP unit test classes


CLASS ltc_ngc_core_cls_util DEFINITION FOR TESTING DURATION SHORT RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CONSTANTS:

      gc_date_initial    TYPE dats VALUE cl_ngc_core_cls_util=>gc_date_initial,
      gc_date_jan_16     TYPE dats VALUE '20160101',
      gc_date_feb_16     TYPE dats VALUE '20160201',
      gc_date_mar_16     TYPE dats VALUE '20160301',
      gc_date_apr_16     TYPE dats VALUE '20160401',
      gc_date_may_16     TYPE dats VALUE '20160501',
      gc_date_jun_16     TYPE dats VALUE '20160601',
      gc_date_jul_16     TYPE dats VALUE '20160701',
      gc_date_aug_16     TYPE dats VALUE '20160801',
      gc_date_sep_16     TYPE dats VALUE '20160901',
      gc_date_oct_16     TYPE dats VALUE '20161001',
      gc_date_nov_16     TYPE dats VALUE '20161101',
      gc_date_dec_16     TYPE dats VALUE '20161201',
      gc_date_mar_16_end TYPE dats VALUE '20160331',
      gc_date_apr_16_end TYPE dats VALUE '20160430',
      gc_date_infinite   TYPE dats VALUE cl_ngc_core_cls_util=>gc_date_infinite.

    METHODS:
      test_check_overlap FOR TESTING,
      test_maximum_date FOR TESTING,
      test_minimum_date FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_core_cls_util IMPLEMENTATION.

  METHOD test_check_overlap .

    "APR-JUN MAY-OCT -> true
    cl_abap_unit_assert=>assert_true(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_may_16
        iv_valid_to2   = gc_date_oct_16 )
    ).

    "APR-JUN JAN-MAY -> true
    cl_abap_unit_assert=>assert_true(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_jan_16
        iv_valid_to2   = gc_date_may_16 )
    ).

    "APR-JUN APR-APR_END -> true
    cl_abap_unit_assert=>assert_true(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_apr_16
        iv_valid_to2   = gc_date_apr_16_end )
    ).

    "APR-JUN SEP-OCT -> false
    cl_abap_unit_assert=>assert_false(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_sep_16
        iv_valid_to2   = gc_date_oct_16 )
    ).

    "APR-JUN JAN-MAR_END -> false
    cl_abap_unit_assert=>assert_false(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_jan_16
        iv_valid_to2   = gc_date_mar_16_end )
    ).

    "APR-JUN JAN-APR -> true
    cl_abap_unit_assert=>assert_true(
      cl_ngc_core_cls_util=>check_overlap(
        iv_valid_from1 = gc_date_apr_16
        iv_valid_to1   = gc_date_jun_16
        iv_valid_from2 = gc_date_jan_16
        iv_valid_to2   = gc_date_apr_16 )
    ).

  ENDMETHOD.

  METHOD test_minimum_date .
    cl_abap_unit_assert=>assert_equals(
      exp = gc_date_jan_16
      act = cl_ngc_core_cls_util=>minimum_date(
        iv_date1 = gc_date_jan_16
        iv_date2 = gc_date_feb_16
        iv_date3 = gc_date_mar_16  )
    ).

    cl_abap_unit_assert=>assert_equals(
      exp = cl_ngc_core_cls_util=>gc_date_initial
      act = cl_ngc_core_cls_util=>minimum_date(
        iv_date1 = gc_date_jan_16
        iv_date2 = cl_ngc_core_cls_util=>gc_date_initial
        iv_date3 = gc_date_mar_16  )
    ).

  ENDMETHOD.


  METHOD test_maximum_date .
    cl_abap_unit_assert=>assert_equals( exp = gc_date_mar_16
        act = cl_ngc_core_cls_util=>maximum_date(
        iv_date1 = gc_date_jan_16
        iv_date2 = gc_date_feb_16
        iv_date3 = gc_date_mar_16  ) ).

    cl_abap_unit_assert=>assert_equals(
      exp = cl_ngc_core_cls_util=>gc_date_infinite
      act = cl_ngc_core_cls_util=>maximum_date(
        iv_date1 = cl_ngc_core_cls_util=>gc_date_infinite
        iv_date2 = cl_ngc_core_cls_util=>gc_date_initial
        iv_date3 = gc_date_mar_16  )
     ).

  ENDMETHOD.


ENDCLASS.