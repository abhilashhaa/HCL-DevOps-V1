*"* use this source file for your ABAP unit test classes
"! @testing I_ClfnClassType
CLASS ltc_i_clfnclasstype DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS
  FINAL.

  PRIVATE SECTION.
    CLASS-DATA:
      environment TYPE REF TO if_cds_test_environment.

    CLASS-METHODS:
      class_setup,
      class_teardown.

    DATA:
      act_results TYPE STANDARD TABLE OF i_clfnclasstype WITH EMPTY KEY.

    METHODS:
      setup,
      check_mara_w_026           FOR TESTING,
      check_equi                 FOR TESTING,
      check_tmpspeclst_301_w_dcl FOR TESTING,
      check_tmpspeclst_301       FOR TESTING.

ENDCLASS.

CLASS ltc_i_clfnclasstype IMPLEMENTATION.
  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'I_ClfnClassType' ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    DATA: lt_tcla  TYPE STANDARD TABLE OF tcla WITH EMPTY KEY,
          lt_tclao TYPE STANDARD TABLE OF tclao WITH EMPTY KEY,
          lo_tcla  TYPE REF TO if_cds_test_data,
          lo_tclao TYPE REF TO if_cds_test_data.

    environment->clear_doubles( ).

    lt_tcla = VALUE #(
      ( mandt = sy-mandt obtab = 'MARA' klart = '001' intklart = ''  mfkls = 'X'  multobj = '' )
      ( mandt = sy-mandt obtab = 'EQUI' klart = '002' intklart = ''  mfkls = ''  multobj = '' )
      ( mandt = sy-mandt obtab = 'EQUI' klart = 'F02' intklart = 'X' mfkls = ''  multobj = '' )
      ( mandt = sy-mandt obtab = 'MCHA' klart = '022' intklart = 'X' mfkls = ''  multobj = '' )
      ( mandt = sy-mandt obtab = 'MCHA' klart = '023' intklart = ''  mfkls = ''  multobj = 'X' )
      ( mandt = sy-mandt obtab = 'RESB' klart = '026' intklart = 'X' mfkls = ''  multobj = 'X' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '200' intklart = ''  mfkls = ''  multobj = '' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '300' intklart = ''  mfkls = 'X' multobj = 'X'  )
      ( mandt = sy-mandt obtab = 'TMPSPECLST' klart = '301' intklart = '' mfkls = '' multobj = 'X' )
      ( mandt = sy-mandt obtab = 'J_3GKATAL' klart = '600' intklart = '' mfkls = '' multobj = 'X' )
    ).
    lo_tcla = cl_cds_test_data=>create( i_data = lt_tcla ).
    DATA(lo_tcla_stub) = environment->get_double( i_name = 'TCLA' ).
    lo_tcla_stub->insert( lo_tcla ).

    lt_tclao = VALUE #(
      ( mandt = sy-mandt obtab = 'MARA' klart = '001' mfkls = '')
      ( mandt = sy-mandt obtab = 'MARA' klart = '022' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '023' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '026' )
      ( mandt = sy-mandt obtab = 'MARA' klart = '300' mfkls = ''  )
      ( mandt = sy-mandt obtab = 'EQUI' klart = '300' mfkls = 'X' )
      ( mandt = sy-mandt obtab = 'EQUI' klart = '600' mfkls = 'X' )
      ( mandt = sy-mandt obtab = 'TMPSPECLST' klart = '301' )
    ).
    lo_tclao = cl_cds_test_data=>create( i_data = lt_tclao ).
    DATA(lo_tclao_stub) = environment->get_double( i_name = 'TCLAO' ).
    lo_tclao_stub->insert( lo_tclao ).

  ENDMETHOD.

  METHOD check_mara_w_026.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasstype WITH EMPTY KEY.

    SELECT
        *
     FROM
        i_clfnclasstype
     WHERE clfnobjecttable = 'MARA'
     INTO TABLE @act_results.

    SORT act_results BY classtype.
