CLASS ltc_date_check_valid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_date DEFINITION LOCAL FRIENDS ltc_date_check_valid.

CLASS ltc_date_check_valid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_date.

    METHODS:
      setup.

    METHODS:
      single             FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval           FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval    FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval_to FOR TESTING RAISING cx_ngc_core_chr_exception,
      leap_year          FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_date_check_valid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_date=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

  ENDMETHOD.

  METHOD single.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromdate TYPE auspext_date_from,
      lv_charctodate   TYPE auspext_date_to,
      lv_string_from   TYPE string,
      lv_string_to     TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromdate = '20100210'.
    lv_string_from = lv_charcfromdate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype  = if_ngc_c=>gc_charcdatatype-date )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.

  METHOD interval.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charcfromdate          TYPE auspext_date_from,
      lv_charctodate            TYPE auspext_date_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    lv_charcfromdate = '20141201'.
    lv_string_from = lv_charcfromdate.

    lv_charcfromdate = '20141202'.
    lv_string_to = lv_charcfromdate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue   = lv_string_to ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = |'No messages expected, dependency: { <lv_charc_value_dependency> }'| ).
    ENDLOOP.

  ENDMETHOD.

  METHOD single_interval.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charcfromdate          TYPE auspext_date_from,
      lv_string_from            TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '8' ) ( '9' ) ).

    lv_charcfromdate = '19920229'.
    lv_string_from = lv_charcfromdate.

    ls_charc_value = VALUE #( charcfromnumericvalue = lv_string_from ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = |'No messages expected, dependency: { <lv_charc_value_dependency> }'| ).
    ENDLOOP.

  ENDMETHOD.

  METHOD single_interval_to.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charctodate            TYPE auspext_date_from,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    lv_charctodate = '19920229'.
    lv_string_to = lv_charctodate.

    ls_charc_value = VALUE #( charctonumericvalue = lv_string_to ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_initial(
        act = lt_message
        msg = |'No messages expected, dependency: { <lv_charc_value_dependency> }'| ).
    ENDLOOP.

  ENDMETHOD.

  METHOD leap_year.

    DATA:
      ls_charc_value    TYPE ngcs_core_charc_value,
      lv_charcfromdate  TYPE auspext_date_from,
      lv_string_from    TYPE string,
      ls_valuation_data TYPE ngcs_core_valuation_data.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromdate = '19920229'.
    lv_string_from = lv_charcfromdate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype  = if_ngc_c=>gc_charcdatatype-date )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_initial(
      act = lt_message
      msg = 'No messages expected' ).

  ENDMETHOD.

ENDCLASS.

CLASS ltc_date_check_invalid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_date DEFINITION LOCAL FRIENDS ltc_date_check_invalid.

CLASS ltc_date_check_invalid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_date.

    METHODS:
      setup.

    METHODS:
      data_type            FOR TESTING,
      chr_val_dep          FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_values      FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data          FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_to       FOR TESTING RAISING cx_ngc_core_chr_exception,
      multi_char_val_dep   FOR TESTING RAISING cx_ngc_core_chr_exception,
      months               FOR TESTING RAISING cx_ngc_core_chr_exception,
      days                 FOR TESTING RAISING cx_ngc_core_chr_exception.
ENDCLASS.

