*&---------------------------------------------------------------------*
*& Include          LNGC_INT_IRFT99
*&---------------------------------------------------------------------*
CLASS ltc_irf DEFINITION FINAL FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    CONSTANTS:
      lc_equi       TYPE equnr      VALUE '!TST_EQUI!',
      lc_matnr      TYPE matnr      VALUE '!TST_MATNR!',
      lc_charg      TYPE charg_d    VALUE '!TST_CHRG!',
      lc_cuobj_equi TYPE cuobj      VALUE '000000000000000001',
      lc_cuobj_mch1 TYPE cuobj      VALUE '000000000000000002',
      lc_klart_001  TYPE klassenart VALUE '001',
      lc_klart_023  TYPE klassenart VALUE '023',
      lc_obtab_equi TYPE tabelle    VALUE 'EQUI',
      lc_obtab_mch1 TYPE tabelle    VALUE 'MCH1',
      lc_class      TYPE klasse_d   VALUE 'TEST_CLASS',
      lc_clint      TYPE clint      VALUE '0000000001',
      lc_atinn      TYPE atinn      VALUE '0000000001',
      lc_atnam      TYPE atnam      VALUE 'CHAR_1',
      lc_mafid      TYPE klmaf      VALUE 'O',
      lc_posnr      TYPE c LENGTH 3 VALUE '001',
      lc_atwrt      TYPE atwrt      VALUE 'VALUE_1'
      .
    DATA: lv_action TYPE  char1,
          lv_done   TYPE  abap_bool,
          lv_rows   TYPE  gss_count,
          lt_data   TYPE  gss_t_transfer.

    CLASS-DATA: sql_environment TYPE REF TO if_osql_test_environment,
                lt_klah         TYPE STANDARD TABLE OF klah   WITH EMPTY KEY,
                lt_tcla         TYPE STANDARD TABLE OF tcla   WITH EMPTY KEY,
                lt_tclao        TYPE STANDARD TABLE OF tclao  WITH EMPTY KEY,
                lt_inob         TYPE STANDARD TABLE OF inob   WITH EMPTY KEY,
                lt_kssk         TYPE STANDARD TABLE OF kssk   WITH EMPTY KEY,
                lt_ksml         TYPE STANDARD TABLE OF ksml   WITH EMPTY KEY,
                lt_ausp         TYPE STANDARD TABLE OF ausp   WITH EMPTY KEY,
                lt_cabn         TYPE STANDARD TABLE OF cabn   WITH EMPTY KEY.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_clf_data_for_equi FOR TESTING.
    METHODS: get_clf_data_for_mch1 FOR TESTING.

ENDCLASS.

CLASS ltc_irf IMPLEMENTATION.

  METHOD class_setup.
    sql_environment = cl_osql_test_environment=>create( i_dependency_list = VALUE #(
                                                                                     ( 'KLAH' )
                                                                                     ( 'TCLA' )
                                                                                     ( 'TCLAO' )
                                                                                     ( 'INOB' )
                                                                                     ( 'KSSK' )
                                                                                     ( 'KSML' )
                                                                                     ( 'AUSP' )
                                                                                     ( 'CABN' )
                                                                                                ) ).

    lt_klah = VALUE #( ( mandt = sy-mandt
                         clint = lc_clint
                         klart = lc_klart_001
                         class = lc_class ) ).
    sql_environment->insert_test_data( lt_klah ).

    lt_tcla = VALUE #( ( mandt   = sy-mandt
                         klart   = lc_klart_001
                         obtab   = lc_obtab_equi
                         multobj = abap_true ) ).
    sql_environment->insert_test_data( lt_tcla ).

    lt_tclao = VALUE #( ( mandt = sy-mandt
                          klart = lc_klart_001
                          obtab = lc_obtab_equi ) ).
    sql_environment->insert_test_data( lt_tclao ).

    lt_inob = VALUE #( ( mandt = sy-mandt
                         cuobj = lc_cuobj_equi
                         klart = lc_klart_001
                         obtab = lc_obtab_equi
                         objek = lc_equi ) ).
    sql_environment->insert_test_data( lt_inob ).

    lt_kssk = VALUE #( ( mandt = sy-mandt
                         objek = lc_cuobj_equi
                         mafid = lc_mafid
                         klart = lc_klart_001
                         clint = lc_clint ) ).
    sql_environment->insert_test_data( lt_kssk ).

    lt_ksml = VALUE #( ( mandt = sy-mandt
                         clint = lc_clint
                         posnr = lc_posnr
                         imerk = lc_atinn
                         klart = lc_klart_001 ) ).
    sql_environment->insert_test_data( lt_ksml ).

    lt_ausp = VALUE #( ( mandt = sy-mandt
                         objek = lc_cuobj_equi
                         atinn = lc_atinn
                         atzhl = lc_posnr
                         mafid = lc_mafid
                         klart = lc_klart_001
                         atwrt = lc_atwrt ) ).
    sql_environment->insert_test_data( lt_ausp ).

    lt_cabn = VALUE #( ( mandt = sy-mandt
                         atinn = lc_atinn
                         atnam = lc_atnam ) ).
    sql_environment->insert_test_data( lt_cabn ).

  ENDMETHOD.

  METHOD class_teardown.
    sql_environment->destroy( ).
  ENDMETHOD.

  METHOD setup.
  ENDMETHOD.

  METHOD teardown.
  ENDMETHOD.

  METHOD get_clf_data_for_equi.

    DATA lt_or_seltab TYPE  gtb_t_or_clause.

    APPEND INITIAL LINE TO lt_or_seltab ASSIGNING FIELD-SYMBOL(<sel>).
    <sel>-pos = 1.
    APPEND INITIAL LINE TO <sel>-seltab ASSIGNING FIELD-SYMBOL(<single_sel>).
    <single_sel>-field  = 'OBJEK'.
    <single_sel>-sign   = 'I'.
    <single_sel>-option = 'EQ'.
    <single_sel>-low    = lc_equi.

    CALL FUNCTION 'NGC_IRF_EQUI'
      EXPORTING
        i_tab        = 'EQUI'
        i_add_tab    = 'AUSP'
        i_event      = 'D'
        i_father_id  = 1
      IMPORTING
        e_action     = lv_action
        e_rows       = lv_rows
        e_done       = lv_done
        e_data       = lt_data
      CHANGING
        it_or_seltab = lt_or_seltab.

    cl_abap_unit_assert=>assert_equals( act = lv_action
                                        exp = 'F' ).

    cl_abap_unit_assert=>assert_equals( act = lv_rows
                                        exp = 1 ).

    cl_abap_unit_assert=>assert_true( lv_done ).

