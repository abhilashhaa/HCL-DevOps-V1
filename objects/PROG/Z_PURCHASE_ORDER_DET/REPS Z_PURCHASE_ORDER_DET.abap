*&---------------------------------------------------------------------*
*& Report Z_PURCHASE_ORDER_DETAILS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_purchase_order_det.

TYPES: BEGIN OF ty_purdoc_hdr,
         ebeln TYPE ebeln,
         bukrs TYPE bukrs,
         bstyp TYPE ebstyp,
         bsart TYPE esart,
         statu TYPE estak,
         aedat TYPE erdat,
         ernam TYPE ernam,
         lifnr TYPE elifn,
         waers TYPE waers,
       END OF ty_purdoc_hdr,

       BEGIN OF ty_purdoc_itm,
         ebeln TYPE ebeln,
         ebelp TYPE ebelp,
         matnr TYPE matnr,
         menge TYPE bstmg,
         meins TYPE bstme,
         netwr TYPE bwert,
         brtwr TYPE bbwert,
       END OF ty_purdoc_itm.

DATA: lt_purdoc_hdr TYPE TABLE OF ty_purdoc_hdr,
      ls_purdoc_hdr TYPE ty_purdoc_hdr,

      lt_purdoc_itm TYPE TABLE OF ty_purdoc_itm.

DATA: lo_alv TYPE REF TO cl_salv_table,
      lv_msg TYPE string.

PARAMETERS: p_ebeln TYPE ebeln,

            p_hdr   RADIOBUTTON GROUP g1,
            p_itm   RADIOBUTTON GROUP g1.

PERFORM disp_purdoc_alv USING p_ebeln p_hdr p_itm.

FORM disp_purdoc_alv USING iv_ebeln iv_hdr iv_itm.

  SELECT SINGLE ebeln bukrs bstyp bsart statu aedat  ernam  lifnr waers
    FROM ekko INTO CORRESPONDING FIELDS OF ls_purdoc_hdr
    WHERE ebeln EQ iv_ebeln.

  IF sy-subrc EQ 0.

    APPEND ls_purdoc_hdr TO lt_purdoc_hdr.

    SELECT ebeln ebelp matnr menge meins netwr brtwr
      FROM ekpo INTO CORRESPONDING FIELDS OF TABLE lt_purdoc_itm
      WHERE ebeln EQ iv_ebeln.

    IF sy-subrc EQ 0.

      IF iv_hdr EQ abap_true AND lo_alv IS NOT BOUND.




        TRY.

            CALL METHOD cl_salv_table=>factory
              EXPORTING
                list_display = if_salv_c_bool_sap=>false
              IMPORTING
                r_salv_table = lo_alv
              CHANGING
                t_table      = lt_purdoc_hdr.
          CATCH cx_salv_msg.
        ENDTRY.
        lo_alv->display( ).


      ELSEIF iv_itm EQ abap_true AND lo_alv IS NOT BOUND.
        TRY.
            CALL METHOD cl_salv_table=>factory
              EXPORTING
                list_display = if_salv_c_bool_sap=>false
              IMPORTING
                r_salv_table = lo_alv
              CHANGING
                t_table      = LT_PURDOC_itm.
          CATCH cx_salv_msg.
        ENDTRY.
        lo_alv->display( ).

      ENDIF.
    ELSE.
      MESSAGE e114(gu) INTO lv_msg WITH p_ebeln ##MG_MISSING.
    ENDIF.

  ELSE.
    MESSAGE e114(gu) INTO lv_msg WITH p_ebeln ##MG_MISSING.

  ENDIF.

ENDFORM.

************Unit Test

CLASS ltc_PURCHASE_ORDER_DETAILS DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.

    CLASS-DATA: enviornment TYPE REF TO if_osql_test_environment.
    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.

    METHODS setup.
    METHODS teardown.

    METHODS _01_disp_hdr_alv_pass FOR TESTING.
*    METHODS _02_disp_itm_alv_pass FOR TESTING.
    METHODS _03_disp_hdr_alv_fail_no_data FOR TESTING.
*    METHODS _04_disp_itm_alv_fail_no_data FOR TESTING.

    DATA: mt_ekko TYPE STANDARD TABLE OF ekko,
          mt_ekpo TYPE STANDARD TABLE OF ekpo.

ENDCLASS.