CLASS ltc_date_check_invalid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_date=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

  ENDMETHOD.

  METHOD data_type.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value,
      lt_data_type   TYPE STANDARD TABLE OF atfor.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_data_type = VALUE #(
      ( if_ngc_c=>gc_charcdatatype-char )
      ( if_ngc_c=>gc_charcdatatype-time )
      ( if_ngc_c=>gc_charcdatatype-num )
      ( if_ngc_c=>gc_charcdatatype-curr ) ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    LOOP AT lt_data_type ASSIGNING FIELD-SYMBOL(<ls_data_type>).
      TRY.
          mo_cut->if_ngc_core_chr_value_check~check_value(
            EXPORTING
              is_charc_header   = VALUE #( charcdatatype = <ls_data_type> )
            IMPORTING
              et_message        = DATA(lt_message)
            CHANGING
              cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

          cl_abap_unit_assert=>fail(
            msg = 'Invalid data type exception not thrown' ).

        CATCH cx_ngc_core_chr_exception.
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.

  METHOD chr_val_dep.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    ls_charc_value = VALUE #( charcvaluedependency = 'B' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-date )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Invalid charc value dependency message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e002(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD interval_values.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charcfromdate          TYPE auspext_date_from,
      lv_charctodate            TYPE auspext_date_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    lv_charcfromdate = '20000102'.
    lv_string_from = lv_charcfromdate.

    lv_charctodate = '20000101'.
    lv_string_to = lv_charctodate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue = lv_string_to
    ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = |'Invalid interval check message missing, dependency: { <lv_charc_value_dependency> }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e008(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = 'Invalid message' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD single_data.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charcfromdate          TYPE auspext_date_from,
      lv_charctodate            TYPE auspext_date_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '1' ) ( '8' ) ( '9' ) ).

    lv_charcfromdate = '20060319'.
    lv_string_from = lv_charcfromdate.

    lv_charctodate = '20050430'.
    lv_string_to = lv_charctodate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue   = lv_string_to
    ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = |'No to value allowed, dependency: { <lv_charc_value_dependency> }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e003(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = 'Invalid message' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD single_data_to.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lv_charcfromdate          TYPE auspext_date_from,
      lv_charctodate            TYPE auspext_date_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    lv_charcfromdate = '20060319'.
    lv_string_from = lv_charcfromdate.

    lv_charctodate = '20050430'.
    lv_string_to = lv_charctodate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue   = lv_string_to
    ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-date
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = |'No to value allowed, dependency: { <lv_charc_value_dependency> }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e023(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = 'Invalid message' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD multi_char_val_dep.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromdate TYPE auspext_date_from,
      lv_charctodate   TYPE auspext_date_to,
      lv_string_from   TYPE string,
      lv_string_to     TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromdate = '20100606'.
    lv_string_from = lv_charcfromdate.

    lv_charctodate = '20150115'.
    lv_string_to = lv_charctodate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue = lv_string_to
      charcvaluedependency  = '3'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-date )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Invalid dependency message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e002(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD months.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromdate TYPE auspext_date_from,
      lv_string        TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromdate = '19951311'.
    lv_string = lv_charcfromdate.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string
      charcvaluedependency  = '1'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-date )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Invalid month message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e019(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD days.

    TYPES:
      BEGIN OF lts_month_length,
        month(2) TYPE c,
        days     TYPE i,
      END OF lts_month_length.
    TYPES: ltt_month_length TYPE STANDARD TABLE OF lts_month_length.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromdate TYPE auspext_date_from,
      lv_string        TYPE string,
      lt_month         TYPE ltt_month_length.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_month = VALUE #(
      ( month = '01' days = '32' )
      ( month = '02' days = '30' )
      ( month = '03' days = '32' )
      ( month = '04' days = '31' )
      ( month = '05' days = '32' )
      ( month = '06' days = '31' )
      ( month = '07' days = '32' )
      ( month = '08' days = '32' )
      ( month = '09' days = '31' )
      ( month = '10' days = '32' )
      ( month = '11' days = '31' )
      ( month = '12' days = '32' ) ).

    LOOP AT lt_month ASSIGNING FIELD-SYMBOL(<ls_month>).

      lv_charcfromdate = '2000' && <ls_month>-month && <ls_month>-days.
      lv_string = lv_charcfromdate.

      ls_charc_value = VALUE #(
        charcfromnumericvalue = lv_string
        charcvaluedependency  = '1'
      ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype = if_ngc_c=>gc_charcdatatype-date )
        IMPORTING
          et_message        = DATA(lt_message)
        CHANGING
          cs_charc_value    = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

      cl_abap_unit_assert=>assert_equals(
        act = lines( lt_message )
        exp = 1
        msg = |'Invalid day message missing, month { <ls_month>-month }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e018(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = |'Invalid message, month { <ls_month>-month }'| ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.