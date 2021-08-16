CLASS ltd_core_util DEFINITION FOR TESTING FINAL.
  PUBLIC SECTION.
    INTERFACES: if_ngc_core_util PARTIALLY IMPLEMENTED.
  PRIVATE SECTION.
ENDCLASS.

CLASS ltd_core_util IMPLEMENTATION.
  METHOD if_ngc_core_util~ctcv_syntax_check.
    DATA(lv_string) = string.
    IF lowercase = abap_false.
      TRANSLATE lv_string TO UPPER CASE.
    ENDIF.
    APPEND VALUE #( atwrt = lv_string atcod = 1 atinp = string ) TO tstrg.
  ENDMETHOD.
  METHOD if_ngc_core_util~get_number_separator_signs.
    ev_decimal_sign = ','.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_test DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_char DEFINITION LOCAL FRIENDS ltc_test.

CLASS ltc_test DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_char.

    METHODS:
      setup.

    METHODS:
      case_sensitive          FOR TESTING RAISING cx_ngc_core_chr_exception,
      case_insensitive          FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_test IMPLEMENTATION.

  METHOD setup.
    mo_cut ?= cl_ngc_core_chr_check_char=>get_instance( ).
    CREATE OBJECT mo_cut->mo_core_util TYPE ltd_core_util.
  ENDMETHOD.

  METHOD case_sensitive.

    DATA:
      ls_change_value     TYPE ngcs_core_charc_value,
      ls_change_value_exp TYPE ngcs_core_charc_value.

    ls_change_value-charcvalue = 'abcd'.
    ls_change_value-charcvaluedependency = '1'.
    ls_change_value_exp = ls_change_value.

    TRY.
        mo_cut->if_ngc_core_chr_value_check~check_value(
          EXPORTING
            is_charc_header = VALUE #( valueiscasesensitive = abap_true charcdatatype = 'CHAR' )
          IMPORTING
            et_message      = DATA(lt_message)
          CHANGING
            cs_charc_value  = ls_change_value
        ).
      CATCH cx_ngc_core_chr_exception.
        cl_abap_unit_assert=>fail( msg = 'Exception should not be raised' ).
    ENDTRY.

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No message should be returned'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_change_value
      exp = ls_change_value_exp
      msg = 'CS_CHARC_VALUE should not be changed'
    ).

  ENDMETHOD.

  METHOD case_insensitive.

    DATA:
      ls_change_value     TYPE ngcs_core_charc_value,
      ls_change_value_exp TYPE ngcs_core_charc_value.

    ls_change_value-charcvalue = 'abcd'.
    ls_change_value-charcvaluedependency = '1'.
    ls_change_value_exp = ls_change_value.
    TRANSLATE ls_change_value_exp-charcvalue TO UPPER CASE.

    TRY.
        mo_cut->if_ngc_core_chr_value_check~check_value(
          EXPORTING
            is_charc_header = VALUE #( valueiscasesensitive = abap_false charcdatatype = 'CHAR' )
          IMPORTING
            et_message      = DATA(lt_message)
          CHANGING
            cs_charc_value  = ls_change_value
        ).
      CATCH cx_ngc_core_chr_exception.
        cl_abap_unit_assert=>fail( msg = 'Exception should not be raised' ).
    ENDTRY.

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No message should be returned'
    ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_change_value
      exp = ls_change_value_exp
      msg = 'CS_CHARC_VALUE-CHARCVALUE should be uppercase'
    ).

  ENDMETHOD.

ENDCLASS.