CLASS ltc_PURCHASE_ORDER_DETAILS IMPLEMENTATION.

  METHOD class_setup.

    enviornment = cl_osql_test_environment=>create( i_dependency_list = VALUE #( ( 'EKKO' ) ( 'EKPO' ) ) ).
    DATA: mo_alv_mock TYPE REF TO cl_salv_table.

    TRY.
        CALL METHOD cl_salv_table=>factory
          IMPORTING
            r_salv_table = mo_alv_mock
          CHANGING
            t_table      = lt_purdoc_hdr.
      CATCH cx_salv_msg.
    ENDTRY.
    lo_alv = mo_alv_mock.

  ENDMETHOD.

  METHOD setup.

    mt_ekko = VALUE #(
                     ( ebeln = '1234567890' bukrs = 'BU21' bstyp = 'T' bsart = 'IRON' statu = 'C' aedat = '20210906' ernam = '51876256' lifnr = 'IN19470528' waers = 'INR' )
                     ( ebeln = '1122338899' bukrs = 'BU87' bstyp = 'T' bsart = 'IRON' statu = 'C' aedat = '20210906' ernam = '51876256' lifnr = 'US34069821' waers = 'USD' )
                     ( ebeln = '3200000023' bukrs = 'BU87' bstyp = 'T' bsart = 'IRON' statu = 'C' aedat = '20210906' ernam = '51876256' lifnr = 'US34069821' waers = 'USD' )

                     ).

    mt_ekpo = VALUE #(
    ( ebeln = '1234567890'  ebelp = '0010' matnr = ' MATERIAL_01'  menge = '500' meins = 'PC' netwr = 5000 brtwr = 6000 )
    ( ebeln = '1234567890'  ebelp = '0020' matnr = ' MATERIAL_02'  menge = '400' meins = 'KG' netwr = 6000 brtwr = 7000 )
    ( ebeln = '1234567890'  ebelp = '0030' matnr = ' MATERIAL_03'  menge = '300' meins = 'PC' netwr = 7000 brtwr = 8000 )
    ( ebeln = '1122338899'  ebelp = '0010' matnr = ' MATERIAL_04'  menge = '200' meins = 'KG' netwr = 8000 brtwr = 9000 )
    ( ebeln = '1122338899'  ebelp = '0020' matnr = ' MATERIAL_05'  menge = '100' meins = 'PC' netwr = 9000 brtwr = 9900 )
    ).

    enviornment->insert_test_data( mt_ekko ).
    enviornment->insert_test_data( mt_ekpo ).

  ENDMETHOD.

  METHOD _01_disp_hdr_alv_pass.

    DATA: lt_purdoc_hdr_exp TYPE TABLE OF ty_purdoc_hdr.

    lt_purdoc_hdr_exp = VALUE #(
    ( ebeln = '1122338899' bukrs = 'BU87' bstyp = 'T' bsart = 'IRON' statu = 'C' aedat = '20210906' ernam = '51876256' lifnr = 'US34069821' waers = 'USD' )
    ).
    p_ebeln = '1122338899'.
    p_hdr = abap_true.
    p_itm = abap_false.

    PERFORM disp_purdoc_alv USING p_ebeln p_hdr p_itm.

    cl_abap_unit_assert=>assert_equals(
    EXPORTING
      act = lt_purdoc_hdr
      exp = lt_purdoc_hdr_exp ).

    cl_abap_unit_assert=>assert_initial( lv_msg ).

  ENDMETHOD.

*  METHOD _02_disp_itm_alv_pass.
*
*    DATA: lt_purdoc_itm_exp TYPE TABLE OF ty_purdoc_itm.
*
*    lt_purdoc_itm_exp = VALUE #(
*        ( ebeln = '1234567891' ebelp = '0010' matnr = ' MATERIAL_01'  menge = '500' meins = 'PC' netwr = 5000 brtwr = 6000 )
*( ebeln = '1234567891' ebelp = '0020' matnr = ' MATERIAL_02'  menge = '400' meins = 'KG' netwr = 6000 brtwr = 7000 )
*( ebeln = '1234567891' ebelp = '0030' matnr = ' MATERIAL_03'  menge = '300' meins = 'PC' netwr = 7000 brtwr = 8000 )
*).
*
*    p_ebeln = '1234567890'.
*    p_hdr = abap_false.
*    p_itm = abap_true.
*
*    PERFORM disp_purdoc_alv USING p_ebeln  p_hdr p_itm.
*
*    cl_abap_unit_assert=>assert_equals(
*    EXPORTING
*      act = lt_purdoc_itm
*      exp = lt_purdoc_itm_exp ).
*
*    cl_abap_unit_assert=>assert_initial( lv_msg ).
*
*  ENDMETHOD.

  METHOD _03_disp_hdr_alv_fail_no_data.

    DATA: lv_msg_exp TYPE string VALUE 'Purchase document not found'.
    p_ebeln =   '8921000042'.
    p_hdr = abap_true.
    p_itm = abap_false.

    PERFORM disp_purdoc_alv USING p_ebeln p_hdr p_itm.

    cl_abap_unit_assert=>assert_equals(
    EXPORTING
      act = lv_msg
      exp = lv_msg_exp ).

    cl_abap_unit_assert=>assert_initial( lt_purdoc_hdr ).

  ENDMETHOD.
*
*  METHOD _04_disp_itm_alv_fail_no_data.
*
*    DATA: lv_msg_exp TYPE string VALUE 'No item found for purchase document'.
*
*    p_ebeln =   '3280000823'.
*    p_hdr = abap_true.
*    p_itm = abap_false.
*
*    PERFORM disp_purdoc_alv USING p_ebeln p_hdr p_itm.
*
*    cl_abap_unit_assert=>assert_equals(
*    EXPORTING
*      act = lv_msg
*      exp = lv_msg_exp ).
*
*    cl_abap_unit_assert=>assert_initial( lt_purdoc_itm ).

*  ENDMETHOD.

  METHOD teardown.

    CLEAR lt_purdoc_hdr.
    CLEAR lt_purdoc_itm.

    enviornment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    enviornment->destroy( ).
  ENDMETHOD.

ENDCLASS.