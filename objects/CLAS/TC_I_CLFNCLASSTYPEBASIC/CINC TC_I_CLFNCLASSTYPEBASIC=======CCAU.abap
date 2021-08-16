*"* use this source file for your ABAP unit test classes

CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gt_tcla TYPE tt_tcla.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gt_tcla = VALUE tt_tcla(
      ( mandt = sy-mandt obtab = 'OBJ1' klart = 'UT0' )
      ( mandt = sy-mandt obtab = 'OBJ1' klart = 'UT1' )
      ( mandt = sy-mandt obtab = 'OBJ1' klart = 'UT2' )
      ( mandt = sy-mandt obtab = 'OBJ1' klart = 'UT3' )
      ( mandt = sy-mandt obtab = 'OBJ2' klart = 'UT4' )
      ( mandt = sy-mandt obtab = 'OBJ2' klart = 'UT5' )
      ( mandt = sy-mandt obtab = 'OBJ2' klart = 'UT6' )
    ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_i_clfnclasstypebasic DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    TYPES:
      ltt_i_clfnclasstypebasic      TYPE STANDARD TABLE OF i_clfnclasstypebasic WITH EMPTY KEY.

    CLASS-DATA:
      go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup.

    METHODS:
      no_authorization          FOR TESTING,
      full_authorization        FOR TESTING,
      classtype_restrict        FOR TESTING,
      classtype_restrict_multi  FOR TESTING.

    METHODS:
      read_cds
        RETURNING
          VALUE(rt_result) TYPE ltt_i_clfnclasstypebasic,
      get_authorization_object
        IMPORTING
          iv_classtype     TYPE string
        RETURNING
          VALUE(ro_result) TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfnclasstypebasic IMPLEMENTATION.
  METHOD class_setup.
    go_environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClassTypeBasic' ).
  ENDMETHOD.

  METHOD class_teardown.
    go_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lo_tcla) = cl_cds_test_data=>create( i_data = lth_test_data=>gt_tcla ).
    DATA(lo_tcla_stub) = go_environment->get_double( i_name = 'TCLA' ).
    lo_tcla_stub->insert( lo_tcla ).

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
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get all data.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 7
    ).

  ENDMETHOD.

  METHOD classtype_restrict.

    " Given: I have a restriction to read classtype UT0 only.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = 'UT0'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get data with class type UT0.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.

  METHOD classtype_restrict_multi.

    " Given: I have a restriction to read classtype UT0/UT1/UT6 only.
    DATA(lo_auth) = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_TCLA_BKA'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'KLART'
                  fieldvalues = VALUE #(
                    ( lower_value = 'UT0' )
                    ( lower_value = 'UT1' )
                    ( lower_value = 'UT6' ) ) ) ) ) ) )
      )
    ).

    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get data with class type UT0/UT1/UT6.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD read_cds.

    SELECT * FROM i_clfnclasstypebasic
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
      )
    ).

  ENDMETHOD.

ENDCLASS.