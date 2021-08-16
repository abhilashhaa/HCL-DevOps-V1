CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gs_classkeyword_003 TYPE i_clfnclasskeyword,
      gs_classkeyword_002 TYPE i_clfnclasskeyword,
      gs_classkeyword_001 TYPE i_clfnclasskeyword,
      gs_class_03         TYPE i_clfnclassforkeydate,
      gs_class_02         TYPE i_clfnclassforkeydate,
      gs_class_01         TYPE i_clfnclassforkeydate.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_01 = VALUE #(
      classinternalid   = '1'
      classmaintauthgrp = 'MG0'
      classtype         = 'UT0' ).

    gs_class_02 = VALUE #(
      classinternalid   = '2'
      classmaintauthgrp = 'MG1'
      classtype         = 'UT0' ).

    gs_class_03 = VALUE #(
      classinternalid   = '3'
      classmaintauthgrp = ''
      classtype         = 'UT1' ).

    gs_classkeyword_001 = VALUE #(
      classinternalid   = gs_class_01-classinternalid
      classkeywordtext  = '1'
      language          = 'EN' ).

    gs_classkeyword_002 = VALUE #(
      classinternalid   = gs_class_02-classinternalid
      classkeywordtext  = '2'
      language          = 'EN' ).

    gs_classkeyword_003 = VALUE #(
      classinternalid   = gs_class_03-classinternalid
      classkeywordtext  = '3'
      language          = 'EN' ).

  ENDMETHOD.

ENDCLASS.

"! @testing I_ClfnClasskeywordForKeyDate
CLASS ltc_i_clfnclasskeywforkd_auth DEFINITION
    FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS
    FINAL.

  PRIVATE SECTION.

    TYPES:
      ltt_i_clfnclasskeyword      TYPE STANDARD TABLE OF i_clfnclasskeyword WITH EMPTY KEY,
      ltt_i_clfnclasskeywordforkd TYPE STANDARD TABLE OF i_clfnclasskeywordforkeydate WITH EMPTY KEY,
      ltt_i_clfnclassforkeydate   TYPE STANDARD TABLE OF i_clfnclassforkeydate WITH EMPTY KEY.

    CLASS-DATA:
      go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup.

    METHODS:
      no_authorization    FOR TESTING,
      full_authorization  FOR TESTING,
      classtype_restrict  FOR TESTING,
      activity_restrict   FOR TESTING,
      auth_group_restrict FOR TESTING,
      classtype_and_group FOR TESTING.

    METHODS:
      read_cds
        RETURNING
          VALUE(rt_result) TYPE ltt_i_clfnclasskeywordforkd,
      get_authorization_object
        IMPORTING
          iv_classtype     TYPE string
          iv_activity      TYPE string
          iv_auth_group    TYPE string
        RETURNING
          VALUE(ro_result) TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfnclasskeywforkd_auth IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_cds_test_environment=>create(
      i_for_entity      = 'I_ClfnClassKeywordForKeyDate'
      test_associations = abap_true
    ).

  ENDMETHOD.

  METHOD class_teardown.

    go_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lt_classkeyword) = VALUE ltt_i_clfnclasskeyword(
      ( lth_test_data=>gs_classkeyword_001 )
      ( lth_test_data=>gs_classkeyword_002 )
      ( lth_test_data=>gs_classkeyword_003 )
    ).
    go_environment->insert_test_data( lt_classkeyword ).

    DATA(lt_class) = VALUE ltt_i_clfnclassforkeydate(
      ( lth_test_data=>gs_class_01 )
      ( lth_test_data=>gs_class_02 )
      ( lth_test_data=>gs_class_03 )
    ).
    go_environment->insert_test_data(
      i_data             = lt_class
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
      iv_classtype  = '*'
      iv_activity   = '*'
      iv_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get all data.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD classtype_restrict.

    " Given: I have a restriction to read classtype UT0 only.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = 'UT0'
      iv_activity   = '*'
      iv_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get data with class type UT0.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 2
    ).

  ENDMETHOD.

  METHOD activity_restrict.

    " Given: I have a restriction to activity 02.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = '*'
      iv_activity   = '02'
      iv_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.

  METHOD auth_group_restrict.

    " Given: I have a restriction to read classtype UT0 only.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = '*'
      iv_activity   = '*'
      iv_auth_group = 'MG0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get data with auth. group MG0
    " and where there are no auth. group assigned.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 2
    ).

  ENDMETHOD.

  METHOD classtype_and_group.

    " Given: I have a restriction to read classtype UT1
    " and auth. group is set to MG0.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = 'UT1'
      iv_activity   = '*'
      iv_auth_group = 'MG0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get data with class type UT1 and
    " where auth. group MG0 is set (or initial).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.

  METHOD read_cds.

    SELECT * FROM i_clfnclasskeywordforkeydate
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
                    ( lower_value = iv_activity ) ) )
                ( fieldname   = 'BGRKP'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_auth_group ) ) ) ) ) ) )
      )
    ).

  ENDMETHOD.

ENDCLASS.