*    Assertion
    exp_results = VALUE #(
      ( classtype = '001' clfnobjecttable = 'MARA' multipleclassisallowed = 'X')        "from tcla
      ( classtype = '023' clfnobjecttable = 'MARA' multipleobjtableclfnisallowed = 'X') "from tclao
      ( classtype = '026' clfnobjecttable = 'MARA' multipleobjtableclfnisallowed = 'X') "from tclao
      ( classtype = '200' clfnobjecttable = 'MARA' )                                    "from tcla
      ( classtype = '300' clfnobjecttable = 'MARA' multipleobjtableclfnisallowed = 'X') "from tclao
     ).
    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD check_equi.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasstype WITH EMPTY KEY.

    SELECT
       *
     FROM
        i_clfnclasstype
     WHERE clfnobjecttable = 'EQUI'
     INTO TABLE @act_results.

    SORT act_results BY classtype.
*    Assertion
    exp_results = VALUE #(
      ( classtype = '002' clfnobjecttable = 'EQUI' )
      ( classtype = '300' clfnobjecttable = 'EQUI' multipleclassisallowed = 'X' multipleobjtableclfnisallowed = 'X' )
      ( classtype = '600' clfnobjecttable = 'EQUI' multipleclassisallowed = 'X' multipleobjtableclfnisallowed = 'X' )
     ).
    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD check_tmpspeclst_301.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasstype WITH EMPTY KEY.

    SELECT
        i_clfnclasstype~classtype,
        i_clfnclasstype~clfnobjecttable
     FROM
        i_clfnclasstype
     WHERE clfnobjecttable = 'TMPSPECLST'
       AND classtype       = '301'
     INTO TABLE @act_results.

    SORT act_results BY classtype.
*    Assertion
    exp_results = VALUE #(
      ( classtype = '301' clfnobjecttable = 'TMPSPECLST' )
     ).
    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).
  ENDMETHOD.

  METHOD check_tmpspeclst_301_w_dcl.
    DATA: exp_results TYPE STANDARD TABLE OF i_clfnclasstype WITH EMPTY KEY.
    " enable dcl without authorization for the objects -> no result expected
    DATA(acm_data_no_authorization) = cl_cds_test_data=>create_access_control_data( i_role_authorizations = VALUE #( ) ).
    environment->get_access_control_double( )->DISABLE_ACCESS_CONTROL( )."enable_access_control( i_access_control_data = acm_data_no_authorization ).
    environment->get_access_control_double( )->enable_access_control( i_access_control_data = acm_data_no_authorization ).

    SELECT
        i_clfnclasstype~classtype,
        i_clfnclasstype~clfnobjecttable
     FROM
        i_clfnclasstype
     WHERE clfnobjecttable = 'TMPSPECLST'
       AND classtype       = '301'
     INTO TABLE @act_results.

    SORT act_results BY classtype.

    cl_abap_unit_assert=>assert_equals(
      act = lines( act_results )
      exp = 0 ).

    " enable dcl with authorization for class type 301 -> returns 301
    DATA(lo_c_tcla_bka) =  cl_cds_test_data=>create_access_control_data(
        i_role_authorizations = VALUE #(
          (
            object         = 'C_TCLA_BKA'
            authorizations = VALUE #(
          (
            VALUE #(
              (
                fieldname   = 'KLART'
                fieldvalues = VALUE #(
                  ( lower_value = '301' )  " User is authorized for CARRID = 'LH' ...
                )  " Field values
              )  " KLART
            )
          ) "auth.value
          )
      ) " auth.object C_TCLA_BKA
    )   " Table of authorization objects
    ).  " CREATE_ACCESS_CONTROL_DATA

    environment->get_access_control_double( )->enable_access_control( i_access_control_data = lo_c_tcla_bka ).

    SELECT
        i_clfnclasstype~classtype,
        i_clfnclasstype~clfnobjecttable
     FROM
        i_clfnclasstype
     WHERE clfnobjecttable = 'TMPSPECLST'
       AND classtype       = '301'
     INTO TABLE @act_results.

    SORT act_results BY classtype.
*    Assertion
    exp_results = VALUE #(
      ( classtype = '301' clfnobjecttable = 'TMPSPECLST' )
     ).
    cl_abap_unit_assert=>assert_equals(
      act = act_results
      exp = exp_results ).

  ENDMETHOD.

ENDCLASS.