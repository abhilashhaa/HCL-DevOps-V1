*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnClass
CLASS ltc_i_clfnclass DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    METHODS:
      setup,
      check_maintain_dcl                  FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnclass IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClass' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_class TYPE STANDARD TABLE OF klah WITH EMPTY KEY,
          lo_class TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_class = VALUE #(
      ( clint = '1' class = 'CL01' klart = 'AU1' bgrkp = 'AAA' bgrkl = '' )
      ( clint = '2' class = 'CL01' klart = 'AU3' bgrkp = ''    bgrkl = '' )
      ( clint = '3' class = 'CL02' klart = 'AU1' bgrkp = 'BBB' bgrkl = '' )
      ( clint = '4' class = 'CL03' klart = 'AU1' bgrkp = ''    bgrkl = '' )
      ( clint = '5' class = 'CL04' klart = 'AU2' bgrkp = ''    bgrkl = 'YYY' )
      ( clint = '6' class = 'CL05' klart = 'AU2' bgrkp = ''    bgrkl = '' )
      ( clint = '7' class = 'CL06' klart = 'AU2' bgrkp = ''    bgrkl = 'ZZZ' )
    ).
    lo_class = cl_cds_test_data=>create( i_data = lt_class ).
    DATA(lo_class_stub) = environment->get_double( i_name = 'klah' ).
    lo_class_stub->insert( lo_class ).

  ENDMETHOD.

  METHOD check_maintain_dcl.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY,
          act_results TYPE STANDARD TABLE OF i_clfnclass WITH EMPTY KEY.
    " enable dcl without authorization for the objects -> no result expected
    DATA(acm_data_no_authorization) = cl_cds_test_data=>create_access_control_data( i_role_authorizations = VALUE #( ) ).
    environment->get_access_control_double( )->disable_access_control( )."enable_access_control( i_access_control_data = acm_data_no_authorization ).
    environment->get_access_control_double( )->enable_access_control( i_access_control_data = acm_data_no_authorization ).

    SELECT *
     FROM
        i_clfnclass
     WHERE classtype = 'AU1'
     INTO CORRESPONDING FIELDS OF TABLE @act_results.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 0 ).

    " enable dcl with authorization
    DATA(lo_class_auth) =  cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #(
          (
            object         = 'C_TCLA_BKA'
            authorizations = VALUE #(
             (
                VALUE #(
                 (
                    fieldname   = 'KLART'
                    fieldvalues = VALUE #(
                      ( lower_value = 'AU1' )
                    )  " Field values
                 )  " KLART
                )
             ) "auth.value
          )
      ) " auth.object C_TCLA_BKA
          (
            object         = 'C_KLAH_BKP'
            authorizations = VALUE #(
             (
                VALUE #(
                 (  fieldname   = 'BGRKP'
                    fieldvalues = VALUE #( ( lower_value = 'AAA' ) )
                 )  " ACTVT
                 (  fieldname   = 'ACTVT'
                    fieldvalues = VALUE #( ( lower_value = '03' ) )
                 )  " ACTVT
                )
             ) "auth.value
            )
          )   " auth.object C_KLAH_BKP
      ) " Table of authorization objects
    ).  " CREATE_ACCESS_CONTROL_DATA

    environment->get_access_control_double( )->enable_access_control( i_access_control_data = lo_class_auth ).

    SELECT *
     FROM
        i_clfnclass
     WHERE classtype = 'AU1'
     INTO CORRESPONDING FIELDS OF TABLE  @act_results.

*    Assertion
    exp_results = VALUE #(
      ( classinternalid = '1' class = 'CL01' classtype = 'AU1' classmaintauthgrp = 'AAA' )
      ( classinternalid = '4' class = 'CL03' classtype = 'AU1' classmaintauthgrp = '' )
     ).
    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).

  ENDMETHOD.

ENDCLASS.