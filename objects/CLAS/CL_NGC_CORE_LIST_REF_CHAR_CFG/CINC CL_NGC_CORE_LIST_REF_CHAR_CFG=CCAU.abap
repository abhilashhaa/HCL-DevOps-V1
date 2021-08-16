CLASS lth_ngc_core_list_ref_char_cfg DEFINITION FINAL.

  PUBLIC SECTION.

    CLASS-DATA:
      gt_cabn          TYPE STANDARD TABLE OF cabn,
      gt_cabnz         TYPE STANDARD TABLE OF cabnz,
      gt_ausp          TYPE STANDARD TABLE OF ausp,
      gt_inob          TYPE STANDARD TABLE OF inob,
      gt_tcla          TYPE STANDARD TABLE OF tcla,
      gt_tclao         TYPE STANDARD TABLE OF tclao,
      gt_mara          TYPE STANDARD TABLE OF mara,
      gt_ibinown       TYPE STANDARD TABLE OF ibinown,
      gt_ibsymbol      TYPE STANDARD TABLE OF ibsymbol,
      gt_ibinvalues    TYPE STANDARD TABLE OF ibinvalues,
      gt_ibin          TYPE STANDARD TABLE OF ibin,
      gt_ibst          TYPE STANDARD TABLE OF ibst,
      gt_valuations    TYPE cl_ngc_core_list_ref_char_cfg=>ty_t_valuation,
      gt_config_owners TYPE cl_ngc_core_list_ref_char_cfg=>ty_t_config_owners,
      gt_t371f         TYPE STANDARD TABLE OF t371f.

    CLASS-METHODS: class_constructor.

ENDCLASS.

