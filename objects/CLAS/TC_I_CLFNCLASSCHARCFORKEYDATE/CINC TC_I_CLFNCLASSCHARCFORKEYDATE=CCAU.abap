CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gs_hiercharc_001     TYPE i_clfnclasshiercharcforkeydate,
      gs_hiercharc_023     TYPE i_clfnclasshiercharcforkeydate,
      gs_hiercharc_001_gr1 TYPE i_clfnclasshiercharcforkeydate,
      gs_hiercharc_001_gr2 TYPE i_clfnclasshiercharcforkeydate,
      gs_hiercharc_001_mix TYPE i_clfnclasshiercharcforkeydate,

      gs_class_001         TYPE i_clfnclassforkeydate,
      gs_class_023         TYPE i_clfnclassforkeydate,
      gs_class_001_gr1     TYPE i_clfnclassforkeydate,
      gs_class_001_gr2     TYPE i_clfnclassforkeydate,

      gs_charc             TYPE i_clfncharacteristicforkeydate,
      gs_charc_gr1         TYPE i_clfncharacteristicforkeydate,
      gs_charc_gr2         TYPE i_clfncharacteristicforkeydate.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_001 = VALUE #(
      classinternalid = '1'
      classtype       = '001' ).

    gs_class_023 = VALUE #(
      classinternalid = '2'
      classtype       = '023' ).

    gs_class_001_gr1 = VALUE #(
      classinternalid   = '3'
      classtype         = '001'
      classmaintauthgrp = 'GR1' ).

    gs_class_001_gr2 = VALUE #(
      classinternalid   = '4'
      classtype         = '001'
      classmaintauthgrp = 'GR2' ).

    gs_charc = VALUE #(
      charcinternalid = '1' ).

    gs_charc_gr1 = VALUE #(
      charcinternalid   = '2'
      charcmaintauthgrp = 'GR1' ).

    gs_charc_gr2 = VALUE #(
      charcinternalid   = '3'
      charcmaintauthgrp = 'GR2' ).

    gs_hiercharc_001 = VALUE #(
      classinternalid   = gs_class_001-classinternalid
      charcinternalid   = gs_charc-charcinternalid
      classtype         = gs_class_001-classtype
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_hiercharc_023 = VALUE #(
      classinternalid   = gs_class_023-classinternalid
      charcinternalid   = gs_charc-charcinternalid
      classtype         = gs_class_023-classtype
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_hiercharc_001_gr1 = VALUE #(
      classinternalid   = gs_class_001_gr1-classinternalid
      charcinternalid   = gs_charc_gr1-charcinternalid
      classtype         = gs_class_001_gr1-classtype
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_hiercharc_001_gr2 = VALUE #(
      classinternalid   = gs_class_001_gr2-classinternalid
      charcinternalid   = gs_charc_gr2-charcinternalid
      classtype         = gs_class_001_gr2-classtype
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_hiercharc_001_mix = VALUE #(
      classinternalid   = gs_class_001_gr1-classinternalid
      charcinternalid   = gs_charc_gr2-charcinternalid
      classtype         = gs_class_001_gr1-classtype
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

  ENDMETHOD.

ENDCLASS.

