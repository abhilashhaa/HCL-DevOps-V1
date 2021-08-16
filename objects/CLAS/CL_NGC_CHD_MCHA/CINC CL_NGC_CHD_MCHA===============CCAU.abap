CLASS ltc_ngc_chd_mcha DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.

    CONSTANTS:
      lc_obj_id_int   TYPE cuobj    VALUE '123456789012345678',
      lc_obj_tab_mcha TYPE tabelle  VALUE 'MCHA',
      lc_obj_tab_mch1 TYPE tabelle  VALUE 'MCH1'.

    CLASS-DATA:
      sql_environment TYPE REF TO if_osql_test_environment,
      lt_inob         TYPE STANDARD TABLE OF inob,
      lv_obj_id_chd   TYPE cuobn.

    DATA: cut TYPE REF TO if_cd_processing.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_dependent_objects FOR TESTING.
    METHODS: test_other_methods FOR TESTING.

ENDCLASS.

CLASS ltc_ngc_chd_mcha IMPLEMENTATION.

  METHOD class_setup.

    DATA:
      ls_rmclf      TYPE rmclf,
      lv_obj_id_clf TYPE cuobn.

    ls_rmclf-matnr = CONV #( 'TEST_MATERIAL' ).
    ls_rmclf-charg = CONV #( 'TEST_BATCH' ).

    CALL FUNCTION 'CLCV_CONVERT_FIELDS_TO_OBJECT'
      EXPORTING
        rmclfstru      = ls_rmclf
        table          = lc_obj_tab_mch1
      IMPORTING
        rmclfstru      = ls_rmclf
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.

    lv_obj_id_clf = ls_rmclf-objek.

    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'INOB' ) ) ).
    lt_inob = VALUE #( ( cuobj = lc_obj_id_int
                         obtab = lc_obj_tab_mch1
                         objek = lv_obj_id_clf ) ).
    sql_environment->insert_test_data( lt_inob ).

    CALL FUNCTION 'CLCV_CONVERT_FIELDS_TO_OBJECT'
      EXPORTING
        rmclfstru      = ls_rmclf
        table          = lc_obj_tab_mcha
      IMPORTING
        rmclfstru      = ls_rmclf
      EXCEPTIONS
        tclo_not_found = 1
        OTHERS         = 2.

    lv_obj_id_chd = ls_rmclf-objek.

  ENDMETHOD.

  METHOD class_teardown.
    sql_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    cut = NEW cl_ngc_chd_mcha( ).
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD get_dependent_objects.

    DATA:
      lt_object_id      TYPE cdobjectv_range_tab,
      lt_clf_object_act TYPE if_cd_processing=>tt_object,
      lt_clf_object_exp TYPE if_cd_processing=>tt_object.

    lt_object_id = VALUE #( ( sign = 'I' option = 'EQ' low = lv_obj_id_chd ) ).

    lt_clf_object_act = cut->get_dependent_objects( it_object_id = lt_object_id ).

    lt_clf_object_exp = VALUE #( ( object_class   = if_ngc_chd_util=>gc_clf_object_class
                                   object_id      = lc_obj_id_int && 'O'
                                   parent_key     = lv_obj_id_chd
                                   condense_lines = abap_true  ) ).

    cl_abap_unit_assert=>assert_equals( act = lt_clf_object_act
                                        exp = lt_clf_object_exp ).

  ENDMETHOD.

  METHOD test_other_methods.

    DATA: lt_objectclass TYPE cdobjectcl_range_tab.

    DATA(lv_is_authorized) = cut->check_authorization( it_object_id = VALUE #( ( ) ) ).
    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act              = lv_is_authorized
        msg              = 'lv_is_authorized: initial value was expected'
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