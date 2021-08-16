CLASS lth_ngc_clf_val_external_check DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA:
      gs_characteristic_header TYPE ngcs_characteristic,
      gt_valuation_data        TYPE ngct_valuation_data.

    CLASS-METHODS:
      class_constructor.
ENDCLASS.

CLASS ltc_ngc_clf_val_external_check DEFINITION DEFERRED.
CLASS cl_ngc_clf_val_external_check DEFINITION LOCAL FRIENDS ltc_ngc_clf_val_external_check.

CLASS ltc_ngc_clf_val_external_check DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_external_check TYPE REF TO cl_ngc_clf_val_external_check.

    METHODS:
      setup,
      empty_clf_successful FOR TESTING,
      fm_check_exists FOR TESTING,
      fm_check_not_exists FOR TESTING,
      fm_not_exists FOR TESTING,
      chcktable_check_exists FOR TESTING,
      chcktable_check_not_exists FOR TESTING,
      selset_check_exists FOR TESTING,
      selset_check_not_exists FOR TESTING.

    METHODS:
      get_stubs
        IMPORTING
          is_char_header    TYPE ngcs_characteristic
        EXPORTING
          eo_data_provider  TYPE REF TO if_ngc_clf_validation_dp
          eo_classification TYPE REF TO if_ngc_classification.
ENDCLASS.



CLASS lth_ngc_clf_val_external_check IMPLEMENTATION.
  METHOD class_constructor.

    gs_characteristic_header = VALUE #(
      charcinternalid          = '0000000001'
      characteristic           = 'TEST_CHAR_01' ).

    gt_valuation_data = VALUE #(
      ( charcinternalid = '0000000001' charcvalue = 'VALUE 01' )
      ( charcinternalid = '0000000001' charcvalue = 'VALUE 02' ) ).

  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clf_val_external_check IMPLEMENTATION.

  METHOD setup.

    DATA: lo_checktable_stub TYPE REF TO if_ngc_core_chr_util_chcktable.

    mo_external_check = NEW #( ).

    lo_checktable_stub ?= cl_abap_testdouble=>create( 'if_ngc_core_chr_util_chcktable' ).
    mo_external_check->mo_chr_util_chcktable = lo_checktable_stub.

  ENDMETHOD.

  METHOD empty_clf_successful.

    DATA:
      lo_data_provider  TYPE REF TO if_ngc_clf_validation_dp,
      lo_classification TYPE REF TO if_ngc_classification.

