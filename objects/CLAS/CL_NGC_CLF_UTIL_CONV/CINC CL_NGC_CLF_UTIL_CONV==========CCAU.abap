CLASS ltd_ngc_class DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_class PARTIALLY IMPLEMENTED.
    METHODS:
      constructor
        IMPORTING
          iv_class           TYPE klasse_d
          iv_classtype       TYPE klassenart
          iv_classinternalid TYPE clint
          iv_key_date        TYPE dats DEFAULT sy-datum.
  PRIVATE SECTION.
    DATA: mv_class TYPE klasse_d.
    DATA: mv_classtype TYPE klassenart.
    DATA: mv_classinternalid TYPE clint.
    DATA: mv_key_date TYPE dats.
ENDCLASS.

CLASS ltd_ngc_class IMPLEMENTATION.
  METHOD constructor.
    mv_class           = iv_class.
    mv_classtype       = iv_classtype.
    mv_classinternalid = iv_classinternalid.
    mv_key_date        = iv_key_date.
  ENDMETHOD.
  METHOD if_ngc_class~get_header.
    rs_class_header = VALUE #( classinternalid = mv_classinternalid
                               key_date        = mv_key_date
                               class           = mv_class
                               classtype       = mv_classtype ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_characteristic DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_characteristic PARTIALLY IMPLEMENTED.
    METHODS:
      constructor
        IMPORTING
          iv_characteristic  TYPE atnam
          iv_charcinternalid TYPE atinn
          iv_key_date        TYPE dats DEFAULT sy-datum.
  PRIVATE SECTION.
    DATA: mv_characteristic TYPE atnam.
    DATA: mv_charcinternalid TYPE atinn.
    DATA: mv_key_date TYPE dats.
ENDCLASS.

CLASS ltd_ngc_characteristic IMPLEMENTATION.
  METHOD constructor.
    mv_characteristic  = iv_characteristic.
    mv_charcinternalid = iv_charcinternalid.
    mv_key_date        = iv_key_date.
  ENDMETHOD.
  METHOD if_ngc_characteristic~get_header.
    rs_characteristic_header = VALUE #( characteristic = mv_characteristic charcinternalid = mv_charcinternalid key_date = mv_key_date charcdatatype = 'CHAR' charclength = 30 ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_api DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_api PARTIALLY IMPLEMENTED.
    METHODS:
      set_charc_read_error
        IMPORTING
          iv_charc_read_error TYPE boole_d DEFAULT abap_false,
      set_class_read_error
        IMPORTING
          iv_class_read_error TYPE boole_d DEFAULT abap_false.
  PRIVATE SECTION.
    DATA: mv_charc_read_error TYPE boole_d VALUE abap_false.
    DATA: mv_class_read_error TYPE boole_d VALUE abap_false.
ENDCLASS.

