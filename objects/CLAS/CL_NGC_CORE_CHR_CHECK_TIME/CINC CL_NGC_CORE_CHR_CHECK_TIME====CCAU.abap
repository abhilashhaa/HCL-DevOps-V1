CLASS ltc_time_check_valid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_time DEFINITION LOCAL FRIENDS ltc_time_check_valid.

CLASS ltc_time_check_valid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_time.

    METHODS:
      setup.

    METHODS:
      single             FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval           FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval    FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval_to FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_time_check_valid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_time=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

  ENDMETHOD.

  METHOD single.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromtime TYPE auspext_time_from,
      lv_charctotime   TYPE auspext_time_to,
      lv_string_from   TYPE string,
      lv_string_to     TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '124531'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype  = if_ngc_c=>gc_charcdatatype-time )
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
      lv_charcfromtime          TYPE auspext_time_from,
      lv_charctotime            TYPE auspext_time_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    lv_charcfromtime = '090000'.
    lv_string_from = lv_charcfromtime.

    lv_charctotime = '090001'.
    lv_string_to = lv_charctotime.

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
          is_charc_header  = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
            valueintervalisallowed = abap_true )
        IMPORTING
          et_message       = DATA(lt_message)
        CHANGING
            cs_charc_value = ls_charc_value ).

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
      lv_charcfromtime          TYPE auspext_time_from,
      lv_string_from            TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '8' ) ( '9' ) ).

    lv_charcfromtime = '210945'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
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
      lv_charctotime            TYPE auspext_time_from,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    lv_charctotime = '210945'.
    lv_string_to = lv_charctotime.

    ls_charc_value = VALUE #(
      charctonumericvalue = lv_string_to ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
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

ENDCLASS.

CLASS ltc_time_check_invalid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_time DEFINITION LOCAL FRIENDS ltc_time_check_invalid.

CLASS ltc_time_check_invalid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_time.

    METHODS:
      setup.

    METHODS:
      data_type            FOR TESTING,
      chr_val_dep          FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_values      FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data          FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_to       FOR TESTING RAISING cx_ngc_core_chr_exception,
      multi_char_val_dep   FOR TESTING RAISING cx_ngc_core_chr_exception,
      hours                FOR TESTING RAISING cx_ngc_core_chr_exception,
      minutes              FOR TESTING RAISING cx_ngc_core_chr_exception,
      seconds              FOR TESTING RAISING cx_ngc_core_chr_exception,
      time                 FOR TESTING RAISING cx_ngc_core_chr_exception.
ENDCLASS.

CLASS ltc_time_check_invalid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_time=>get_instance( ).

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
      ( if_ngc_c=>gc_charcdatatype-date )
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

    ls_charc_value = VALUE #(
      charcvaluedependency = 'B' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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
      lv_charcfromtime          TYPE auspext_time_from,
      lv_charctotime            TYPE auspext_time_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    lv_charcfromtime = '123030'.
    lv_string_from = lv_charcfromtime.

    lv_charctotime = '123029'.
    lv_string_to = lv_charctotime.

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
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
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
      lv_charcfromtime          TYPE auspext_time_from,
      lv_charctotime            TYPE auspext_time_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '1' ) ( '8' ) ( '9' ) ).

    lv_charcfromtime = '123030'.
    lv_string_from = lv_charcfromtime.

    lv_charctotime = '130000'.
    lv_string_to   = lv_charctotime.

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
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
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
      lv_charcfromtime          TYPE auspext_time_from,
      lv_charctotime            TYPE auspext_time_to,
      lv_string_from            TYPE string,
      lv_string_to              TYPE string,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    lv_charcfromtime = '123030'.
    lv_string_from = lv_charcfromtime.

    lv_charctotime = '130000'.
    lv_string_to   = lv_charctotime.

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
            charcdatatype          = if_ngc_c=>gc_charcdatatype-time
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
      lv_charcfromtime TYPE auspext_time_from,
      lv_charctotime   TYPE auspext_time_to,
      lv_string_from   TYPE string,
      lv_string_to     TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '093050'.
    lv_string_from = lv_charcfromtime.

    lv_charctotime = '210000'.
    lv_string_to = lv_charctotime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charctonumericvalue   = lv_string_to
      charcvaluedependency  = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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

  METHOD hours.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromtime TYPE auspext_time_from,
      lv_string_from   TYPE string.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '253050'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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
      msg = 'Invalid hour message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e013(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD minutes.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromtime TYPE auspext_time_from,
      lv_string_from   TYPE string.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '236050'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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
      msg = 'Invalid minute message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e014(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD seconds.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromtime TYPE auspext_time_from,
      lv_string_from   TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '235960'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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
      msg = 'Invalid second message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e015(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD time.

    DATA:
      ls_charc_value   TYPE ngcs_core_charc_value,
      lv_charcfromtime TYPE auspext_time_from,
      lv_string_from   TYPE string.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lv_charcfromtime = '240001'.
    lv_string_from = lv_charcfromtime.

    ls_charc_value = VALUE #(
      charcfromnumericvalue = lv_string_from
      charcvaluedependency  = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-time )
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
      msg = 'Invalid time message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e016(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

ENDCLASS.