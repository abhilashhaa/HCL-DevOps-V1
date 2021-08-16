CLASS lth_ngc_clf_val_value_overlap DEFINITION.
  PUBLIC SECTION.
    CLASS-DATA:
      gs_char_header_1 TYPE ngcs_characteristic,
      gs_char_header_2 TYPE ngcs_characteristic,
      gs_char_header_3 TYPE ngcs_characteristic.

    CLASS-METHODS:
      class_constructor.
ENDCLASS.

CLASS ltc_ngc_clf_val_value_overlap DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_value_overlap TYPE REF TO cl_ngc_clf_val_value_overlap.

    METHODS:
      setup,
      overlap_check_successful FOR TESTING,
      overlap_using_single_relaiton FOR TESTING.

    METHODS:
      get_stubs
        IMPORTING
          it_valuation      TYPE ngct_valuation_data_upd
        EXPORTING
          eo_data_provider  TYPE REF TO if_ngc_clf_validation_dp
          eo_classification TYPE REF TO if_ngc_classification.

ENDCLASS.



CLASS lth_ngc_clf_val_value_overlap IMPLEMENTATION.
  METHOD class_constructor.

    gs_char_header_1 = VALUE #(
      charcinternalid          = '0000000001'
      characteristic           = 'TEST_CHAR_01'
      charcdatatype            = if_ngc_c=>gc_charcdatatype-num
      valueintervalisallowed   = abap_true
      multiplevaluesareallowed = abap_true ).

    gs_char_header_2 = VALUE #(
      charcinternalid          = '0000000002'
      characteristic           = 'TEST_CHAR_02'
      charcdatatype            = if_ngc_c=>gc_charcdatatype-char ).

    gs_char_header_3 = VALUE #(
      charcinternalid          = '0000000003'
      characteristic           = 'TEST_CHAR_03'
      charcdatatype            = if_ngc_c=>gc_charcdatatype-num
      valueintervalisallowed   = abap_true
      multiplevaluesareallowed = abap_true ).

  ENDMETHOD.
ENDCLASS.

CLASS ltc_ngc_clf_val_value_overlap IMPLEMENTATION.

  METHOD setup.

    mo_value_overlap = NEW #( ).

  ENDMETHOD.

  METHOD overlap_check_successful.

*   Arrangements
    get_stubs(
      EXPORTING
        it_valuation      = VALUE #(
          ( charcinternalid       = '0000000001'
            charcfromnumericvalue = 200
            charctonumericvalue   = 600
            charcvaluedependency  = 3
            object_state          = if_ngc_c=>gc_object_state-created )
          ( charcinternalid       = '0000000001'
            charcfromnumericvalue = 300
            charctonumericvalue   = 500
            charcvaluedependency  = 3
            object_state          = if_ngc_c=>gc_object_state-loaded )
          ( charcinternalid       = '0000000001'
            charcfromnumericvalue = 100
            charctonumericvalue   = 200
            charcvaluedependency  = 3
            object_state          = if_ngc_c=>gc_object_state-updated )
          ( charcinternalid       = '0000000002'
            charcvalue            = 'VALUE'
            object_state          = if_ngc_c=>gc_object_state-loaded )
          ( charcinternalid       = '0000000003'
            charcfromnumericvalue = 200
            charcvaluedependency  = 1
            object_state          = if_ngc_c=>gc_object_state-loaded )
          ( charcinternalid       = '0000000003'
            charcfromnumericvalue = 100
            charcvaluedependency  = 1
            object_state          = if_ngc_c=>gc_object_state-created ) )
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->set_updated_data(
      it_assigned_values = VALUE #(
        ( charcinternalid       = '0000000001'
          charcfromnumericvalue = 300
          charctonumericvalue   = 500
          charcvaluedependency  = 3
          object_state          = if_ngc_c=>gc_object_state-deleted )
        ( charcinternalid       = '0000000001'
          charcfromnumericvalue = 200
          charctonumericvalue   = 600
          charcvaluedependency  = 3
          object_state          = if_ngc_c=>gc_object_state-created )
        ( charcinternalid       = '0000000001'
          charcfromnumericvalue = 100
          charctonumericvalue   = 200
          charcvaluedependency  = 3
          object_state          = if_ngc_c=>gc_object_state-updated )
        ( charcinternalid       = '0000000002'
          charcvalue            = 'VALUE'
          object_state          = if_ngc_c=>gc_object_state-loaded )
        ( charcinternalid       = '0000000003'
          charcfromnumericvalue = 200
          charcvaluedependency  = 1
          object_state          = if_ngc_c=>gc_object_state-loaded )
        ( charcinternalid       = '0000000003'
          charcfromnumericvalue = 100
          charcvaluedependency  = 1
          object_state          = if_ngc_c=>gc_object_state-created ) ) ).