CLASS ltd_ngc_api IMPLEMENTATION.
  METHOD if_ngc_chr_api_read~read.
    DATA: lo_chr_api_result TYPE REF TO cl_ngc_chr_api_result.
    CLEAR: eo_chr_api_result, et_characteristic.
    lo_chr_api_result = NEW cl_ngc_chr_api_result( ).
    eo_chr_api_result = lo_chr_api_result.
    IF mv_charc_read_error = abap_false.
      et_characteristic = VALUE #(
        ( charcinternalid       = '0000000001'
          key_date              = sy-datum
          characteristic_object = NEW ltd_ngc_characteristic( iv_characteristic  = 'CHARACT1'
                                                              iv_charcinternalid = '0000000001'
                                                              iv_key_date        = sy-datum ) )
        ( charcinternalid       = '0000000002'
          key_date              = sy-datum
          characteristic_object = NEW ltd_ngc_characteristic( iv_characteristic  = 'CHARACT2'
                                                              iv_charcinternalid = '0000000002'
                                                              iv_key_date        = sy-datum ) ) ).
    ELSE.
      MESSAGE e010(ngc_api_base) WITH space INTO DATA(lv_msg).
      lo_chr_api_result->add_message_from_sy(
        is_characteristic_key = VALUE #( charcinternalid = '0000000001' key_date = sy-datum )
      ).
      MESSAGE e010(ngc_api_base) WITH space INTO lv_msg.
      lo_chr_api_result->add_message_from_sy(
        is_characteristic_key = VALUE #( charcinternalid = '0000000002' key_date = sy-datum )
      ).
    ENDIF.
  ENDMETHOD.
  METHOD if_ngc_cls_api_read~read.
    DATA: lo_cls_api_result TYPE REF TO cl_ngc_cls_api_result.
    CLEAR: eo_cls_api_result, et_class.
    lo_cls_api_result = NEW cl_ngc_cls_api_result( ).
    eo_cls_api_result = lo_cls_api_result.
    IF mv_class_read_error = abap_false.
      et_class = VALUE #(
        ( classinternalid = '0000000001'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL1'
                                               iv_classtype       = '001'
                                               iv_classinternalid = '0000000001'
                                               iv_key_date        = sy-datum ) )
        ( classinternalid = '0000000002'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL2'
                                               iv_classtype       = '001'
                                               iv_classinternalid = '0000000002'
                                               iv_key_date        = sy-datum ) )
        ( classinternalid = '0000000003'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL3'
                                               iv_classtype       = '001'
                                               iv_classinternalid = '0000000003'
                                               iv_key_date        = sy-datum ) )
        ( classinternalid = '0000000004'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL4'
                                               iv_classtype       = '001'
                                               iv_classinternalid = '0000000004'
                                               iv_key_date        = sy-datum ) )
        ( classinternalid = '0000000005'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL5'
                                               iv_classtype       = 'ZZZ'
                                               iv_classinternalid = '0000000005'
                                               iv_key_date        = sy-datum ) )
        ( classinternalid = '0000000006'
          key_date        = sy-datum
          class_object    = NEW ltd_ngc_class( iv_class           = 'CL6'
                                               iv_classtype       = 'ZZZ'
                                               iv_classinternalid = '0000000006'
                                               iv_key_date        = sy-datum ) )
      ).
    ELSE.
      MESSAGE e024(ngc_api_base) WITH space space INTO DATA(lv_msg).
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000001' key_date = sy-datum )
      ).
      MESSAGE e024(ngc_api_base) WITH space space INTO lv_msg.
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000002' key_date = sy-datum )
      ).
      MESSAGE e024(ngc_api_base) WITH space space INTO lv_msg.
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000003' key_date = sy-datum )
      ).
      MESSAGE e024(ngc_api_base) WITH space space INTO lv_msg.
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000004' key_date = sy-datum )
      ).
      MESSAGE e024(ngc_api_base) WITH space space INTO lv_msg.
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000005' key_date = sy-datum )
      ).
      MESSAGE e024(ngc_api_base) WITH space space INTO lv_msg.
      lo_cls_api_result->add_message_from_sy(
        is_class_key = VALUE #( classinternalid = '0000000006' key_date = sy-datum )
      ).
    ENDIF.
  ENDMETHOD.
  METHOD set_charc_read_error.
    mv_charc_read_error = iv_charc_read_error.
  ENDMETHOD.
  METHOD set_class_read_error.
    mv_class_read_error = iv_class_read_error.
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_core_clf_persistency DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_clf_persistency PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_core_clf_persistency IMPLEMENTATION.
  METHOD if_ngc_core_clf_persistency~read_classtypes.
    rt_classtype = VALUE #( ( classtype                     = '001'
                              clfnobjecttable               = 'MARA'
                              multipleobjtableclfnisallowed = abap_true )
                            ( classtype                     = 'ZZZ'
                              clfnobjecttable               = 'MARA'
                              multipleobjtableclfnisallowed = abap_false ) ).
  ENDMETHOD.
ENDCLASS.

CLASS ltd_ngc_core_cls_util_intersec DEFINITION FINAL FOR TESTING.
  PUBLIC SECTION.
    INTERFACES if_ngc_core_cls_util_intersect PARTIALLY IMPLEMENTED.
ENDCLASS.

CLASS ltd_ngc_core_cls_util_intersec IMPLEMENTATION.
  METHOD if_ngc_core_cls_util_intersect~build_string.
    CLEAR: et_core_message.
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_clf_util_conv DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: conv_db_to_ngc_empty FOR TESTING.
    METHODS: conv_db_to_ngc_cls_assign_succ FOR TESTING.
    METHODS: conv_db_to_ngc_cls_assign_err1 FOR TESTING.
    METHODS: conv_db_to_ngc_cls_assign_err2 FOR TESTING.
    METHODS: get_conv_input
      EXPORTING
        et_inob        TYPE tt_inob
        et_kssk_insert TYPE tt_kssk
        et_kssk_delete TYPE tt_kssk
        et_ausp_insert TYPE tt_ausp
        et_ausp_delete TYPE tt_ausp.
    METHODS: get_conv_exp_output
      EXPORTING
        et_classification TYPE ngct_classification_changes.