CLASS lth_ngc_core_list_ref_char_cfg IMPLEMENTATION.

  METHOD class_constructor.

    gt_cabn = VALUE #( ( atinn = '0000000001'
                         lkenz = ' '
                         atxac = ' '
                         attab = 'MARA' )
                       ( atinn = '0000000002'
                         lkenz = ' '
                         atxac = 'X' )
                       ( atinn = '0000000003'
                         lkenz = ' '
                         atxac = 'X' ) ).

    gt_cabnz = VALUE #( ( atinn = '0000000002'
                          attab = 'MAKT' )
                        ( atinn = '0000000003'
                          attab = 'CABN' ) ).

    gt_ausp = VALUE #( ( atinn = '0000000001'
                         objek = '000000000000000001'
                         klart = '001'
                         mafid = 'O'
                         atwrt = 'TESTMAT1'
                         atflv = ''
                         atflb = ''
                         atcod = '1' )
                       ( atinn = '0000000002'
                         objek = '000000000000000002'
                         klart = '002'
                         mafid = 'O'
                         atwrt = 'TESTMAT2'
                         atflv = ''
                         atflb = ''
                         atcod = '1' )
                       ( atinn = '0000000003'
                         objek = '000000000000000003'
                         klart = '003'
                         mafid = 'O'
                         atwrt = 'TESTMAT3'
                         atflv = ''
                         atflb = ''
                         atcod = '1' ) ).

    gt_inob = VALUE #( ( cuobj = '000000000000000001'
                         klart = '001'
                         obtab = 'MARA'
                         objek = 'A' )
                       ( cuobj = '000000000000000002'
                         klart = '002'
                         obtab = 'MARA'
                         objek = 'B' )
                       ( cuobj = '000000000000000003'
                         klart = '003'
                         obtab = 'MARA'
                         objek = 'C' ) ).

    gt_tcla = VALUE #( ( klart    = '001'
                         multobj  = 'X'
                         varklart = 'X' )
                       ( klart    = '002'
                         multobj  = 'X'
                         varklart = 'X' )
                       ( klart    = '003'
                         multobj  = 'X'
                         varklart = 'X' ) ).

    gt_tclao = VALUE #( ( klart = '001'
                          zaehl = '01'
                          obtab = 'MARA' )
                        ( klart = '002'
                          zaehl = '01'
                          obtab = 'MARA' )
                        ( klart = '003'
                          zaehl = '00'
                          obtab = 'MARA' ) ).

    gt_mara  = VALUE #( ( matnr = 'A'
                          kzkfg = 'X' )
                        ( matnr = 'B'
                          kzkfg = 'X' )
                        ( matnr = 'C'
                          kzkfg = 'X' ) ).

    gt_ibinown = VALUE #( ( instance = '000000000000000001'
                            inttyp   = '0001'
                            objkey   = 'IBINOWN_OBJKEY' ) ).

    gt_ibsymbol = VALUE #( ( symbol_id = '000000000001'
                             atinn     = '0000000001'
                             atwrt     = 'TESTMAT1'
                             atflv     = ''
                             atflb     = ''
                             atcod     = '1' ) ).

    gt_ibinvalues = VALUE #( ( in_recno  = '0000000000000000000001'
                               symbol_id = '000000000001'
                               ataut     = '3' ) ).

    gt_ibin = VALUE #( ( instance = '000000000000000001'
                         in_recno = '0000000000000000000001'
                         objnr    = 'MAA' ) ).

    gt_ibst = VALUE #( ( instance = '000000000000000001'
                         root     = '000000000000000001' ) ).

    gt_valuations = VALUE #( ( obtab = 'MARA'
                               objek = 'A'
                               objnr = 'MAA'
                               cuobj = '000000000000000001'
                               atinn = '0000000001'
                               atwrt = 'TESTMAT1'
                               atflv = ''
                               atflb = ''
                               atcod = '1' )
                             ( obtab = 'MARA'
                               objek = 'B'
                               objnr = 'MAB'
                               cuobj = '000000000000000002'
                               atinn = '0000000002'
                               atwrt = 'TESTMAT2'
                               atflv = ''
                               atflb = ''
                               atcod = '1' ) ).

    gt_config_owners = VALUE #( ( instance = '000000000000000001'
                                  inttyp   = '0001'
                                  objkey   = 'IBINOWN_OBJKEY'
                                  atinn    = '0000000001'
                                  atwrt    = 'TESTMAT1'
                                  atflv    = ''
                                  atflb    = ''
                                  atcod    = '1' ) ).

    gt_t371f = VALUE #( ( inttyp = '0001'
                          objtyp = 'TESTOBJTYP' ) ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_ngc_core_list_ref_char_cfg DEFINITION FOR TESTING FINAL
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    CLASS-DATA: go_osql_environment TYPE REF TO if_osql_test_environment.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: get_valuations FOR TESTING.
    METHODS: get_config_owners FOR TESTING.
    METHODS: get_config_owners_empty FOR TESTING.
    METHODS: get_config_owners_notexist FOR TESTING.
    METHODS: get_objtyp_ext_by_int FOR TESTING.
    METHODS: get_objtyp_ext_by_int_notexist FOR TESTING.
ENDCLASS.


