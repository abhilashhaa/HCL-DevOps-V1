**"* use this source file for your ABAP unit test classes

CLASS ltc_ngc_chrmas_drf_filter DEFINITION DEFERRED.
CLASS cl_ngc_drf_chrmas_filter DEFINITION LOCAL FRIENDS ltc_ngc_chrmas_drf_filter.

CLASS ltc_ngc_chrmas_drf_filter DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut   TYPE REF TO cl_ngc_drf_chrmas_filter.  "class under test

    CLASS-DATA: sql_environment TYPE REF TO if_osql_test_environment.
    CLASS-DATA: lt_cabn TYPE STANDARD TABLE OF cabn WITH EMPTY KEY.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: apply_filter_chr_1 FOR TESTING.
    METHODS: apply_filter_all FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_chrmas_drf_filter IMPLEMENTATION.

  METHOD class_setup.
    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'CABN' ) ) ).
    lt_cabn = VALUE #( ( mandt = sy-mandt atinn = '0000000001' adzhl = '0000' atnam = '' )
                       ( mandt = sy-mandt atinn = '0000000002' adzhl = '0000' atnam = 'CHR_1' )
                       ( mandt = sy-mandt atinn = '0000000003' adzhl = '0000' atnam = 'CHR_2' )
                       ( mandt = sy-mandt atinn = '0000000004' adzhl = '0000' atnam = 'CHR_3' ) ).
    sql_environment->insert_test_data( lt_cabn ).
  ENDMETHOD.

  METHOD class_teardown.
    sql_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
    CREATE OBJECT f_cut.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD apply_filter_chr_1.

    DATA:
      lo_bal                TYPE REF TO cl_drf_bal,
      lt_unfiltered_objects TYPE ngct_drf_chrmas_object_key,
      lt_filtered_objects   TYPE ngct_drf_chrmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CHRMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( strucname = 'NGCS_DRF_CHRMAS_OBJECT_KEY' )
        io_bal                = lo_bal
        it_external_criteria  = VALUE #(
                                  ( tablename = 'NGCS_DRF_CHRMAS_OBJECT_KEY'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'ATNAM'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = 'CHR_1' )
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
      exp   = VALUE ngct_drf_chrmas_object_key( ( atnam = 'CHR_1' ) )
      msg   = 'apply_filter: lt_filtered_objects is not valid'
    ).

  ENDMETHOD.

  METHOD apply_filter_all.

    DATA:
      lo_bal                TYPE REF TO cl_drf_bal,
      lt_unfiltered_objects TYPE ngct_drf_chrmas_object_key,
      lt_filtered_objects   TYPE ngct_drf_chrmas_object_key.

    f_cut->if_drf_filter~apply_filter(
      EXPORTING
        iv_appl               = ''
        iv_business_system    = ''
        is_c_fobj             = VALUE #( )
        iv_outb_impl          = 'CLF_CHRMAS'
        iv_dlmod              = ''
        iv_runmod             = ''
        is_filt               = VALUE #( )
        io_bal                = lo_bal
        it_external_criteria  = VALUE #( )
        it_unfiltered_objects = lt_unfiltered_objects
*       IS_ADDITIONAL_PARAMETER =
      IMPORTING
        et_filtered_objects   = lt_filtered_objects
    ).

    cl_abap_unit_assert=>assert_equals(
      act   = lt_filtered_objects
      exp   = VALUE ngct_drf_chrmas_object_key( ( atnam = 'CHR_1' )
                                                ( atnam = 'CHR_2' )
                                                ( atnam = 'CHR_3' ) )
      msg   = 'apply_filter: elt_filtered_objects is not valid'
    ).

  ENDMETHOD.

ENDCLASS.