*    cl_abap_unit_assert=>assert_equals( act = lt_data
*                                        exp = value gss_t_transfer( ( tabname           = 'AUSP'
*                                                                      fieldname         = lc_atnam
*                                                                      scrtext_l         = lc_atnam
*                                                                      fieldvalue        = lc_atwrt
*                                                                      exit_dep_father   = 1 ) ) ).

  ENDMETHOD.

  METHOD get_clf_data_for_mch1.

    DATA: lt_or_seltab TYPE  gtb_t_or_clause,
          lt_mch1      TYPE TABLE OF mch1,
          lr_data      TYPE REF TO data.

    APPEND INITIAL LINE TO lt_or_seltab ASSIGNING FIELD-SYMBOL(<sel>).
    <sel>-pos = 1.
    APPEND INITIAL LINE TO <sel>-seltab ASSIGNING FIELD-SYMBOL(<single_sel>).
    <single_sel>-field  = 'OBJEK'.
    <single_sel>-sign   = 'I'.
    <single_sel>-option = 'EQ'.
    <single_sel>-low    = lc_charg.
    APPEND INITIAL LINE TO <sel>-seltab ASSIGNING <single_sel>.
    <single_sel>-field  = 'OBJEK'.
    <single_sel>-sign   = 'I'.
    <single_sel>-option = 'EQ'.
    <single_sel>-low    = lc_matnr.

    APPEND INITIAL LINE TO lt_mch1 ASSIGNING FIELD-SYMBOL(<ls_mch1>).
    <ls_mch1>-matnr = lc_matnr.
    <ls_mch1>-charg = lc_charg.
    GET REFERENCE OF lt_mch1 INTO lr_data.

    CALL FUNCTION 'NGC_IRF_MCH1'
      EXPORTING
        i_tab        = 'MCH1'
        i_add_tab    = 'AUSP'
        i_event      = 'D'
        i_father_id  = 1
        i_data_ref   = lr_data
      IMPORTING
        e_action     = lv_action
        e_rows       = lv_rows
        e_done       = lv_done
        e_data       = lt_data
      CHANGING
        it_or_seltab = lt_or_seltab.

    cl_abap_unit_assert=>assert_equals( act = lv_action
                                        exp = 'F' ).

    cl_abap_unit_assert=>assert_equals( act = lv_rows
                                        exp = 0 ).

    cl_abap_unit_assert=>assert_true( lv_done ).

*    cl_abap_unit_assert=>assert_equals( act = lt_data
*                                        exp = value gss_t_transfer( ( tabname           = 'AUSP'
*                                                                      fieldname         = lc_atnam
*                                                                      scrtext_l         = lc_atnam
*                                                                      fieldvalue        = lc_atwrt
*                                                                      exit_dep_father   = 1 ) ) ).

  ENDMETHOD.

ENDCLASS.