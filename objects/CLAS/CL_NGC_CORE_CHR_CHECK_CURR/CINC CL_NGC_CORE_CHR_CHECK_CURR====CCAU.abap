CLASS ltc_curr_check_valid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_curr DEFINITION LOCAL FRIENDS ltc_curr_check_valid.

CLASS ltc_curr_check_valid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_curr.

    METHODS:
      setup.

    METHODS:
      single             FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval           FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval    FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval_to FOR TESTING RAISING cx_ngc_core_chr_exception,
      negative_value     FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_curr_check_valid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_curr=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

  ENDMETHOD.

  METHOD single.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 300
      charcvaluedependency  = '1'
    ).


*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype  = if_ngc_c=>gc_charcdatatype-curr
          currency       = 'EUR'
          charclength    = 3 )
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
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 300
      charctonumericvalue = 600
    ).


    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
            valueintervalisallowed = abap_true
            currency               = 'EUR'
            charclength            = 3 )
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
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '8' ) ( '9' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 300
    ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
            valueintervalisallowed = abap_true
            currency               = 'EUR'
            charclength            = 3 )
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
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    ls_charc_value = VALUE #(
      charctonumericvalue = 300
    ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
            valueintervalisallowed = abap_true
            currency               = 'EUR'
            charclength            = 3 )
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

  METHOD negative_value.

    DATA:
      ls_charc_value    TYPE ngcs_core_charc_value,
      ls_valuation_data TYPE ngcs_core_valuation_data.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue = -300
      charcvaluedependency  = '1' ).


*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
          negativevalueisallowed = abap_true
          currency               = 'EUR'
          charclength            = 3 )
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

CLASS ltc_curr_check_invalid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_curr DEFINITION LOCAL FRIENDS ltc_curr_check_invalid.

CLASS ltc_curr_check_invalid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_curr.

    METHODS:
      setup.

    METHODS:
      data_type            FOR TESTING,
      chr_val_dep          FOR TESTING RAISING cx_ngc_core_chr_exception,
      negative_value       FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_values      FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data          FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_to       FOR TESTING RAISING cx_ngc_core_chr_exception,
      multi_char_val_dep   FOR TESTING RAISING cx_ngc_core_chr_exception,
      long_number          FOR TESTING RAISING cx_ngc_core_chr_exception,
      long_decimal         FOR TESTING RAISING cx_ngc_core_chr_exception.
ENDCLASS.

CLASS ltc_curr_check_invalid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_curr=>get_instance( ).

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
      ( if_ngc_c=>gc_charcdatatype-time ) ).

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
          charcdatatype = if_ngc_c=>gc_charcdatatype-curr
          charclength   = 3 )
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

  METHOD negative_value.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*
    ls_charc_value = VALUE #(
      charcfromnumericvalue = -300
      charctonumericvalue   = 400
      charcvaluedependency  = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype    = if_ngc_c=>gc_charcdatatype-curr
          charcdescription = 'Test charc'
          charclength      = 3 )
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
      msg = 'Not allowed negative value message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      WITH   ls_message-msgv1
      INTO DATA(lv_message_act).

    MESSAGE e006(ngc_core_chr) WITH 'Test charc' INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD interval_values.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 600
      charctonumericvalue   = 400 ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
            valueintervalisallowed = abap_true
            charclength            = 3 )
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
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '1' ) ( '8' ) ( '9' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 200
      charctonumericvalue   = 400 ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header = VALUE #( charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
                                     valueintervalisallowed = abap_true )
        IMPORTING
          et_message      = DATA(lt_message)
        CHANGING
          cs_charc_value  = ls_charc_value ).

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
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 200
      charctonumericvalue   = 400 ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header = VALUE #( charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
                                     valueintervalisallowed = abap_true )
        IMPORTING
          et_message      = DATA(lt_message)
        CHANGING
          cs_charc_value  = ls_charc_value ).

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
      ls_charc_value    TYPE ngcs_core_charc_value,
      ls_valuation_data TYPE ngcs_core_valuation_data.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue = -10
      charcvaluedependency  = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header = VALUE #( charcdatatype          = if_ngc_c=>gc_charcdatatype-curr
                                   negativevalueisallowed = abap_true
                                   charclength            = 3 )
      IMPORTING
        et_message      = DATA(lt_message)
      CHANGING
        cs_charc_value  = ls_charc_value ).

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

  METHOD long_number.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 80000
      charcvaluedependency = '1'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype = if_ngc_c=>gc_charcdatatype-curr
          charclength   = 4 )
      IMPORTING
        et_message        = DATA(lt_message)
      CHANGING
        cs_charc_value  = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Too many digits message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e009(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD long_decimal.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.

*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue = 8112 / 1000
      charcvaluedependency = '1'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header = VALUE #( charcdatatype = if_ngc_c=>gc_charcdatatype-curr
                                     charclength   = 4
                                     charcdecimals = 1 )
      IMPORTING
        et_message      = DATA(lt_message)
      CHANGING
        cs_charc_value  = ls_charc_value ).

*--------------------------------------------------------------------*
* Assertions
*--------------------------------------------------------------------*

    cl_abap_unit_assert=>assert_equals(
      act = lines( lt_message )
      exp = 1
      msg = 'Too many decimals message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      INTO DATA(lv_message_act).

    MESSAGE e010(ngc_core_chr) INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

ENDCLASS.