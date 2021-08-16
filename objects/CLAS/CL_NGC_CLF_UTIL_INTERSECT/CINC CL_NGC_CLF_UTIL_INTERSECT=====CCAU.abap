CLASS ltd_class DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_class.

    DATA:
      ms_header TYPE ngcs_class,
      mt_chars  TYPE ngct_characteristic_object.

    METHODS:
      constructor
        IMPORTING
          is_header TYPE ngcs_class
          it_chars  TYPE ngct_characteristic_object.
ENDCLASS.

CLASS ltd_class IMPLEMENTATION.

  METHOD constructor.

    ms_header = is_header.
    mt_chars  = it_chars.

  ENDMETHOD.

  METHOD if_ngc_class~get_header.

    rs_class_header = ms_header.

  ENDMETHOD.

  METHOD if_ngc_class~get_characteristics.

    et_characteristic = mt_chars.

  ENDMETHOD.

ENDCLASS.

CLASS ltd_char DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_ngc_characteristic.

    DATA:
      ms_header        TYPE ngcs_characteristic,
      mt_domain_values TYPE ngct_characteristic_value.

    METHODS:
      constructor
        IMPORTING
          is_header        TYPE ngcs_characteristic
          it_domain_values TYPE ngct_characteristic_value.

ENDCLASS.

CLASS ltd_char IMPLEMENTATION.

  METHOD constructor.

    ms_header        = is_header.
    mt_domain_values = it_domain_values.

  ENDMETHOD.

  METHOD if_ngc_characteristic~get_header.

    rs_characteristic_header = ms_header.

  ENDMETHOD.

  METHOD if_ngc_characteristic~get_domain_values.

    et_domain_value = mt_domain_values.

  ENDMETHOD.

  METHOD if_ngc_characteristic~get_characteristic_ref.
  ENDMETHOD.

ENDCLASS.

CLASS lth_dom_val_tools_test_data DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS:
      class_constructor.

    CLASS-DATA:
      gt_classes TYPE ngct_class_object.

ENDCLASS.

CLASS lth_dom_val_tools_test_data IMPLEMENTATION.
  METHOD class_constructor.

    gt_classes = VALUE #(
      ( class_object = NEW ltd_class(
          is_header = VALUE #(
            classinternalid = '0000000001'
            classtype       = '001' )
          it_chars  = VALUE #(
            ( charcinternalid       = '0000000001'
            key_date              = '20170130'
            characteristic_object = NEW ltd_char(
              is_header = VALUE #( charcinternalid = '0000000001' key_date = '20170130' )
              it_domain_values = VALUE #(
                ( charcvalue = 'VALUE01' )
                ( charcvalue = 'VALUE02' ) ) ) ) ) ) )
      ( class_object = NEW ltd_class(
          is_header = VALUE #(
            classinternalid = '0000000002'
            classtype       = '001' )
          it_chars  = VALUE #(
            ( charcinternalid       = '0000000001'
            key_date              = '20170130'
            characteristic_object = NEW ltd_char(
              is_header = VALUE #( charcinternalid = '0000000001' key_date = '20170130' )
              it_domain_values = VALUE #(
                ( charcvalue = 'VALUE01' ) ) ) ) ) ) ) ).

  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_util_intersect DEFINITION DEFERRED.
CLASS cl_ngc_clf_util_intersect DEFINITION LOCAL FRIENDS ltc_ngc_clf_util_intersect.

CLASS ltc_ngc_clf_util_intersect DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_clf_util_intersect.  "class under test

    METHODS: setup.
    METHODS: get_charc_dom_vals FOR TESTING.
    METHODS: recalculate FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_clf_util_intersect IMPLEMENTATION.

  METHOD setup.

    DATA lo_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.

    mo_cut = NEW cl_ngc_clf_util_intersect( ).

    lo_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_util_intersect = lo_util_intersect.

  ENDMETHOD.

  METHOD get_charc_dom_vals.

    DATA ls_intersection TYPE ngcs_core_class_charc_inter.

    ls_intersection-charcinternalid = '0000000001'.
    ls_intersection-classtype       = '001'.
    ls_intersection-charc_values = VALUE #(
      ( charcvalue      = 'VALUE01' ) ).

    mo_cut->mt_recalc_classtype_range = VALUE #( ( sign   = if_ngc_core_c=>gc_range_sign-include
                                                   option = if_ngc_core_c=>gc_range_option-equals
                                                   low    = '001' ) ).

    cl_abap_testdouble=>configure_call( mo_cut->mo_util_intersect )->ignore_all_parameters( )->set_parameter(
      name  = 'es_collected_char_value'
      value = ls_intersection ).
    mo_cut->mo_util_intersect->calculate_intersection( iv_charcdatatype = '' it_collected_char_values = VALUE #( ) ).

    mo_cut->get_charc_and_dom_vals(
      EXPORTING
        iv_classtype          = '001'
        iv_charcinternalid    = '0000000001'
        is_classification_key = VALUE #( object_key = '' technical_object = '' change_number = '' key_date = sy-datum )
        it_classes            = lth_dom_val_tools_test_data=>gt_classes
      IMPORTING
        et_domain_values   = DATA(rt_domain_values) ).

    cl_abap_unit_assert=>assert_equals(
      act   = rt_domain_values
      exp   = VALUE ngct_characteristic_value(
        ( charcvalue = 'VALUE01' ) ) ).

  ENDMETHOD.

  METHOD recalculate.

    CLEAR: mo_cut->mt_recalc_classtype_range.

    " call recalculate twice, to see if it was inserted only once
    mo_cut->recalculate( '001' ).
    mo_cut->recalculate( '001' ).

    cl_abap_unit_assert=>assert_equals(
      act = lines( mo_cut->mt_recalc_classtype_range )
      exp = 1
      msg = 'One message expected' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_cut->mt_recalc_classtype_range
      exp = VALUE cl_ngc_clf_util_intersect=>tt_classtype_range( ( sign   = if_ngc_core_c=>gc_range_sign-include
                                                                   option = if_ngc_core_c=>gc_range_option-equals
                                                                   low    = '001' ) )
      msg = '001 expected' ).

  ENDMETHOD.




ENDCLASS.