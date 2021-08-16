CLASS lth_ngc_cls_api_result DEFINITION FINAL.
  PUBLIC SECTION.
    CONSTANTS: gc_classinternalid TYPE clint VALUE '1'.
    CONSTANTS: gc_key_date TYPE bapi_keydate VALUE '20170119'.
    CLASS-DATA: gt_core_message TYPE ngct_core_class_msg.
    CLASS-DATA: gt_class_msg TYPE ngct_class_msg.
    CLASS-DATA: gs_class_key TYPE ngcs_class_key.
    CLASS-DATA: gt_spi_msg TYPE /plmb/t_spi_msg.
    CLASS-METHODS: class_constructor.
ENDCLASS.

CLASS lth_ngc_cls_api_result IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_key = VALUE #( classinternalid  = lth_ngc_cls_api_result=>gc_classinternalid
                            key_date         = lth_ngc_cls_api_result=>gc_key_date ).

    gt_core_message = VALUE #( ( classinternalid  = lth_ngc_cls_api_result=>gc_classinternalid
                                 key_date         = lth_ngc_cls_api_result=>gc_key_date
                                 msgty            = 'E'
                                 msgid            = 'DUMMY'
                                 msgno            = '000'
                                 msgv1            = 'MGV1'
                                 msgv2            = 'MGV2'
                                 msgv3            = 'MGV3'
                                 msgv4            = 'MGV4' )
                               ( classinternalid  = lth_ngc_cls_api_result=>gc_classinternalid
                                 key_date         = lth_ngc_cls_api_result=>gc_key_date
                                 msgty            = 'W'
                                 msgid            = 'DUMMY'
                                 msgno            = '001'
                                 msgv1            = 'MGV1'
                                 msgv2            = 'MGV2'
                                 msgv3            = 'MGV3'
                                 msgv4            = 'MGV4' ) ).

    gt_class_msg = VALUE #( ( classinternalid  = lth_ngc_cls_api_result=>gc_classinternalid
                              key_date         = lth_ngc_cls_api_result=>gc_key_date
                              msgty            = gt_core_message[ 1 ]-msgty
                              msgid            = gt_core_message[ 1 ]-msgid
                              msgno            = gt_core_message[ 1 ]-msgno
                              msgv1            = gt_core_message[ 1 ]-msgv1
                              msgv2            = gt_core_message[ 1 ]-msgv2
                              msgv3            = gt_core_message[ 1 ]-msgv3
                              msgv4            = gt_core_message[ 1 ]-msgv4 )
                            ( classinternalid  = lth_ngc_cls_api_result=>gc_classinternalid
                              key_date         = lth_ngc_cls_api_result=>gc_key_date
                              msgty            = gt_core_message[ 2 ]-msgty
                              msgid            = gt_core_message[ 2 ]-msgid
                              msgno            = gt_core_message[ 2 ]-msgno
                              msgv1            = gt_core_message[ 2 ]-msgv1
                              msgv2            = gt_core_message[ 2 ]-msgv2
                              msgv3            = gt_core_message[ 2 ]-msgv3
                              msgv4            = gt_core_message[ 2 ]-msgv4 ) ).

    gt_spi_msg = VALUE #( ( msgty     = gt_core_message[ 1 ]-msgty
                            msgid     = gt_core_message[ 1 ]-msgid
                            msgno     = gt_core_message[ 1 ]-msgno
                            msgv1     = gt_core_message[ 1 ]-msgv1
                            msgv2     = gt_core_message[ 1 ]-msgv2
                            msgv3     = gt_core_message[ 1 ]-msgv3
                            msgv4     = gt_core_message[ 1 ]-msgv4
                            msg_index = '1'
                            fieldname = 'DUMMY' )
                          ( msgty     = gt_core_message[ 2 ]-msgty
                            msgid     = gt_core_message[ 2 ]-msgid
                            msgno     = gt_core_message[ 2 ]-msgno
                            msgv1     = gt_core_message[ 2 ]-msgv1
                            msgv2     = gt_core_message[ 2 ]-msgv2
                            msgv3     = gt_core_message[ 2 ]-msgv3
                            msgv4     = gt_core_message[ 2 ]-msgv4
                            msg_index = '2'
                            fieldname = 'DUMMY' ) ).
  ENDMETHOD.

ENDCLASS.


