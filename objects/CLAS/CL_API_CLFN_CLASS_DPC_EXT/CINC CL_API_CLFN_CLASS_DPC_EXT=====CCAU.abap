*"* use this source file for your ABAP unit test classes
CLASS ltc_api_clfn_class_dpc_ext DEFINITION DEFERRED.
CLASS cl_api_clfn_class_dpc_ext DEFINITION LOCAL FRIENDS ltc_api_clfn_class_dpc_ext.
CLASS ltc_api_clfn_class_dpc_ext DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.
  PUBLIC SECTION.
    METHODS constructor.
  PRIVATE SECTION.
    DATA mo_cut TYPE REF TO cl_api_clfn_class_dpc_ext.
    METHODS test_charc_get_entity  FOR TESTING.
    METHODS test_charc_get_entityset  FOR TESTING.
ENDCLASS.
CLASS ltc_api_clfn_class_dpc_ext IMPLEMENTATION.
  METHOD constructor.
    me->mo_cut = NEW cl_api_clfn_class_dpc_ext( ).
  ENDMETHOD.
  METHOD test_charc_get_entity.
    " Set rest data for the injection
    TEST-INJECTION classcharc_get_entity.
      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          textid      = /iwbep/cx_mgw_busi_exception=>resource_duplicate
          entity_type = 'A_ClfnClassCharcForKeyDateType'.
    END-TEST-INJECTION.
    TEST-INJECTION classcharc_get_entity_via_set.
      lt_entityset = VALUE #(
      ( classinternalid = '0000028161' charcinternalid = '0000027859' charcpositionnumber = '002' characteristic = 'CH10' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027859' )
      ).
    END-TEST-INJECTION.
    TRY.
        mo_cut->a_clfnclasscharc_get_entity(
          EXPORTING
            iv_entity_name               = 'DUMMY'
            iv_entity_set_name           = 'DUMMY'
            iv_source_name               = 'DUMMY'
            it_key_tab                   = VALUE #(
                                             ( name = 'ClassInternalID' value = '28161' )
                                             ( name = 'CharcInternalID' value = '27859' ) )
            it_navigation_path           = VALUE #( )
          IMPORTING
            er_entity                    = DATA(ls_entityset_act)
        ).
      CATCH /iwbep/cx_mgw_busi_exception ##NO_HANDLER.
      CATCH /iwbep/cx_mgw_tech_exception ##NO_HANDLER.
    ENDTRY.
    cl_abap_unit_assert=>assert_not_initial(
      EXPORTING
        act              = ls_entityset_act
        msg              =  'Class Charc Entityset check failed' ).
  ENDMETHOD.
  METHOD test_charc_get_entityset.
    DATA: lv_filter        TYPE string,
          lv_search        TYPE string,
          lt_entityset_exp TYPE STANDARD TABLE OF cl_api_clfn_class_mpc=>ts_a_clfnclasscharcforkeydatet,
          lt_entityset_act TYPE STANDARD TABLE OF cl_api_clfn_class_mpc=>ts_a_clfnclasscharcforkeydatet.
    " Set test data for the injection
    TEST-INJECTION classcharc_get_entityset.
      et_entityset = VALUE #(
        ( classinternalid = '0000028161' charcinternalid = '0000027859' charcpositionnumber = '001' characteristic = 'CH10' ancestorclassinternalid = '0000028170' originalcharcinternalid = '0000027859' )
        ( classinternalid = '0000028161' charcinternalid = '0000027854' charcpositionnumber = '001' characteristic = 'CH05' ancestorclassinternalid = '0000028165' originalcharcinternalid = '0000027854' )
        ( classinternalid = '0000028161' charcinternalid = '0000027855' charcpositionnumber = '001' characteristic = 'CH06' ancestorclassinternalid = '0000028166' originalcharcinternalid = '0000027855' )
        ( classinternalid = '0000028161' charcinternalid = '0000027852' charcpositionnumber = '001' characteristic = 'CH03' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027852' )
        ( classinternalid = '0000028161' charcinternalid = '0000027859' charcpositionnumber = '002' characteristic = 'CH10' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027859' )
        ( classinternalid = '0000028161' charcinternalid = '0000027856' charcpositionnumber = '003' characteristic = 'CH07' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027856' )
        ( classinternalid = '0000028161' charcinternalid = '0000027812' charcpositionnumber = '001' characteristic = 'CH02' ancestorclassinternalid = '0000028162' originalcharcinternalid = '0000027812' )
        ( classinternalid = '0000028161' charcinternalid = '0000027853' charcpositionnumber = '001' characteristic = 'CH04' ancestorclassinternalid = '0000028164' originalcharcinternalid = '0000027853' )
        ( classinternalid = '0000028161' charcinternalid = '0000027855' charcpositionnumber = '002' characteristic = 'CH06' ancestorclassinternalid = '0000028164' originalcharcinternalid = '0000027855' )
        ( classinternalid = '0000028161' charcinternalid = '0000027856' charcpositionnumber = '001' characteristic = 'CH07' ancestorclassinternalid = '0000028167' originalcharcinternalid = '0000027856' )
        ( classinternalid = '0000028161' charcinternalid = '0000027858' charcpositionnumber = '001' characteristic = 'CH09' ancestorclassinternalid = '0000028169' originalcharcinternalid = '0000027858' )
        ( classinternalid = '0000028161' charcinternalid = '0000027857' charcpositionnumber = '001' characteristic = 'CH08' ancestorclassinternalid = '0000028168' originalcharcinternalid = '0000027857' )
        ( classinternalid = '0000028161' charcinternalid = '0000027811' charcpositionnumber = '001' characteristic = 'CH01' ancestorclassinternalid = '0000028161' originalcharcinternalid = '0000027811' )
        ( classinternalid = '0000028161' charcinternalid = '0000027858' charcpositionnumber = '002' characteristic = 'CH09' ancestorclassinternalid = '0000028161' originalcharcinternalid = '0000027858' )
      ).
    END-TEST-INJECTION.
    TRY.
        mo_cut->a_clfnclasscharc_get_entityset(
          EXPORTING
            iv_entity_name               = 'DUMMY'
            iv_entity_set_name           = 'DUMMY'
            iv_source_name               = 'DUMMY'
            it_filter_select_options     = VALUE #( )
            is_paging                    = VALUE #( )
            it_key_tab                   = VALUE #( )
            it_navigation_path           = VALUE #( )
            it_order                     = VALUE #( )
            iv_filter_string             = lv_filter
            iv_search_string             = lv_search
          IMPORTING
            et_entityset                 = lt_entityset_act
        ).
      CATCH /iwbep/cx_mgw_busi_exception ##NO_HANDLER.
      CATCH /iwbep/cx_mgw_tech_exception ##NO_HANDLER.
    ENDTRY.
    lt_entityset_exp = VALUE #(
      ( classinternalid = '0000028161' charcinternalid = '0000027854' charcpositionnumber = '001' characteristic =  'CH05' ancestorclassinternalid = '0000028165' originalcharcinternalid = '0000027854' )
      ( classinternalid = '0000028161' charcinternalid = '0000027852' charcpositionnumber = '001' characteristic =  'CH03' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027852' )
      ( classinternalid = '0000028161' charcinternalid = '0000027859' charcpositionnumber = '002' characteristic =  'CH10' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027859' )
      ( classinternalid = '0000028161' charcinternalid = '0000027856' charcpositionnumber = '003' characteristic =  'CH07' ancestorclassinternalid = '0000028163' originalcharcinternalid = '0000027856' )
      ( classinternalid = '0000028161' charcinternalid = '0000027812' charcpositionnumber = '001' characteristic =  'CH02' ancestorclassinternalid = '0000028162' originalcharcinternalid = '0000027812' )
      ( classinternalid = '0000028161' charcinternalid = '0000027853' charcpositionnumber = '001' characteristic =  'CH04' ancestorclassinternalid = '0000028164' originalcharcinternalid = '0000027853' )
      ( classinternalid = '0000028161' charcinternalid = '0000027855' charcpositionnumber = '002' characteristic =  'CH06' ancestorclassinternalid = '0000028164' originalcharcinternalid = '0000027855' )
      ( classinternalid = '0000028161' charcinternalid = '0000027857' charcpositionnumber = '001' characteristic =  'CH08' ancestorclassinternalid = '0000028168' originalcharcinternalid = '0000027857' )
      ( classinternalid = '0000028161' charcinternalid = '0000027811' charcpositionnumber = '001' characteristic =  'CH01' ancestorclassinternalid = '0000028161' originalcharcinternalid = '0000027811' )
      ( classinternalid = '0000028161' charcinternalid = '0000027858' charcpositionnumber = '002' characteristic =  'CH09' ancestorclassinternalid = '0000028161' originalcharcinternalid = '0000027858' )
    ).
    SORT lt_entityset_exp ASCENDING BY classinternalid charcinternalid.
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lt_entityset_act
        exp = lt_entityset_exp
        msg = 'Class Charc Entityset check failed' ).
  ENDMETHOD.
ENDCLASS.