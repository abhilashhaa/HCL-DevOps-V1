CLASS ltc_ngc_chd_util DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.

    CONSTANTS:
      lc_obj_id     TYPE cuobn    VALUE 'TEST_OBJ_ID',
      lc_obj_id_int TYPE cuobj    VALUE '123456789012345678',
      lc_obj_tab    TYPE tabelle  VALUE 'TEST_OBJ_TAB'.

    CLASS-DATA:
      sql_environment TYPE REF TO if_osql_test_environment,
      lt_inob         TYPE STANDARD TABLE OF inob.

    DATA:
          f_cut TYPE REF TO if_ngc_chd_util.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_instance FOR TESTING.
    METHODS: get_clf_data FOR TESTING.

ENDCLASS.

CLASS ltc_ngc_chd_util IMPLEMENTATION.

  METHOD class_setup.
    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'INOB' ) ) ).
    lt_inob = VALUE #( ( cuobj = lc_obj_id_int
                         obtab = lc_obj_tab
                         objek = lc_obj_id ) ).
    sql_environment->insert_test_data( lt_inob ).
  ENDMETHOD.

  METHOD class_teardown.
    sql_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    f_cut = NEW cl_ngc_chd_util( ).
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD get_instance.

    DATA(lo_cut) = cl_ngc_chd_util=>get_instance( ).

    cl_abap_unit_assert=>assert_bound(
      act = lo_cut
      msg = 'get_instance: RO_INSTANCE is not valid'
    ).

  ENDMETHOD.

  METHOD get_clf_data.

    DATA:
      lt_obj_id         TYPE RANGE OF cuobn,
      lt_clf_object_act TYPE if_cd_processing=>tt_object,
      lt_clf_object_exp TYPE if_cd_processing=>tt_object.

    lt_obj_id = VALUE #( ( sign = 'I' option = 'EQ' low = lc_obj_id ) ).

    f_cut->get_clf_object(
      EXPORTING
        it_object_id    = lt_obj_id
        iv_object_table = lc_obj_tab
      CHANGING
        ct_clf_object   = lt_clf_object_act
    ).

    lt_clf_object_exp = VALUE #( ( object_class   = if_ngc_chd_util=>gc_clf_object_class
                                   object_id      = lc_obj_id_int && 'O'
                                   parent_key     = lc_obj_id
                                   condense_lines = abap_true  ) ).

    cl_abap_unit_assert=>assert_equals( act = lt_clf_object_act
                                        exp = lt_clf_object_exp ).

  ENDMETHOD.

ENDCLASS.