CLASS ltc_ngc_cls_api_result DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      mo_cut TYPE REF TO cl_ngc_cls_api_result.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: add_messages_from_api_result FOR TESTING.
    METHODS: add_messages_from_core FOR TESTING.
    METHODS: add_messages_from_spi FOR TESTING.
    METHODS: add_message_from_sy FOR TESTING.
    METHODS: add_messages FOR TESTING.
    METHODS: get_messages_without_msg_type FOR TESTING.
    METHODS: get_messages_with_msg_type FOR TESTING.
    METHODS: has_error_or_worse FOR TESTING.
    METHODS: has_message FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_cls_api_result IMPLEMENTATION.

  METHOD class_setup.

  ENDMETHOD.


  METHOD class_teardown.

  ENDMETHOD.


  METHOD setup.
    mo_cut = NEW #( ).
  ENDMETHOD.


  METHOD teardown.

  ENDMETHOD.


  METHOD add_messages_from_api_result.

    DATA: lo_cls_api_result TYPE REF TO cl_ngc_cls_api_result.

    lo_cls_api_result = NEW cl_ngc_cls_api_result( ).

    lo_cls_api_result->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    mo_cut->add_messages_from_api_result( lo_cls_api_result ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'add_messages_from_api_result returned with unexpected result' ).

  ENDMETHOD.


  METHOD add_messages_from_core.

    mo_cut->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'add_messages_from_core returned with unexpected result' ).

  ENDMETHOD.


  METHOD add_messages_from_spi.

    mo_cut->add_messages_from_spi(
      is_class_key = lth_ngc_cls_api_result=>gs_class_key
      it_spi_msg   = lth_ngc_cls_api_result=>gt_spi_msg ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'add_messages_from_spi returned with unexpected result' ).

  ENDMETHOD.


  METHOD add_message_from_sy.

    sy-msgid = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgid.
    sy-msgty = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgty.
    sy-msgno = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgno.
    sy-msgv1 = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgv1.
    sy-msgv2 = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgv2.
    sy-msgv3 = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgv3.
    sy-msgv4 = lth_ngc_cls_api_result=>gt_core_message[ 1 ]-msgv4.

    mo_cut->add_message_from_sy( is_class_key = lth_ngc_cls_api_result=>gs_class_key ).

    sy-msgid = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgid.
    sy-msgty = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgty.
    sy-msgno = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgno.
    sy-msgv1 = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgv1.
    sy-msgv2 = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgv2.
    sy-msgv3 = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgv3.
    sy-msgv4 = lth_ngc_cls_api_result=>gt_core_message[ 2 ]-msgv4.

    mo_cut->add_message_from_sy( is_class_key = lth_ngc_cls_api_result=>gs_class_key ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'add_message_from_sy returned with unexpected result' ).

  ENDMETHOD.


  METHOD add_messages.

    mo_cut->add_messages( lth_ngc_cls_api_result=>gt_class_msg ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'add_messages returned with unexpected result' ).

  ENDMETHOD.


  METHOD get_messages_without_msg_type.

    mo_cut->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( )
                                        exp = lth_ngc_cls_api_result=>gt_class_msg
                                        msg = 'get_messages returned with unexpected result' ).

  ENDMETHOD.


  METHOD get_messages_with_msg_type.

    DATA: lt_messages_exp TYPE ngct_class_msg.

    lt_messages_exp = lth_ngc_cls_api_result=>gt_class_msg.

    DELETE lt_messages_exp WHERE msgty <> 'E'.

    mo_cut->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    cl_abap_unit_assert=>assert_equals( act = mo_cut->if_ngc_cls_api_result~get_messages( 'E' )
                                        exp = lt_messages_exp
                                        msg = 'get_messages returned with unexpected result' ).

  ENDMETHOD.


  METHOD has_error_or_worse.

    cl_abap_unit_assert=>assert_equals( act   = mo_cut->if_ngc_cls_api_result~has_error_or_worse( )
                                        exp   = abap_false
                                        msg   = 'has_error_or_worse return with unexpected result' ).

    mo_cut->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    cl_abap_unit_assert=>assert_equals( act   = mo_cut->if_ngc_cls_api_result~has_error_or_worse( )
                                        exp   = abap_true
                                        msg   = 'has_error_or_worse return with unexpected result' ).

  ENDMETHOD.


  METHOD has_message.

    cl_abap_unit_assert=>assert_equals( act   = mo_cut->if_ngc_cls_api_result~has_message( )
                                        exp   = abap_false
                                        msg   = 'has_message return with unexpected result' ).

    mo_cut->add_messages_from_core( lth_ngc_cls_api_result=>gt_core_message ).

    cl_abap_unit_assert=>assert_equals( act   = mo_cut->if_ngc_cls_api_result~has_message( )
                                        exp   = abap_true
                                        msg   = 'has_message return with unexpected result' ).

  ENDMETHOD.

ENDCLASS.