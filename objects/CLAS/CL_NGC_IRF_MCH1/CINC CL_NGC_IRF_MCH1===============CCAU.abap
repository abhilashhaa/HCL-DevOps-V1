*"* use this source file for your ABAP unit test classes
CLASS ltc_irf DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    DATA cut TYPE REF TO if_dtinf_read_api_ext.
    METHODS setup.
    METHODS check_sec_tab FOR TESTING.

ENDCLASS.

CLASS ltc_irf IMPLEMENTATION.
  METHOD setup.
    cut = NEW cl_ngc_irf_mch1( ).
  ENDMETHOD.
  METHOD check_sec_tab.
    DATA lt_read_api_ext TYPE dtinf_tt_badi_fm_rfc.
    cut->get( CHANGING ct_read_api_ext = lt_read_api_ext ).

    cl_abap_unit_assert=>assert_not_initial( lt_read_api_ext ).

    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 1 ]-prim_tab
                                        exp = 'MCH1' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 1 ]-prim_field
                                        exp = 'MATNR' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 1 ]-sec_tab
                                        exp = 'AUSP' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 1 ]-sec_field
                                        exp = 'OBJEK' ).

    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 2 ]-prim_tab
                                        exp = 'MCH1' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 2 ]-prim_field
                                        exp = 'CHARG' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 2 ]-sec_tab
                                        exp = 'AUSP' ).
    cl_abap_unit_assert=>assert_equals( act = lt_read_api_ext[ 2 ]-sec_field
                                        exp = 'OBJEK' ).

    CALL FUNCTION 'FUNCTION_EXISTS'
      EXPORTING
        funcname = lt_read_api_ext[ 1 ]-function_module
      EXCEPTIONS
        OTHERS   = 2.
    cl_abap_unit_assert=>assert_subrc( msg = 'Function module does not exist' ).

  ENDMETHOD.
ENDCLASS.