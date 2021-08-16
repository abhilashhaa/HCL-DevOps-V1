CLASS ltc_ngc_chd DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.

    DATA: cut TYPE REF TO if_cd_processing.

    METHODS: setup.
    METHODS: test_methods FOR TESTING.

ENDCLASS.

CLASS ltc_ngc_chd IMPLEMENTATION.

  METHOD setup.
    cut = NEW cl_ngc_chd( ).
  ENDMETHOD.

  METHOD test_methods.

    DATA: lt_objectclass TYPE cdobjectcl_range_tab.

    DATA(lv_is_authorized) = cut->check_authorization( it_object_id = VALUE #( ( ) ) ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lv_is_authorized
        msg              = 'lv_is_authorized: initial value was expected'
    ).

    DATA(lt_dependent_objects) = cut->get_dependent_objects( it_object_id = VALUE #( ( ) ) ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lt_dependent_objects
        msg              = 'lt_dependent_objects: initial value was expected'
    ).

    cut->display_details_for_cd_line( is_change_document_line = VALUE #( )  ).
    cl_abap_unit_assert=>assert_subrc(
      EXPORTING
        exp              = 0
        msg              = 'display details method execuion failed'
    ).

    cut->get_objectclasses(
      CHANGING
        ct_objectclass = lt_objectclass
    ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lt_objectclass
        msg              = 'lt_objectclass: initial value was expected'
    ).

    DATA(ls_changed_line) = cut->modify_cd_current_line( iv_cdredadd = VALUE #( ) ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = ls_changed_line
        msg              = 'ls_changed_line: initial value was expected'
    ).

    cut->get_attributes(
      EXPORTING
        iv_objectclass = VALUE #( )
      IMPORTING
        ev_attributes  = DATA(lv_attribute)
    ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lv_attribute
        msg              = 'lv_attribute: initial value was expected'
    ).

  ENDMETHOD.

ENDCLASS.