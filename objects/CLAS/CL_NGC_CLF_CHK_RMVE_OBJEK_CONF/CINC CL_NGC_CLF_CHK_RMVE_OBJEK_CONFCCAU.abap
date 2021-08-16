*"* use this source file for your ABAP unit test classes

CLASS lth_ngc_class DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_class PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS lth_ngc_class IMPLEMENTATION.
  METHOD if_ngc_class~get_header.
    rs_class_header-class = 'TESTCLASS'.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_check_used DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES: lif_check.
ENDCLASS.

CLASS ltd_check_used IMPLEMENTATION.
  METHOD lif_check~cucp_check_del_obj_class_conf.
    CASE cucp_var_class_type.
      WHEN '003'.
        RAISE deletion_allowed.
      WHEN '004'.
        RAISE deletion_allowed_with_ecm.
      WHEN OTHERS.
        sy-subrc = 0.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_clf_persistency DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES: if_ngc_core_clf_persistency PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_clf_persistency IMPLEMENTATION.
  METHOD if_ngc_core_clf_persistency~read_classtype.
    CASE iv_classtype.
      WHEN '001'.
        rs_classtype = VALUE #( classtype = iv_classtype classtypeisusableinvarconfign = abap_false ).
      WHEN '002'
        OR '003'
        OR '004'.
        rs_classtype = VALUE #( classtype = iv_classtype classtypeisusableinvarconfign = abap_true ).
    ENDCASE.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_chk_rmve_objek_con DEFINITION DEFERRED.
CLASS cl_ngc_clf_chk_rmve_objek_conf DEFINITION LOCAL FRIENDS ltc_ngc_clf_chk_rmve_objek_con.

CLASS ltc_ngc_clf_chk_rmve_objek_con DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.
  PRIVATE SECTION.
    DATA: mo_cut TYPE REF TO if_ex_ngc_clf_chk_rmve_classes.

    CLASS-DATA:
      go_osql_test_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: classtype_not_for_variant_conf FOR TESTING.
    METHODS: techn_obj_not_in_conf_status FOR TESTING.
    METHODS: deletion_not_allowed FOR TESTING.
    METHODS: deletion_allowed FOR TESTING.
    METHODS: deletion_allowed_with_ecm FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_clf_chk_rmve_objek_con IMPLEMENTATION.

  METHOD class_setup.
    DATA: lt_tcuos TYPE STANDARD TABLE OF tcuos.
    go_osql_test_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'TCUOS' ) ) ).
    lt_tcuos = VALUE #( ( mandt = sy-mandt obtab = 'MARA' status = 0 ) ).
    go_osql_test_environment->insert_test_data( i_data = lt_tcuos ).
  ENDMETHOD.

  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.
    DATA(lo_cut) = NEW cl_ngc_clf_chk_rmve_objek_conf( ).
    lo_cut->mo_check = NEW ltd_check_used( ).
    lo_cut->mo_clf_persistency = NEW ltd_clf_persistency( ).
    mo_cut = lo_cut.
  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.

  METHOD classtype_not_for_variant_conf.

    DATA:
      lv_allowed TYPE boole_d VALUE abap_true,
      lt_message TYPE ngct_msg_with_index.

    mo_cut->check_remove_classes(
      EXPORTING
        iv_classtype               = '001'
        is_classification_key      = VALUE #( object_key       = 'ABCD'
                                              technical_object = 'MARA'
                                              change_number    = space
                                              key_date         = sy-datum )
        it_classification_ref_data = VALUE #( )
        it_class                   = VALUE #( )
      CHANGING
        cv_allowed                 = lv_allowed
        ct_message                 = lt_message
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_allowed
      exp = abap_true
    ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
    ).

  ENDMETHOD.

  METHOD techn_obj_not_in_conf_status.

    DATA:
      lv_allowed TYPE boole_d VALUE abap_true,
      lt_message TYPE ngct_msg_with_index.

    mo_cut->check_remove_classes(
      EXPORTING
        iv_classtype               = '002'
        is_classification_key      = VALUE #( object_key       = 'ABCD'
                                              technical_object = 'NOTFOUND'
                                              change_number    = space
                                              key_date         = sy-datum )
        it_classification_ref_data = VALUE #( )
        it_class                   = VALUE #( )
      CHANGING
        cv_allowed                 = lv_allowed
        ct_message                 = lt_message
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_allowed
      exp = abap_true
    ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
    ).

  ENDMETHOD.

  METHOD deletion_not_allowed.

    DATA:
      lv_allowed TYPE boole_d VALUE abap_true,
      lt_message TYPE ngct_msg_with_index.

    mo_cut->check_remove_classes(
      EXPORTING
        iv_classtype               = '002'
        is_classification_key      = VALUE #( object_key       = 'ABCD'
                                              technical_object = 'MARA'
                                              change_number    = space
                                              key_date         = sy-datum )
        it_classification_ref_data = VALUE #( )
        it_class                   = VALUE #( )
      CHANGING
        cv_allowed                 = lv_allowed
        ct_message                 = lt_message
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_allowed
      exp = abap_false
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_message
    ).

  ENDMETHOD.

  METHOD deletion_allowed.

    DATA:
      lv_allowed TYPE boole_d VALUE abap_true,
      lt_message TYPE ngct_msg_with_index.

    mo_cut->check_remove_classes(
      EXPORTING
        iv_classtype               = '003'
        is_classification_key      = VALUE #( object_key       = 'ABCD'
                                              technical_object = 'MARA'
                                              change_number    = space
                                              key_date         = sy-datum )
        it_classification_ref_data = VALUE #( )
        it_class                   = VALUE #( )
      CHANGING
        cv_allowed                 = lv_allowed
        ct_message                 = lt_message
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_allowed
      exp = abap_true
    ).

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
    ).

*    cl_abap_unit_assert=>assert_equals(
*      act = lt_message
*      exp = VALUE ngct_msg_with_index( ( msgty     = 'E'
*                                         msgid     = 'CL'
*                                         msgno     = 551
*                                         msgv1     = 'ABCD'
*                                         msgv2     = 'TESTCLASS'
*                                         msg_index = 1 ) ) ).

  ENDMETHOD.


  METHOD deletion_allowed_with_ecm.

    DATA:
      lv_allowed TYPE boole_d VALUE abap_true,
      lt_message TYPE ngct_msg_with_index.

    mo_cut->check_remove_classes(
      EXPORTING
        iv_classtype               = '004'
        is_classification_key      = VALUE #( object_key       = 'ABCD'
                                              technical_object = 'MARA'
                                              change_number    = space
                                              key_date         = sy-datum )
        it_classification_ref_data = VALUE #( )
        it_class                   = VALUE #( )
      CHANGING
        cv_allowed                 = lv_allowed
        ct_message                 = lt_message
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_allowed
      exp = abap_true
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_message
    ).

*    cl_abap_unit_assert=>assert_equals(
*      act = lt_message
*      exp = VALUE ngct_msg_with_index( ( msgty     = 'E'
*                                         msgid     = 'CL'
*                                         msgno     = 551
*                                         msgv1     = 'ABCD'
*                                         msgv2     = 'TESTCLASS'
*                                         msg_index = 1 ) ) ).

  ENDMETHOD.

ENDCLASS.