"! @testing I_ClfnClassCharcForKeyDate
CLASS ltc_i_clfnclasscharcforkd_auth DEFINITION
    FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS
    FINAL.

  PRIVATE SECTION.

    TYPES:
      ltt_i_clfnclasshiercharc TYPE STANDARD TABLE OF i_clfnclasshiercharcforkeydate WITH EMPTY KEY,
      ltt_i_clfnclasscharc     TYPE STANDARD TABLE OF i_clfnclasscharcforkeydate WITH EMPTY KEY,
      ltt_i_clfnclass          TYPE STANDARD TABLE OF i_clfnclassforkeydate WITH EMPTY KEY,
      ltt_i_clfncharacteristic TYPE STANDARD TABLE OF i_clfncharacteristicforkeydate WITH EMPTY KEY.

    CLASS-DATA:
      go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup.

    METHODS:
      no_authorization        FOR TESTING,
      full_authorization      FOR TESTING,
      classtype_restrict      FOR TESTING,
      activity_restrict_cls   FOR TESTING,
      auth_group_restrict_cls FOR TESTING,
      classtype_and_group FOR TESTING.

    METHODS:
      read_cds
        RETURNING
          VALUE(rt_result) TYPE ltt_i_clfnclasscharc,
      get_authorization_object
        IMPORTING
          iv_classtype      TYPE string
          iv_cls_activity   TYPE string
          iv_cls_auth_group TYPE string
        RETURNING
          VALUE(ro_result)  TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfnclasscharcforkd_auth IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_cds_test_environment=>create(
      i_for_entity      = 'I_ClfnClassCharcForKeyDate'
      test_associations = abap_true
    ).

  ENDMETHOD.

  METHOD class_teardown.

    go_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lt_classhiercharc) = VALUE ltt_i_clfnclasshiercharc(
      ( lth_test_data=>gs_hiercharc_001 )
      ( lth_test_data=>gs_hiercharc_023 )
      ( lth_test_data=>gs_hiercharc_001_gr1 )
      ( lth_test_data=>gs_hiercharc_001_gr2 )
      ( lth_test_data=>gs_hiercharc_001_mix ) ).
    go_environment->insert_test_data(
      i_data             = lt_classhiercharc
      i_parameter_values = VALUE #(
        ( parameter_name  = 'P_KeyDate'
          parameter_value = sy-datum ) )
    ).

    DATA(lt_class) = VALUE ltt_i_clfnclass(
      ( lth_test_data=>gs_class_001 )
      ( lth_test_data=>gs_class_023 )
      ( lth_test_data=>gs_class_001_gr1 )
      ( lth_test_data=>gs_class_001_gr2 ) ).
    go_environment->insert_test_data(
      i_data             = lt_class
      i_parameter_values = VALUE #(
        ( parameter_name  = 'P_KeyDate'
          parameter_value = sy-datum ) )
    ).

    DATA(lt_charc) = VALUE ltt_i_clfncharacteristic(
      ( lth_test_data=>gs_charc )
      ( lth_test_data=>gs_charc_gr1 )
      ( lth_test_data=>gs_charc_gr2 ) ).
    go_environment->insert_test_data(
      i_data             = lt_charc
      i_parameter_values = VALUE #(
        ( parameter_name  = 'P_KeyDate'
          parameter_value = sy-datum ) )
    ).

  ENDMETHOD.

  METHOD no_authorization.

    " Given: I don't have authorization to display any.
    DATA(lo_auth) = cl_cds_test_data=>create_access_control_data( VALUE #( ) ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.

  METHOD full_authorization.

    " Given: I have full authorization.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_cls_activity   = '*'
      iv_cls_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get all data.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 5
    ).

  ENDMETHOD.

  METHOD classtype_restrict.

    " Given: I have a restriction to read classtypes.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '001'
      iv_cls_activity   = '03'
      iv_cls_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with the selected classtype.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 4
    ).

  ENDMETHOD.

  METHOD activity_restrict_cls.

    " Given: I have a restriction for class activity.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_cls_activity   = '02'
      iv_cls_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.

  METHOD auth_group_restrict_cls.

    " Given: I have a restriction for class authorization group.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '*'
      iv_cls_activity   = '03'
      iv_cls_auth_group = 'GR1'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with empty or the selected authorization group.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 4
    ).

  ENDMETHOD.

  METHOD classtype_and_group.

    " Given: I have a restriction for class and characteristic authorization group and classtype.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype      = '001'
      iv_cls_activity   = '03'
      iv_cls_auth_group = 'GR1'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with empty or the selected authorization group and the selected classtype.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD read_cds.

    SELECT * FROM i_clfnclasscharcforkeydate
      INTO TABLE @rt_result.

  ENDMETHOD.

  METHOD get_authorization_object.

    ro_result = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_TCLA_BKA'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'KLART'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_classtype ) ) ) ) ) ) )
        ( object         = 'C_KLAH_BKP'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_cls_activity ) ) )
                ( fieldname   = 'BGRKP'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_cls_auth_group ) ) ) ) ) ) ) )
    ).

  ENDMETHOD.

ENDCLASS.