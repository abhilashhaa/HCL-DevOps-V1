CLASS ltd_uom_converter DEFINITION FOR TESTING.

  PUBLIC SECTION.
    INTERFACES: lif_uom_converter.

    TYPES: BEGIN OF lts_uom,
             uom   TYPE msehi,
             value TYPE f,
           END OF lts_uom.
    TYPES: ltt_uom TYPE STANDARD TABLE OF lts_uom.

    DATA:
      mt_uom TYPE ltt_uom.

    METHODS:
      constructor
        IMPORTING
          it_uom TYPE ltt_uom.

ENDCLASS.

CLASS ltd_uom_converter IMPLEMENTATION.

  METHOD constructor.

    mt_uom = it_uom.

  ENDMETHOD.

  METHOD lif_uom_converter~convert_value_uom.

    CLEAR: et_message, ev_value.


    DATA(ls_uom_from) = VALUE #( mt_uom[ uom = iv_uom_from ] OPTIONAL ).
    IF ls_uom_from IS INITIAL.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '007'
        msgv1           = iv_uom_from ) TO et_message.
      RETURN.
    ENDIF.

    DATA(ls_uom_to) = VALUE #( mt_uom[ uom = iv_uom_to ] OPTIONAL ).
    IF ls_uom_to IS INITIAL.
      APPEND VALUE #(
        key_date        = sy-datum
        charcinternalid = is_charc_header-charcinternalid
        msgty           = if_ngc_c=>gc_message_severity-error
        msgid           = 'NGC_CORE_CHR'
        msgno           = '007'
        msgv1           = iv_uom_to ) TO et_message.
      RETURN.
    ENDIF.

    ev_value = iv_value * ls_uom_from-value.
    ev_value = ev_value / ls_uom_to-value.

  ENDMETHOD.

ENDCLASS.

CLASS ltc_num_check_valid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_num DEFINITION LOCAL FRIENDS ltc_num_check_valid.

CLASS ltc_num_check_valid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_num.

    METHODS:
      setup.

    METHODS:
      single_uom             FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_uom           FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval_uom    FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_interval_uom_to FOR TESTING RAISING cx_ngc_core_chr_exception,
      negative_value         FOR TESTING RAISING cx_ngc_core_chr_exception,
      exponential            FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_num_check_valid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_num=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

    mo_cut->mo_uom_converter = NEW ltd_uom_converter(
      VALUE #(
        ( uom = 'g'  value = 1 )
        ( uom = 'kg' value = 1000 ) ) ).

  ENDMETHOD.

  METHOD single_uom.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'kg'
      charcvaluedependency      = '1'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype  = if_ngc_c=>gc_charcdatatype-num
          charcvalueunit = 'g'
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

  METHOD interval_uom.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '2' ) ( '3' ) ( '4' ) ( '5' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'g'
      charctonumericvalue       = 600
      charctonumericvalueunit   = 'kg' ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
            valueintervalisallowed = abap_true
            charcvalueunit         = 'g'
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

  METHOD single_interval_uom.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '8' ) ( '9' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'kg' ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
            valueintervalisallowed = abap_true
            charcvalueunit         = 'g'
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

  METHOD single_interval_uom_to.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    ls_charc_value = VALUE #(
      charctonumericvalue     = 300
      charctonumericvalueunit = 'kg' ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
            valueintervalisallowed = abap_true
            charcvalueunit         = 'g'
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
      charcfromnumericvalue     = -300
      charcvaluedependency      = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          negativevalueisallowed = abap_true
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

  METHOD exponential.

    DATA:
ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 456456
      charcvaluedependency      = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*
    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          negativevalueisallowed = abap_true
          charclength            = 3
          charcexponentformat    = 2 )
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

CLASS ltc_num_check_invalid DEFINITION DEFERRED.
CLASS cl_ngc_core_chr_check_num DEFINITION LOCAL FRIENDS ltc_num_check_invalid.

CLASS ltc_num_check_invalid DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    DATA:
      mo_cut TYPE REF TO cl_ngc_core_chr_check_num.

    METHODS:
      setup.

    METHODS:
      data_type            FOR TESTING,
      chr_val_dep          FOR TESTING RAISING cx_ngc_core_chr_exception,
      negative_value       FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_values      FOR TESTING RAISING cx_ngc_core_chr_exception,
      no_base_uom          FOR TESTING RAISING cx_ngc_core_chr_exception,
      unit_of_measure_from FOR TESTING RAISING cx_ngc_core_chr_exception,
      unit_of_measure_to   FOR TESTING RAISING cx_ngc_core_chr_exception,
      interval_uom         FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data          FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_to       FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_uom      FOR TESTING RAISING cx_ngc_core_chr_exception,
      single_data_uom_to   FOR TESTING RAISING cx_ngc_core_chr_exception,
      multi_char_val_dep   FOR TESTING RAISING cx_ngc_core_chr_exception,
      long_number          FOR TESTING RAISING cx_ngc_core_chr_exception,
      long_decimal         FOR TESTING RAISING cx_ngc_core_chr_exception.

ENDCLASS.