*   Arrangements

    " Test doubles
    lo_data_provider  ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).
    lo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).

    " Pre-requisites
    cl_abap_testdouble=>configure_call( lo_data_provider )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    lo_data_provider->update_assigned_values( VALUE #( ) ).

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD fm_check_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charccheckfunctionmodule = 'FM_TEST_01'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->update_assigned_values(
      it_values = VALUE #(
        ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 01' charcvaluenew = 'VALUE 01 UPDATED' )
        ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 02' charcvaluenew = 'VALUE 02 UPDATED' ) ) ).

    " Test injection
    TEST-INJECTION fm_function_exists.
    END-TEST-INJECTION.

    TEST-INJECTION call_function_dynamic.
      sy-subrc = 0.
      lv_new_charcvalue = iv_charcvalue && ' UPDATED'.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'No messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD fm_check_not_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charccheckfunctionmodule = 'FM_TEST_01'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->update_assigned_values( VALUE #(
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 02' charcvaluenew = 'VALUE 02 UPDATED' ) ) ).

    " Test injection
    TEST-INJECTION fm_function_exists.
    END-TEST-INJECTION.

    TEST-INJECTION call_function_dynamic.
      IF iv_charcvalue = 'VALUE 01'.
        sy-subrc = 1.
      ELSE.
        sy-subrc = 0.
        lv_new_charcvalue = iv_charcvalue && ' UPDATED'.
      ENDIF.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    DATA(lt_messages) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_messages )
      exp = 1
      msg = 'Messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD fm_not_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charccheckfunctionmodule = 'FM_TEST_01'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    lo_data_provider->update_assigned_values( VALUE #( ) ).

    " Test injection
    TEST-INJECTION fm_function_exists.
      sy-subrc = 1.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    DATA(lt_messages) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_messages )
      exp = 2
      msg = 'Messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD chcktable_check_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charcchecktable          = 'CHECKTABLE'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->update_assigned_values( VALUE #(
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 01' charcvaluenew = 'VALUE 01' )
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 02' charcvaluenew = 'VALUE 02' ) ) ).

    " Test injection
    TEST-INJECTION select_dynamic.
      sy-subrc = 0.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'Messages should not be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD chcktable_check_not_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charcchecktable          = 'CHECKTABLE'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->update_assigned_values( VALUE #(
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 02' charcvaluenew = 'VALUE 02' ) ) ).

    " Test injection
    TEST-INJECTION select_dynamic.
      IF lt_where_conditions[ 1 ] CS 'VALUE 01'.
        sy-subrc = 4.
      ELSE.
        sy-subrc = 0.
      ENDIF.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    DATA(lt_messages) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_messages )
      exp = 1
      msg = 'Messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD selset_check_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charcselectedset         = 'SELSET'.
    ls_char_header-plant                    = 'PLANT'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->update_assigned_values( VALUE #(
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 01' charcvaluenew = 'VALUE    03' )
      ( charcinternalid = '000000001' classtype = '001' charcvalueold = 'VALUE 02' charcvaluenew = 'VALUE    03' ) ) ).

    " Test injection
    TEST-INJECTION fm_code_pickup.
      sy-subrc  = 0.
      lv_qpk1ac = VALUE #( codegruppe = 'VALUE' code = '03' ).
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    cl_abap_unit_assert=>assert_initial(
      act = lo_result->get_messages( )
      msg = 'Messages should not be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD selset_check_not_exists.

*   Arrangements

    " Test doubles
    DATA(ls_char_header) = lth_ngc_clf_val_external_check=>gs_characteristic_header.
    ls_char_header-charcdatatype            = if_ngc_c=>gc_charcdatatype-char.
    ls_char_header-charcselectedset         = 'SELSET'.
    ls_char_header-plant                    = 'PLANT'.
    ls_char_header-valueiscasesensitive     = abap_true.

    get_stubs(
      EXPORTING
        is_char_header = ls_char_header
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->ignore_all_parameters( )->and_expect( )->is_never_called( ).
    lo_data_provider->update_assigned_values( VALUE #( ) ).

    " Test injection
    TEST-INJECTION fm_code_pickup.
      sy-subrc  = 1.
    END-TEST-INJECTION.

*   Actions
    DATA(lo_result) = mo_external_check->if_ngc_clf_validator~validate(
      iv_classtype      = '001'
      io_classification = lo_classification
      io_data_provider  = lo_data_provider ).

*   Assertions
    DATA(lt_messages) = lo_result->get_messages( ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_messages )
      exp = 2
      msg = 'Messages should be returned' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.


  METHOD get_stubs.

    DATA lo_characteristic TYPE REF TO if_ngc_characteristic.

    eo_data_provider  ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).
    eo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).
    lo_characteristic ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).

    cl_abap_testdouble=>configure_call( lo_characteristic )->returning( is_char_header ).
    lo_characteristic->get_header( ).

    cl_abap_testdouble=>configure_call( eo_classification )->set_parameter(
      name = 'et_valuation_data'
      value = lth_ngc_clf_val_external_check=>gt_valuation_data ).
    eo_classification->get_assigned_values( ).

    cl_abap_testdouble=>configure_call( eo_classification )->set_parameter(
      name = 'et_characteristic'
      value = VALUE ngct_clf_characteristic_object(
        ( charcinternalid       = '0000000001'
          characteristic_object = lo_characteristic ) ) ).
    eo_classification->get_characteristics( ).

    cl_abap_testdouble=>configure_call( eo_classification )->returning( VALUE ngcs_classification_key( ) ).
    eo_classification->get_classification_key( ).

  ENDMETHOD.

ENDCLASS.