ENDCLASS.


CLASS ltc_ngc_clf_util_conv IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.

  METHOD class_teardown.
  ENDMETHOD.

  METHOD setup.
    TEST-INJECTION select_classtype.
      gt_classtypes = VALUE #( ( classtype = '001' clfnobjecttable = 'MARA' multipleobjtableclfnisallowed = abap_true )
                               ( classtype = 'ZZZ' clfnobjecttable = 'MARA' multipleobjtableclfnisallowed = abap_false ) ).
    END-TEST-INJECTION.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD conv_db_to_ngc_empty.

    DATA:
      lt_classification TYPE ngct_classification_changes.

    cl_ngc_clf_util_conv=>conv_db_to_ngc(
      EXPORTING
        io_ngc_api                     = NEW ltd_ngc_api( )
        io_ngc_core_clf_persistency    = NEW ltd_ngc_core_clf_persistency( )
        io_ngc_core_cls_util_intersect = NEW ltd_ngc_core_cls_util_intersec( )
*       IV_KEY_DATE                    =
*       IT_INOB                        =
*       IT_KSSK_INSERT                 =
*       IT_KSSK_DELETE                 =
*       IT_AUSP_INSERT                 =
*       IT_AUSP_DELETE                 =
      IMPORTING
        et_classification              = lt_classification
        eo_clf_api_result              = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_initial(
      act   = lt_classification
      msg   = 'Classification should be initial'
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act   = lo_clf_api_result
      msg   = 'eo_clf_api_result should not be initial'
    ).

    cl_abap_unit_assert=>assert_initial(
      act   = lo_clf_api_result->get_messages( )
      msg   = 'eo_clf_api_result->get_messages( ) should be initial'
    ).
  ENDMETHOD.

  METHOD conv_db_to_ngc_cls_assign_succ.

    DATA:
      lt_inob               TYPE tt_inob,
      lt_kssk_insert        TYPE tt_kssk,
      lt_kssk_delete        TYPE tt_kssk,
      lt_ausp_insert        TYPE tt_ausp,
      lt_ausp_delete        TYPE tt_ausp,
      lt_classification     TYPE ngct_classification_changes,
      lt_classification_exp TYPE ngct_classification_changes.

    get_conv_input(
      IMPORTING
        et_inob        = lt_inob
        et_kssk_insert = lt_kssk_insert
        et_kssk_delete = lt_kssk_delete
        et_ausp_insert = lt_ausp_insert
        et_ausp_delete = lt_ausp_delete
    ).

    cl_ngc_clf_util_conv=>conv_db_to_ngc(
      EXPORTING
        io_ngc_api                     = NEW ltd_ngc_api( )
        io_ngc_core_clf_persistency    = NEW ltd_ngc_core_clf_persistency( )
        io_ngc_core_cls_util_intersect = NEW ltd_ngc_core_cls_util_intersec( )
        iv_key_date                    = sy-datum
        it_inob                        = lt_inob
        it_kssk_insert                 = lt_kssk_insert
        it_kssk_delete                 = lt_kssk_delete
        it_ausp_insert                 = lt_ausp_insert
        it_ausp_delete                 = lt_ausp_delete
      IMPORTING
        et_classification              = lt_classification
        eo_clf_api_result              = DATA(lo_clf_api_result)
    ).

    get_conv_exp_output(
      IMPORTING
        et_classification = lt_classification_exp
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = lt_classification
      exp   = lt_classification_exp
      msg   = 'Classification data should be filled properly'
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act   = lo_clf_api_result
      msg   = 'eo_clf_api_result should not be initial'
    ).

    cl_abap_unit_assert=>assert_initial(
      act   = lo_clf_api_result->get_messages( )
      msg   = 'eo_clf_api_result->get_messages( ) should be initial'
    ).
  ENDMETHOD.

  METHOD conv_db_to_ngc_cls_assign_err1.

    DATA:
      lt_inob           TYPE tt_inob,
      lt_kssk_insert    TYPE tt_kssk,
      lt_kssk_delete    TYPE tt_kssk,
      lt_ausp_insert    TYPE tt_ausp,
      lt_ausp_delete    TYPE tt_ausp,
      lt_classification TYPE ngct_classification_changes.

    get_conv_input(
      IMPORTING
        et_inob        = lt_inob
        et_kssk_insert = lt_kssk_insert
        et_kssk_delete = lt_kssk_delete
        et_ausp_insert = lt_ausp_insert
        et_ausp_delete = lt_ausp_delete
    ).

    DATA(lo_td_ngc_api) = NEW ltd_ngc_api( ).
    lo_td_ngc_api->set_charc_read_error( abap_true ).

    cl_ngc_clf_util_conv=>conv_db_to_ngc(
      EXPORTING
        io_ngc_api                     = lo_td_ngc_api
        io_ngc_core_clf_persistency    = NEW ltd_ngc_core_clf_persistency( )
        io_ngc_core_cls_util_intersect = NEW ltd_ngc_core_cls_util_intersec( )
        iv_key_date                    = sy-datum
        it_inob                        = lt_inob
        it_kssk_insert                 = lt_kssk_insert
        it_kssk_delete                 = lt_kssk_delete
        it_ausp_insert                 = lt_ausp_insert
        it_ausp_delete                 = lt_ausp_delete
      IMPORTING
        et_classification              = lt_classification
        eo_clf_api_result              = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classification
        msg = 'Classification data should be initial'
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lo_clf_api_result
      msg = 'eo_clf_api_result should not be initial'
    ).

    DATA(lt_messages) = lo_clf_api_result->get_messages( ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_messages
      msg = 'eo_clf_api_result->get_messages( ) should not be initial'
    ).

    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<ls_message>).
      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-object_key
        msg = 'Message key field object_key should not be initial'
      ).

      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-technical_object
        msg = 'Message key field technical_object should not be initial'
      ).

      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-key_date
        msg = 'Message key field key_date should not be initial'
      ).
    ENDLOOP.

  ENDMETHOD.

  METHOD conv_db_to_ngc_cls_assign_err2.

    DATA:
      lt_inob           TYPE tt_inob,
      lt_kssk_insert    TYPE tt_kssk,
      lt_kssk_delete    TYPE tt_kssk,
      lt_ausp_insert    TYPE tt_ausp,
      lt_ausp_delete    TYPE tt_ausp,
      lt_classification TYPE ngct_classification_changes.

    get_conv_input(
      IMPORTING
        et_inob        = lt_inob
        et_kssk_insert = lt_kssk_insert
        et_kssk_delete = lt_kssk_delete
        et_ausp_insert = lt_ausp_insert
        et_ausp_delete = lt_ausp_delete
    ).

    DATA(lo_td_ngc_api) = NEW ltd_ngc_api( ).
    lo_td_ngc_api->set_class_read_error( abap_true ).

    cl_ngc_clf_util_conv=>conv_db_to_ngc(
      EXPORTING
        io_ngc_api                     = lo_td_ngc_api
        io_ngc_core_clf_persistency    = NEW ltd_ngc_core_clf_persistency( )
        io_ngc_core_cls_util_intersect = NEW ltd_ngc_core_cls_util_intersec( )
        iv_key_date                    = sy-datum
        it_inob                        = lt_inob
        it_kssk_insert                 = lt_kssk_insert
        it_kssk_delete                 = lt_kssk_delete
        it_ausp_insert                 = lt_ausp_insert
        it_ausp_delete                 = lt_ausp_delete
      IMPORTING
        et_classification              = lt_classification
        eo_clf_api_result              = DATA(lo_clf_api_result)
    ).

    cl_abap_unit_assert=>assert_initial(
      EXPORTING
        act = lt_classification
        msg = 'Classification data should be initial'
    ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lo_clf_api_result
      msg = 'eo_clf_api_result should not be initial'
    ).

    DATA(lt_messages) = lo_clf_api_result->get_messages( ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lt_messages
      msg = 'eo_clf_api_result->get_messages( ) should not be initial'
    ).

    LOOP AT lt_messages ASSIGNING FIELD-SYMBOL(<ls_message>).
      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-object_key
        msg = 'Message key field object_key should not be initial'
      ).

      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-technical_object
        msg = 'Message key field technical_object should not be initial'
      ).

      cl_abap_unit_assert=>assert_not_initial(
        act = <ls_message>-key_date
        msg = 'Message key field key_date should not be initial'
      ).
    ENDLOOP.

  ENDMETHOD.

  METHOD get_conv_input.

    et_inob = VALUE tt_inob( (
      cuobj = '000000000000000001'
      klart = '001'
      obtab = 'MARA'
      objek = 'MATNR'
    ) ).

    et_kssk_insert = VALUE tt_kssk(
      ( objek = '000000000000000001'
        klart = '001'
        mafid = 'O'
        clint = '0000000001'
        zaehl = '10'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
      ( objek = '000000000000000001'
        klart = '001'
        mafid = 'O'
        clint = '0000000002'
        zaehl = '20'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
      ( objek = 'MATNR'
        klart = 'ZZZ'
        mafid = 'O'
        clint = '0000000005'
        zaehl = '99'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
    ).

    et_kssk_delete = VALUE tt_kssk(
      ( objek = '000000000000000001'
        klart = '001'
        mafid = 'O'
        clint = '0000000003'
        zaehl = '30'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
      ( objek = '000000000000000001'
        klart = '001'
        mafid = 'O'
        clint = '0000000004'
        zaehl = '40'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
      ( objek = 'MATNR'
        klart = 'ZZZ'
        mafid = 'O'
        clint = '0000000006'
        zaehl = '77'
        statu = '1'
        datuv = '19000101'
        datub = '99991231' )
    ).

    et_ausp_insert = VALUE #(
      ( objek = '000000000000000001'
        klart = '001'
        atinn = '0000000001'
        atwrt = 'TEST_INSERT'
        atcod = '1'
        atflv = ''
        atflb = ''
        atawe = ''
        ataw1 = '' )
      ( objek = 'MATNR'
        klart = 'ZZZ'
        atinn = '0000000001'
        atwrt = 'TEST_INSERT'
        atcod = '1'
        atflv = ''
        atflb = ''
        atawe = ''
        ataw1 = '' ) ).

    et_ausp_delete = VALUE #(
      ( objek = '000000000000000001'
        klart = '001'
        atinn = '0000000002'
        atwrt = 'TEST_DELETE'
        atcod = '1'
        atflv = ''
        atflb = ''
        atawe = ''
        ataw1 = '' )
      ( objek = 'MATNR'
        klart = 'ZZZ'
        atinn = '0000000002'
        atwrt = 'TEST_DELETE'
        atcod = '1'
        atflv = ''
        atflb = ''
        atawe = ''
        ataw1 = '' ) ).

  ENDMETHOD.

  METHOD get_conv_exp_output.

    et_classification = VALUE ngct_classification_changes( (
      classification_key   = VALUE ngcs_classification_key( object_key       = 'MATNR'
                                                            technical_object = 'MARA'
                                                            key_date         = sy-datum )
      assign_class_ext_key = VALUE #( ( classtype = '001' class = 'CL1' key_date = sy-datum )
                                      ( classtype = '001' class = 'CL2' key_date = sy-datum )
                                      ( classtype = 'ZZZ' class = 'CL5' key_date = sy-datum ) )
      remove_class_ext_key = VALUE #( ( classtype = '001' class = 'CL3' key_date = sy-datum )
                                      ( classtype = '001' class = 'CL4' key_date = sy-datum )
                                      ( classtype = 'ZZZ' class = 'CL6' key_date = sy-datum ) )
      assign_class_int_key = VALUE #( ( classinternalid = '0000000001' key_date = sy-datum )
                                      ( classinternalid = '0000000002' key_date = sy-datum )
                                      ( classinternalid = '0000000005' key_date = sy-datum ) )
      remove_class_int_key = VALUE #( ( classinternalid = '0000000003' key_date = sy-datum )
                                      ( classinternalid = '0000000004' key_date = sy-datum )
                                      ( classinternalid = '0000000006' key_date = sy-datum ) )
      classification_data  = VALUE #( ( classinternalid = '0000000001' clfnstatus = '1' classpositionnumber = '10' )
                                      ( classinternalid = '0000000002' clfnstatus = '1' classpositionnumber = '20' )
                                      ( classinternalid = '0000000005' clfnstatus = '1' classpositionnumber = '99' ) )
      change_value         = VALUE #( ( classtype       = '001'
                                        charcinternalid = '0000000001'
                                        charcvaluenew   = 'TEST_INSERT' )
                                      ( classtype       = '001'
                                        charcinternalid = '0000000002'
                                        charcvalueold   = 'TEST_DELETE' )
                                      ( classtype       = 'ZZZ'
                                        charcinternalid = '0000000001'
                                        charcvaluenew   = 'TEST_INSERT' )
                                      ( classtype       = 'ZZZ'
                                        charcinternalid = '0000000002'
                                        charcvalueold   = 'TEST_DELETE' ) )
    ) ).

  ENDMETHOD.

ENDCLASS.