CLASS ltc_ngc_core_list_ref_char_cfg IMPLEMENTATION.

  METHOD class_setup.

    go_osql_environment = cl_osql_test_environment=>create(
      i_dependency_list = VALUE #( ( 'CABN'       )
                                   ( 'CABNZ'      )
                                   ( 'AUSP'       )
                                   ( 'INOB'       )
                                   ( 'TCLA'       )
                                   ( 'TCLAO'      )
                                   ( 'MARA'       )
                                   ( 'IBINOWN'    )
                                   ( 'IBSYMBOL'   )
                                   ( 'IBINVALUES' )
                                   ( 'IBIN'       )
                                   ( 'IBST'       )
                                   ( 'T371F'      ) )
    ).

  ENDMETHOD.

  METHOD class_teardown.

    go_osql_environment->destroy( ).

  ENDMETHOD.

  METHOD setup.

    go_osql_environment->clear_doubles( ).

    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_cabn ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_cabnz ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ausp ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_inob ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_tcla ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_tclao ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_mara ).

    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ibinown ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ibsymbol ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ibinvalues ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ibin ).
    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_ibst ).

    go_osql_environment->insert_test_data( lth_ngc_core_list_ref_char_cfg=>gt_t371f ).

  ENDMETHOD.

  METHOD get_valuations.

    " Given: 2 relevant valuation data, and 1 which is not relevant.
    " When: the list of valuations is retrieved.
    DATA(lt_valuations) = cl_ngc_core_list_ref_char_cfg=>get_valuations( ).

    " Then: two relevant rows are returned.
    cl_abap_unit_assert=>assert_equals(
      act   = lines( lt_valuations )
      exp   = 2
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_valuations
      exp = lth_ngc_core_list_ref_char_cfg=>gt_valuations
    ).

  ENDMETHOD.

  METHOD get_config_owners.

    " Given: 2 relevant valuation data, and 1 which is not relevant,
    " and there is 1 configuration owner entry for the first valuation.
    " When: the list of configuration owners is retrieved for the relevant valuations.
    DATA(lt_config_owners) = cl_ngc_core_list_ref_char_cfg=>get_config_owners( lth_ngc_core_list_ref_char_cfg=>gt_valuations ).

    " Then: one relevant configuration owner data row is returned.
    cl_abap_unit_assert=>assert_equals(
      act   = lines( lt_config_owners )
      exp   = 1
    ).

    cl_abap_unit_assert=>assert_equals(
      act = lt_config_owners
      exp = lth_ngc_core_list_ref_char_cfg=>gt_config_owners
    ).

  ENDMETHOD.

  METHOD get_config_owners_empty.

    " Given: 2 relevant valuation data, and 1 which is not relevant,
    " and there is 1 configuration owner entry for the first valuation.

    " When: the list of configuration owners is retrieved without providing valuation data.
    DATA(lt_config_owners) = cl_ngc_core_list_ref_char_cfg=>get_config_owners( VALUE #( ) ).

    " Then: no configuration owners data is returned.
    cl_abap_unit_assert=>assert_initial( lt_config_owners ).

  ENDMETHOD.

  METHOD get_config_owners_notexist.

    " Given: 2 relevant valuation data, and 1 which is not relevant,
    " and there is 1 configuration owner entry for the first valuation.
    " When: the list of configuration owners is retrieved for a valuation for which
    " no configuration owner data exists.
    DATA(lt_config_owners) = cl_ngc_core_list_ref_char_cfg=>get_config_owners( VALUE #( ( lth_ngc_core_list_ref_char_cfg=>gt_valuations[ 2 ] ) ) ).

    " Then: no configuration owners data is returned.
    cl_abap_unit_assert=>assert_initial( lt_config_owners ).

  ENDMETHOD.

  METHOD get_objtyp_ext_by_int.

    " Given: the configuration customizing setup.
    " When: the external object type is retrieved for an existing internal object type.
    DATA(lv_objtyp_ext) = cl_ngc_core_list_ref_char_cfg=>get_objtyp_ext_by_int( '0001' ).

    " Then: the correct external configuration owners data is returned.
    cl_abap_unit_assert=>assert_equals(
      act   = lv_objtyp_ext
      exp   = 'TESTOBJTYP'
    ).

  ENDMETHOD.

  METHOD get_objtyp_ext_by_int_notexist.

    " Given: the configuration customizing setup.
    " When: the external object type is retrieved for a non-existing internal object type.
    DATA(lv_objtyp_ext) = cl_ngc_core_list_ref_char_cfg=>get_objtyp_ext_by_int( '9999' ).

    " Then: the correct external configuration owners data is returned.
    cl_abap_unit_assert=>assert_initial( lv_objtyp_ext ).

  ENDMETHOD.

ENDCLASS.