CLASS ltc_num_check_invalid IMPLEMENTATION.

  METHOD setup.

    DATA:
      lo_cls_util_intersect TYPE REF TO if_ngc_core_cls_util_intersect.


    mo_cut ?= cl_ngc_core_chr_check_num=>get_instance( ).

    lo_cls_util_intersect ?= cl_abap_testdouble=>create( 'if_ngc_core_cls_util_intersect' ).
    mo_cut->mo_cls_util_intersect = lo_cls_util_intersect.

    mo_cut->mo_uom_converter = NEW ltd_uom_converter(
      VALUE #(
        ( uom = 'g'  value = 1 )
        ( uom = 'kg' value = 1000 )
        ( uom = 't'  value = 1000000 ) ) ).

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
      ( if_ngc_c=>gc_charcdatatype-curr )
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
      ls_charc_value    TYPE ngcs_core_charc_value,
      ls_valuation_data TYPE ngcs_core_valuation_data.


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
          charcdatatype = if_ngc_c=>gc_charcdatatype-num
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
      charcvaluedependency  = '3'
      charcfromnumericvalue = -300
      charctonumericvalue   = 400 ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          charcdescription       = 'Test charc'
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
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
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

  METHOD no_base_uom.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'g'
      charctonumericvalue       = 400
      charcvaluedependency      = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          valueintervalisallowed = abap_true
          charclength            = 3
          charcdescription       = 'Test charc' )
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
      msg = 'Invalid unit of measure message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      WITH   ls_message-msgv1
      INTO DATA(lv_message_act).

    MESSAGE e005(ngc_core_chr) WITH 'Test charc' INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD unit_of_measure_from.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'ml'
      charctonumericvalue       = 400
      charcvaluedependency      = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          valueintervalisallowed = abap_true
          charcvalueunit         = 'g'
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
      msg = 'Invalid unit of measure message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      WITH   ls_message-msgv1
      INTO DATA(lv_message_act).

    MESSAGE e007(ngc_core_chr) WITH 'ml' INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD unit_of_measure_to.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 300
      charcfromnumericvalueunit = 'kg'
      charctonumericvalue       = 400
      charctonumericvalueunit   = 'l'
      charcvaluedependency      = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          valueintervalisallowed = abap_true
          charcvalueunit         = 'g'
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
      msg = 'Invalid unit of measure message missing' ).

    DATA(ls_message) = lt_message[ 1 ].

    MESSAGE
      ID     ls_message-msgid
      TYPE   ls_message-msgty
      NUMBER ls_message-msgno
      WITH   ls_message-msgv1
      INTO DATA(lv_message_act).

    MESSAGE e007(ngc_core_chr) WITH 'l' INTO DATA(lv_message_exp).

    cl_abap_unit_assert=>assert_equals(
      act = lv_message_act
      exp = lv_message_exp
      msg = 'Invalid message' ).

  ENDMETHOD.

  METHOD interval_uom.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 3
      charcfromnumericvalueunit = 't'
      charctonumericvalue       = 400
      charctonumericvalueunit   = 'kg'
      charcvaluedependency      = '3'
    ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          valueintervalisallowed = abap_true
          charcvalueunit         = 'g'
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
      msg = 'Invalid interval message missing' ).

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
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
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
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
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

  METHOD single_data_uom.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '1' ) ( '8' ) ( '9' ) ).

    ls_charc_value = VALUE #(
      charcfromnumericvalue   = 200
      charctonumericvalueunit = 'kg' ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
            valueintervalisallowed = abap_true
            charcvalueunit         = 'kg' )
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
        msg = |'No to value unit allowed, dependency: { <lv_charc_value_dependency> }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e004(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = 'Invalid message' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD single_data_uom_to.

    DATA:
      ls_charc_value            TYPE ngcs_core_charc_value,
      lt_charc_value_dependency TYPE STANDARD TABLE OF atcod.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    lt_charc_value_dependency = VALUE #(
      ( '6' ) ( '7' ) ).

    ls_charc_value = VALUE #(
      charctonumericvalue       = 200
      charcfromnumericvalueunit = 'kg' ).

    LOOP AT lt_charc_value_dependency ASSIGNING FIELD-SYMBOL(<lv_charc_value_dependency>).
      ls_charc_value-charcvaluedependency = <lv_charc_value_dependency>.

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

      mo_cut->if_ngc_core_chr_value_check~check_value(
        EXPORTING
          is_charc_header   = VALUE #(
            charcdatatype          = if_ngc_c=>gc_charcdatatype-num
            valueintervalisallowed = abap_true
            charcvalueunit         = 'kg' )
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
        msg = |'No to value unit allowed, dependency: { <lv_charc_value_dependency> }'| ).

      DATA(ls_message) = lt_message[ 1 ].

      MESSAGE
        ID     ls_message-msgid
        TYPE   ls_message-msgty
        NUMBER ls_message-msgno
        INTO DATA(lv_message_act).

      MESSAGE e024(ngc_core_chr) INTO DATA(lv_message_exp).

      cl_abap_unit_assert=>assert_equals(
        act = lv_message_act
        exp = lv_message_exp
        msg = 'Invalid message' ).
    ENDLOOP.

  ENDMETHOD.

  METHOD multi_char_val_dep.

    DATA:
      ls_charc_value TYPE ngcs_core_charc_value.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = -10
      charcvaluedependency      = '3' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          negativevalueisallowed = abap_true
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
      ls_charc_value    TYPE ngcs_core_charc_value,
      ls_valuation_data TYPE ngcs_core_valuation_data.


*--------------------------------------------------------------------*
* Arrangements
*--------------------------------------------------------------------*

    ls_charc_value = VALUE #(
      charcfromnumericvalue     = 80000
      charcvaluedependency      = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          charclength            = 4 )
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
      charcfromnumericvalue     = 8112 / 1000
      charcvaluedependency      = '1' ).

*--------------------------------------------------------------------*
* Actions
*--------------------------------------------------------------------*

    mo_cut->if_ngc_core_chr_value_check~check_value(
      EXPORTING
        is_charc_header   = VALUE #(
          charcdatatype          = if_ngc_c=>gc_charcdatatype-num
          charclength            = 4
          charcdecimals          = 2 )
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