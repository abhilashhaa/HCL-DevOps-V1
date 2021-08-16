CLASS ltc_cls_util_intersect DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.

    CLASS-DATA:
      mo_util_intersect TYPE REF TO cl_ngc_core_cls_util_intersect.

    METHODS:
      setup,
      character_inters_one_result FOR TESTING,
      character_inters_no_result FOR TESTING,
      numeric_inters FOR TESTING,
      numeric_inters_check_eq FOR TESTING,
      numeric_inters_check_ge_lt FOR TESTING,
      numeric_inters_check_ge_le FOR TESTING,
      numeric_inters_ge_le_twice FOR TESTING,
      numeric_inters_check_gt_lt FOR TESTING,
      numeric_inters_check_gt_le FOR TESTING,
      numeric_inters_check_gt FOR TESTING,
      numeric_inters_check_ge FOR TESTING,
      numeric_inters_check_lt FOR TESTING,
      numeric_inters_check_le FOR TESTING.
ENDCLASS.

CLASS ltc_cls_util_intersect IMPLEMENTATION.

  METHOD setup.
    mo_util_intersect = cl_ngc_core_cls_util_intersect=>get_instance( ).
  ENDMETHOD.

  METHOD character_inters_one_result.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-char
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE01' )
            ( charcvalue = 'VALUE02' )
            ( charcvalue = 'VALUE03' ) ) )

          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE01' )
            ( charcvalue = 'VALUE02' ) ) )

          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE01' ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #( ( charcvalue = 'VALUE01' ) ) )
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD character_inters_no_result.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-char
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE01' )
            ( charcvalue = 'VALUE02' )
            ( charcvalue = 'VALUE03' ) ) )

          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE01' ) ) )

          ( charc_values = VALUE #(
            ( charcvalue = 'VALUE02' ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = VALUE ngcs_core_class_charc_inter( )
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 50  charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 400 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 40  charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 150 charctonumericvalue = 250 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 350 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 40  charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
        ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue = 250 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 400 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_eq.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 100 charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 100 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 50  charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 100 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 50  charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 200 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_ge_lt.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 199 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_ge_le.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_gt_lt.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 99  charctonumericvalue = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_gt_le.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 99  charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_gt.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 99  charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 99  charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_ge.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 100 charctonumericvalue  = 104 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_lt.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 201 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
        ( charcfromnumericvalue = 50  charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 50  charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 104 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
        ( charcfromnumericvalue = 104 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_check_le.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
            ( charcfromnumericvalue = 200 charctonumericvalue = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 110 charctonumericvalue = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
            ( charcfromnumericvalue = 50  charctonumericvalue = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
            ( charcfromnumericvalue = 104 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt )
            ( charcfromnumericvalue = 199 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 201 charctonumericvalue = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    DATA(ls_expected) = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 50  charctonumericvalue  = 101 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
        ( charcfromnumericvalue = 110 charctonumericvalue  = 190 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt )
        ( charcfromnumericvalue = 50  charctonumericvalue  = 102 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 104 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt )
        ( charcfromnumericvalue = 104 charctonumericvalue  = 0   charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le )
        ( charcfromnumericvalue = 199 charctonumericvalue  = 201 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ).

    SORT ls_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
    SORT ls_expected-charc_values             BY charcfromnumericvalue charctonumericvalue charcvaluedependency.

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = ls_expected
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

  METHOD numeric_inters_ge_le_twice.
    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
      EXPORTING
        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
        it_collected_char_values = VALUE #(
          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 200 charctonumericvalue  = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) )

          ( charc_values = VALUE #(
            ( charcfromnumericvalue = 100 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
            ( charcfromnumericvalue = 200 charctonumericvalue  = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ) )
      IMPORTING
        es_collected_char_value = DATA(ls_collected_char_value) ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_collected_char_value
      exp = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
        ( charcfromnumericvalue = 100 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le )
*        ( charcfromnumericvalue = 200 charctonumericvalue  = 0 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq )
        ( charcfromnumericvalue = 200 charctonumericvalue  = 300 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) )
      msg = 'Incorrect intersection' ).
  ENDMETHOD.

*  METHOD numeric_inters_ge_le_from0.
*    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
*      EXPORTING
*        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
*        it_collected_char_values = VALUE #(
*          ( charc_values = VALUE #(
*            ( charcfromnumericvalue = 0 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) )
*
*          ( charc_values = VALUE #(
*            ( charcfromnumericvalue = 0 charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ) )
*      IMPORTING
*        es_collected_char_value = DATA(ls_collected_char_value) ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = ls_collected_char_value
*      exp = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
*        ( charcfromnumericvalue = 0 charctonumericvalue = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) )
*      msg = 'Incorrect intersection' ).
*  ENDMETHOD.
*
*  METHOD numeric_inters_ge_le_frommax.
*    mo_util_intersect->if_ngc_core_cls_util_intersect~calculate_intersection(
*      EXPORTING
*        iv_charcdatatype         = if_ngc_core_c=>gc_charcdatatype-num
*        it_collected_char_values = VALUE #(
*          ( charc_values = VALUE #(
*            ( charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) )
*
*          ( charc_values = VALUE #(
*            ( charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue charctonumericvalue  = 200 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le ) ) ) )
*      IMPORTING
*        es_collected_char_value = DATA(ls_collected_char_value) ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act = ls_collected_char_value
*      exp = VALUE ngcs_core_class_charc_inter( charc_values = VALUE #(
*        ( charcfromnumericvalue = 200 charctonumericvalue = 0 charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le ) ) )
*      msg = 'Incorrect intersection' ).
*  ENDMETHOD.

ENDCLASS.