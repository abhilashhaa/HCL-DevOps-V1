CLASS ltd_selection_util DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES lif_selection_util.
ENDCLASS.

CLASS ltd_selection_util IMPLEMENTATION.
  METHOD lif_selection_util~free_selections_range_2_where.
    where_clauses = VALUE #( ( tablename = 'KSSK' where_tab = VALUE #( ( line = '    ( KSSK~KLART EQ ''001'' )' ) ) ) ).
  ENDMETHOD.
ENDCLASS.


CLASS ltc_ngc_drf_util DEFINITION DEFERRED.
CLASS cl_ngc_drf_util DEFINITION LOCAL FRIENDS ltc_ngc_drf_util.

CLASS ltc_ngc_drf_util DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA:
      f_cut   TYPE REF TO cl_ngc_drf_util,  "class under test
      lt_klah TYPE STANDARD TABLE OF klah WITH EMPTY KEY,
      lt_cabn TYPE STANDARD TABLE OF cabn WITH EMPTY KEY.

    CLASS-DATA: sql_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_instance FOR TESTING.
    METHODS: get_selected_classifications FOR TESTING.
    METHODS: get_selected_classes FOR TESTING.
    METHODS: get_selected_characteristics FOR TESTING.
ENDCLASS.       "ltc_ngc_drf_util


CLASS ltc_ngc_drf_util IMPLEMENTATION.

  METHOD class_setup.
    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'KLAH' )
                                                                                     ( 'CABN' ) ) ).
  ENDMETHOD.


  METHOD class_teardown.
    sql_environment->destroy( ).
  ENDMETHOD.


  METHOD setup.
    CREATE OBJECT f_cut.
    CREATE OBJECT f_cut->mo_selection_util TYPE ltd_selection_util.
    sql_environment->clear_doubles( ).
  ENDMETHOD.


  METHOD teardown.
  ENDMETHOD.


  METHOD get_instance.

    DATA(lo_cut) = cl_ngc_drf_util=>get_instance( ).

    cl_abap_unit_assert=>assert_bound(
      act = lo_cut
      msg = 'get_instance: RO_INSTANCE is not valid'
    ).

  ENDMETHOD.


  METHOD get_selected_classifications.

    DATA:
      et_clf_key TYPE ngct_drf_clfmas_object_key.

    TEST-INJECTION select_tcla_range.
      et_tcla = VALUE #( ( klart = '001' obtab = 'MARA' multobj = space ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_tcla.
      et_tcla = VALUE #( ( klart = '001' obtab = 'MARA' multobj = space ) ).
    END-TEST-INJECTION.

    TEST-INJECTION select_kssk.
      et_classification = VALUE #( ( objek = 'HARRI_COMPUTER_1'
                                     klart = '001'
                                     mafid = 'O'
                                     datuv = '00000000'
                                     obtab = 'MARA' ) ).
    END-TEST-INJECTION.

    f_cut->if_ngc_drf_util~get_selected_classifications(
      EXPORTING
        it_selection_criteria = VALUE #(
                                  ( tablename = 'KSSK'
                                    frange_t  = VALUE #(
                                      ( fieldname = 'KLART'
                                        selopt_t  = VALUE #(
                                          ( sign = 'I' option = 'EQ' low = '001' )
                                        )
                                      )
                                    )
                                  )
                                )
      IMPORTING
        et_clf_key            = et_clf_key
    ).

    cl_abap_unit_assert=>assert_equals(
      act = et_clf_key
      exp = VALUE ngct_drf_clfmas_object_key( ( object_table = 'MARA'
                                                klart        = '001'
                                                objkey       = 'HARRI_COMPUTER_1' ) )
      msg = 'get_selected_classifications: ET_CLF_KEY is not valid'
    ).

  ENDMETHOD.

  METHOD get_selected_classes.

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

    f_cut->if_ngc_drf_util~get_selected_classes(
      EXPORTING
        it_range_klart = VALUE #( ( sign = 'I' option = 'EQ' low = '001' ) )
        it_range_class = VALUE #( ( sign = 'I' option = 'EQ' low = 'CLS_1' ) )
      IMPORTING
        et_cls_key     = DATA(lt_cls_key)
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_cls_key
      exp = VALUE ngct_drf_clsmas_object_key( ( klart = '001' class = 'CLS_1' ) )
      msg = 'get_selected_characteristic: LT_CHR_KEY is not valid'
    ).

  ENDMETHOD.

  METHOD get_selected_characteristics.

    lt_cabn = VALUE #( ( mandt = sy-mandt atinn = '0000000001' adzhl = '0000' atnam = '' )
                       ( mandt = sy-mandt atinn = '0000000002' adzhl = '0000' atnam = 'CHR_1' )
                       ( mandt = sy-mandt atinn = '0000000003' adzhl = '0000' atnam = 'CHR_2' )
                       ( mandt = sy-mandt atinn = '0000000004' adzhl = '0000' atnam = 'CHR_3' ) ).

    sql_environment->insert_test_data( lt_cabn ).

    f_cut->if_ngc_drf_util~get_selected_characteristics(
      EXPORTING
        it_range_atnam = VALUE #( ( sign = 'I' option = 'EQ' low = 'CHR_1' ) )
      IMPORTING
        et_chr_key     = DATA(lt_chr_key)
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_chr_key
      exp = VALUE ngct_drf_chrmas_object_key( ( atnam = 'CHR_1' ) )
      msg = 'get_selected_characteristic: LT_CHR_KEY is not valid'
    ).

  ENDMETHOD.

ENDCLASS.