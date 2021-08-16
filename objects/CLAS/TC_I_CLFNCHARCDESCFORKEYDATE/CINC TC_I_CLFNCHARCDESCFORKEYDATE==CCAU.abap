CLASS lth_test_data DEFINITION
    FOR TESTING.

  PUBLIC SECTION.

    CLASS-DATA:
      gs_charc_authgrp_empty  TYPE i_clfncharacteristicforkeydate,
      gs_charc_authgrp_auth   TYPE i_clfncharacteristicforkeydate,
      gs_charc_authgrp_noauth TYPE i_clfncharacteristicforkeydate,
      gs_charcdesc_authgrp_empty   TYPE i_clfncharcdesc,
      gs_charcdesc_authgrp_auth    TYPE i_clfncharcdesc,
      gs_charcdesc_authgrp_noauth  TYPE i_clfncharcdesc.

    CLASS-METHODS:
      class_constructor.

ENDCLASS.

CLASS lth_test_data IMPLEMENTATION.

  METHOD class_constructor.

    gs_charc_authgrp_empty = VALUE #(
      charcinternalid    = '1'
      charcmaintauthgrp  = ''
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

    gs_charc_authgrp_auth = VALUE #(
      charcinternalid    = '2'
      charcmaintauthgrp  = 'A'
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

    gs_charc_authgrp_noauth = VALUE #(
      charcinternalid    = '3'
      charcmaintauthgrp  = 'N'
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

    gs_charcdesc_authgrp_empty = VALUE #(
      charcinternalid    = '1'
      language           = 'E'
      charcdescription   = '1'
      timeintervalnumber = '1'
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

    gs_charcdesc_authgrp_auth = VALUE #(
      charcinternalid    = '2'
      language           = 'E'
      charcdescription   = '2'
      timeintervalnumber = '1'
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

    gs_charcdesc_authgrp_noauth = VALUE #(
      charcinternalid    = '3'
      language           = 'E'
      charcdescription   = '3'
      timeintervalnumber = '1'
      validitystartdate  = if_ngc_c=>gc_date_min
      validityenddate    = if_ngc_c=>gc_date_max
    ).

  ENDMETHOD.

ENDCLASS.

"! @testing I_ClfnCharacteristic
CLASS ltc_i_clfncharacteristic_auth DEFINITION
    FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS
    FINAL.

  PRIVATE SECTION.

    TYPES:
      ltt_i_clfncharcdesc           TYPE STANDARD TABLE OF i_clfncharcdesc WITH EMPTY KEY,
      ltt_i_clfncharcdescforkd      TYPE STANDARD TABLE OF i_clfncharcdescforkeydate WITH EMPTY KEY,
      ltt_i_clfncharacteristicforkd TYPE STANDARD TABLE OF i_clfncharacteristicforkeydate WITH EMPTY KEY.

    CLASS-DATA:
      go_environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup.

    METHODS:
      no_authorization             FOR TESTING,
      full_authorization           FOR TESTING,
      auth_group_activity_restrict FOR TESTING,
      activity_restrict            FOR TESTING,
      auth_group_restrict          FOR TESTING.

    METHODS:
      read_cds
        RETURNING
          VALUE(rt_result) TYPE ltt_i_clfncharcdescforkd,
      get_authorization_object
        IMPORTING
          iv_activity      TYPE string
          iv_auth_group    TYPE string
        RETURNING
          VALUE(ro_result) TYPE REF TO if_cds_access_control_data.

ENDCLASS.

CLASS ltc_i_clfncharacteristic_auth IMPLEMENTATION.

  METHOD class_setup.

    go_environment = cl_cds_test_environment=>create(
      i_for_entity      = 'I_ClfnCharcDescForKeyDate'
      test_associations = abap_true
    ).

  ENDMETHOD.

  METHOD class_teardown.

    go_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_environment->get_access_control_double( )->disable_access_control( ).
    go_environment->clear_doubles( ).

    DATA(lt_charc) = VALUE ltt_i_clfncharacteristicforkd(
      ( lth_test_data=>gs_charc_authgrp_empty )
      ( lth_test_data=>gs_charc_authgrp_auth )
      ( lth_test_data=>gs_charc_authgrp_noauth )
    ).
    go_environment->insert_test_data(
      i_data             = lt_charc
      i_parameter_values = VALUE #(
        ( parameter_name  = 'P_KeyDate'
          parameter_value = sy-datum ) )
    ).

    DATA(lt_charcdesc) = VALUE ltt_i_clfncharcdesc(
      ( lth_test_data=>gs_charcdesc_authgrp_empty )
      ( lth_test_data=>gs_charcdesc_authgrp_auth )
      ( lth_test_data=>gs_charcdesc_authgrp_noauth )
    ).
    go_environment->insert_test_data( lt_charcdesc ).

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

  METHOD auth_group_activity_restrict.

    " Given: I have limited authorization - for auth. group 'A' and empty.
    DATA(lo_auth) = me->get_authorization_object(
      iv_activity   = '03'
      iv_auth_group = 'A'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should get 2 rows (for auth. group 'A' and empty).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 2
    ).

  ENDMETHOD.

  METHOD activity_restrict.

    " Given: I have limited authorization with activity 'F4'.
    DATA(lo_auth) = me->get_authorization_object(
      iv_activity   = 'F4'
      iv_auth_group = '*'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have an empty result.
    cl_abap_unit_assert=>assert_initial( lt_result ).

  ENDMETHOD.

  METHOD auth_group_restrict.

    " Given: I have limited authorization with auth. group 'Z' (or empty)
    DATA(lo_auth) = me->get_authorization_object(
      iv_activity   = '*'
      iv_auth_group = 'Z'
    ).
    go_environment->get_access_control_double( )->enable_access_control( lo_auth ).

    " When: I read from the view.
    DATA(lt_result) = me->read_cds( ).

    " Then: I should have one result (for the empty auth. group).
    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_result )
      exp = 1
    ).

  ENDMETHOD.

  METHOD read_cds.

    SELECT * FROM i_clfncharcdescforkeydate
      INTO TABLE @rt_result.

  ENDMETHOD.

  METHOD get_authorization_object.

    ro_result = cl_cds_test_data=>create_access_control_data(
      VALUE #(
        ( object         = 'C_CABN'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ACTVT'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_activity ) ) ) ) ) ) )
        ( object         = 'C_CABN_GRP'
          authorizations = VALUE #(
            ( VALUE #(
                ( fieldname   = 'ATAUTH'
                  fieldvalues = VALUE #(
                    ( lower_value = iv_auth_group ) ) ) ) ) ) ) )
    ).

  ENDMETHOD.

ENDCLASS.