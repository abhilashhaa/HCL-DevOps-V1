CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gs_class_001      TYPE i_clfnclass,
      gs_class_023      TYPE i_clfnclass,
      gs_class_001_grp1 TYPE i_clfnclass,
      gs_class_001_grp2 TYPE i_clfnclass,
      gs_class_023_grp2 TYPE i_clfnclass.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gs_class_001 = VALUE #(
      classinternalid   = '1'
      class             = 'CLASS_1'
      classtype         = '001'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_class_023 = VALUE #(
      classinternalid   = '2'
      class             = 'CLASS_2'
      classtype         = '023'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max ).

    gs_class_001_grp1 = VALUE #(
      classinternalid   = '3'
      class             = 'CLASS_3'
      classtype         = '001'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
      classmaintauthgrp = 'GR1' ).

    gs_class_001_grp2 = VALUE #(
      classinternalid   = '4'
      class             = 'CLASS_4'
      classtype         = '001'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
      classmaintauthgrp = 'GR2' ).

    gs_class_023_grp2 = VALUE #(
      classinternalid   = '5'
      class             = 'CLASS_5'
      classtype         = '023'
      validitystartdate = if_ngc_c=>gc_date_min
      validityenddate   = if_ngc_c=>gc_date_max
      classmaintauthgrp = 'GR2' ).

  ENDMETHOD.

ENDCLASS.

"! @testing I_ClfnClassForKeyDate
CLASS ltc_i_clfnclassforkeydate_auth DEFINITION
    FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS
    FINAL.

  PRIVATE SECTION.

    TYPES:
      ltt_i_clfnclass           TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY,
      ltt_i_clfnclassforkeydate TYPE STANDARD TABLE OF i_clfnclassforkeydate WITH EMPTY KEY.

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
          VALUE(rt_result) TYPE ltt_i_clfnclassforkeydate,
      get_authorization_object
        IMPORTING
          iv_classtype     TYPE string
          iv_activity      TYPE string
          iv_auth_group    TYPE string
        RETURNING
          VALUE(ro_result) TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfnclassforkeydate_auth IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_cds_test_environment=>create( 'I_ClfnClassForKeyDate' ).

  ENDMETHOD.

  METHOD class_teardown.

    go_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lt_class) = VALUE ltt_i_clfnclass(
      ( lth_test_data=>gs_class_001 )
      ( lth_test_data=>gs_class_023 )
      ( lth_test_data=>gs_class_001_grp1 )
      ( lth_test_data=>gs_class_001_grp2 )
      ( lth_test_data=>gs_class_023_grp2 ) ).
    go_environment->insert_test_data( lt_class ).

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
      exp = 5
    ).

  ENDMETHOD.

  METHOD classtype_restrict.

    " Given: I have a restriction to read classtypes.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = '001'
      iv_activity   = '03'
      iv_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with the selected classtype.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD activity_restrict.

    " Given: I have a restriction for activity.
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

    " Given: I have a restriction for authorization group.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = '*'
      iv_activity   = '03'
      iv_auth_group = 'GR1'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with empty or the selected authorization group.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 3
    ).

  ENDMETHOD.

  METHOD classtype_and_group.

    " Given: I have a restriction for authorization group and classtype.
    DATA(lo_auth) = me->get_authorization_object(
      iv_classtype  = '001'
      iv_activity   = '03'
      iv_auth_group = 'GR1'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get only data with empty or the selected authorization group and the selected classtype.
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 2
    ).

  ENDMETHOD.

  METHOD read_cds.

    SELECT * FROM i_clfnclassforkeydate
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
                    ( lower_value = iv_auth_group ) ) ) ) ) ) ) )
    ).

  ENDMETHOD.

ENDCLASS.