**"* use this source file for your ABAP unit test classes

CLASS ltc_ngc_clsmas_drf_filter DEFINITION DEFERRED.
CLASS cl_ngc_drf_clsmas_filter DEFINITION LOCAL FRIENDS ltc_ngc_clsmas_drf_filter.

CLASS ltc_ngc_clsmas_drf_filter DEFINITION FOR TESTING
DURATION SHORT
RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut TYPE REF TO cl_ngc_drf_clsmas_filter.  "class under test

    CLASS-DATA: sql_environment TYPE REF TO if_osql_test_environment.
    CLASS-DATA: lt_klah TYPE STANDARD TABLE OF klah WITH EMPTY KEY.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_filter_001_cls_1 FOR TESTING.
    METHODS: apply_filter_all FOR TESTING.
ENDCLASS.

CLASS ltc_ngc_clsmas_drf_filter IMPLEMENTATION.

  METHOD class_setup.
    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'KLAH' ) ) ).
    lt_klah = VALUE #( ( mandt = sy-mandt clint = '0000000001' klart = ''    class = '' )
                       ( mandt = sy-mandt clint = '0000000002' klart = ''    class = 'CLS_1' )
                       ( mandt = sy-mandt clint = '0000000003' klart = '001' class = '' )
                       ( mandt = sy-mandt clint = '0000000004' klart = '001' class = 'CLS_1' )
                       ( mandt = sy-mandt clint = '0000000005' klart = '001' class = 'CLS_2' )
                       ( mandt = sy-mandt clint = '0000000006' klart = '001' class = 'CLS_3' )
                       ( mandt = sy-mandt clint = '0000000007' klart = '002' class = 'CLS_1' )
                       ( mandt = sy-mandt clint = '0000000008' klart = '002' class = 'CLS_2' )
                       ( mandt = sy-mandt clint = '0000000009' klart = '002' class = 'CLS_3' ) ).
    sql_environment->insert_test_data( lt_klah ).
  ENDMETHOD.

  METHOD class_teardown.
  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT f_cut.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD apply_filter_001_cls_1.

    DATA:
      lo_bal                TYPE REF TO cl_drf_bal,
      lt_unfiltered_objects TYPE ngct_drf_clsmas_object_key,
      lt_filtered_objects   TYPE ngct_drf_clsmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CLSMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( strucname = 'NGCS_DRF_CLSMAS_OBJECT_KEY' )
        io_bal                = lo_bal
        it_external_criteria  = VALUE #(
                                  ( tablename = 'NGCS_DRF_CLSMAS_OBJECT_KEY'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'KLART'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = '001' )
                                        )
                                      )
                                      ( fieldname = 'CLASS'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'CLS_1' )
                                        )
                                      )
                                    )
                                  )
                                )
        it_unfiltered_objects = lt_unfiltered_objects
      IMPORTING
        et_filtered_objects   = lt_filtered_objects
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = lt_filtered_objects
      exp   = VALUE ngct_drf_clsmas_object_key( ( klart = '001' class = 'CLS_1' ) )
      msg   = 'apply_filter: lt_filtered_objects is not valid'
    ).

  ENDMETHOD.

  METHOD apply_filter_all.

    DATA:
      lo_bal                TYPE REF TO cl_drf_bal,
      lt_unfiltered_objects TYPE ngct_drf_clsmas_object_key,
      lt_filtered_objects   TYPE ngct_drf_clsmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CLSMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( )
        io_bal                = lo_bal
        it_external_criteria  = VALUE #( )
        it_unfiltered_objects = lt_unfiltered_objects
      IMPORTING
        et_filtered_objects   = lt_filtered_objects
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = lt_filtered_objects
      exp   = VALUE ngct_drf_clsmas_object_key( ( klart = '001' class = 'CLS_1' )
                                                ( klart = '001' class = 'CLS_2' )
                                                ( klart = '001' class = 'CLS_3' )
                                                ( klart = '002' class = 'CLS_1' )
                                                ( klart = '002' class = 'CLS_2' )
                                                ( klart = '002' class = 'CLS_3' ) )
      msg   = 'apply_filter: lt_filtered_objects is not valid'
    ).

  ENDMETHOD.

ENDCLASS.