*   Actions
    DATA(lo_result) = mo_value_overlap->if_ngc_clf_validator~validate(
      EXPORTING
        io_classification = lo_classification
        io_data_provider  = lo_data_provider
        iv_classtype      = '001' ).

*   Assertions
    cl_abap_unit_assert=>assert_equals(
      act = lines( lo_result->get_messages( ) )
      exp = 1
      msg = 'One message is expected' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.

  METHOD overlap_using_single_relaiton.

*   Arrangements
    get_stubs(
      EXPORTING
        it_valuation      = VALUE #(
          ( charcinternalid       = '0000000001'
            charctonumericvalue   = 400
            charcvaluedependency  = 6
            object_state          = if_ngc_c=>gc_object_state-created )
          ( charcinternalid       = '0000000001'
            charctonumericvalue   = 300
            charcvaluedependency  = 7
            object_state          = if_ngc_c=>gc_object_state-loaded )
          ( charcinternalid       = '0000000001'
            charcfromnumericvalue = 600
            charcvaluedependency  = 8
            object_state          = if_ngc_c=>gc_object_state-updated )
          ( charcinternalid       = '0000000001'
            charcfromnumericvalue = 500
            charcvaluedependency  = 9
            object_state          = if_ngc_c=>gc_object_state-updated ) )
      IMPORTING
        eo_classification = DATA(lo_classification)
        eo_data_provider  = DATA(lo_data_provider) ).

    cl_abap_testdouble=>configure_call( lo_data_provider )->and_expect( )->is_called_once( ).
    lo_data_provider->set_updated_data(
      it_assigned_values = VALUE #(
        ( charcinternalid       = '0000000001'
          charctonumericvalue   = 300
          charcvaluedependency  = 7
          object_state          = if_ngc_c=>gc_object_state-deleted )
        ( charcinternalid       = '0000000001'
          charctonumericvalue   = 400
          charcvaluedependency  = 6
          object_state          = if_ngc_c=>gc_object_state-created )
        ( charcinternalid       = '0000000001'
          charcfromnumericvalue = 600
          charcvaluedependency  = 8
          object_state          = if_ngc_c=>gc_object_state-deleted )
        ( charcinternalid       = '0000000001'
          charcfromnumericvalue = 500
          charcvaluedependency  = 9
          object_state          = if_ngc_c=>gc_object_state-updated ) ) ).

*   Actions
    DATA(lo_result) = mo_value_overlap->if_ngc_clf_validator~validate(
      EXPORTING
        io_classification = lo_classification
        io_data_provider  = lo_data_provider
        iv_classtype      = '001' ).

*   Assertions
    cl_abap_unit_assert=>assert_equals(
      act = lines( lo_result->get_messages( ) )
      exp = 1
      msg = 'One message is expected' ).

    cl_abap_testdouble=>verify_expectations( lo_data_provider ).

  ENDMETHOD.


  METHOD get_stubs.

    DATA lo_characteristic TYPE REF TO if_ngc_characteristic.

    eo_data_provider  ?= cl_abap_testdouble=>create( 'if_ngc_clf_validation_dp' ).
    eo_classification ?= cl_abap_testdouble=>create( 'if_ngc_classification' ).
    lo_characteristic ?= cl_abap_testdouble=>create( 'if_ngc_characteristic' ).

    cl_abap_testdouble=>configure_call( lo_characteristic )->times( 1 )->returning( lth_ngc_clf_val_value_overlap=>gs_char_header_1 ).
    lo_characteristic->get_header( ).

    cl_abap_testdouble=>configure_call( lo_characteristic )->times( 2 )->returning( lth_ngc_clf_val_value_overlap=>gs_char_header_2 ).
    lo_characteristic->get_header( ).

    cl_abap_testdouble=>configure_call( lo_characteristic )->times( 3 )->returning( lth_ngc_clf_val_value_overlap=>gs_char_header_3 ).
    lo_characteristic->get_header( ).

    cl_abap_testdouble=>configure_call( eo_classification )->set_parameter(
      name = 'et_valuation_data_upd'
      value = it_valuation ).
    eo_classification->get_updated_data( ).

    cl_abap_testdouble=>configure_call( eo_classification )->set_parameter(
      name = 'et_characteristic'
      value = VALUE ngct_clf_characteristic_object(
        ( charcinternalid       = '0000000001'
          characteristic_object = lo_characteristic )
        ( charcinternalid       = '0000000002'
          characteristic_object = lo_characteristic )
        ( charcinternalid       = '0000000003'
          characteristic_object = lo_characteristic ) ) ).
    eo_classification->get_characteristics( ).

    cl_abap_testdouble=>configure_call( eo_classification )->returning( VALUE ngcs_classification_key( ) ).
    eo_classification->get_classification_key( ).

  ENDMETHOD.

ENDCLASS.