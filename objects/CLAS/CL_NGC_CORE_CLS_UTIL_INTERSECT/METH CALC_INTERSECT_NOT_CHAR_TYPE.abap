METHOD calc_intersect_not_char_type.

*--------------------------------------------------------------------*
* Basic concepts implemented in this method are coming from
* function module CTIH_INTERSECTION
*
* ATCOD values:
* 1 EQ         =  V1
* 2 GE  LT     >= V1   <  V2
* 3 GE  LE     >= V1   <= V2
* 4 GT  LT     >  V1   <  V2
* 5 GT  LE     >  V1   <= V2
* 6 LT         <  V1
* 7 LE         <= V1
* 8 GT         >  V1
* 9 GE         >= V1
*
*--------------------------------------------------------------------*

  CLEAR: es_collected_char_value.

  CHECK it_collected_char_values IS NOT INITIAL.

  READ TABLE it_collected_char_values ASSIGNING FIELD-SYMBOL(<ls_collected_char_value>) INDEX 1.
  es_collected_char_value = <ls_collected_char_value>.

  LOOP AT it_collected_char_values ASSIGNING <ls_collected_char_value> FROM 2.

    DATA(ls_collected_char_value) = es_collected_char_value.
    CLEAR: es_collected_char_value-charc_values.

    LOOP AT ls_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value_intersect>).
      DATA: lv_has_intersection   TYPE boole_d,
            ls_float_intersection TYPE if_ngc_core_cls_util_intersect~ts_float_value.

      LOOP AT <ls_collected_char_value>-charc_values ASSIGNING FIELD-SYMBOL(<ls_collected_charc_val>).
        lv_has_intersection = check_float_value_intersect(
          is_float_1 = VALUE #( atflv = <ls_collected_charc_val>-charcfromnumericvalue
                                atflb = <ls_collected_charc_val>-charctonumericvalue
                                atcod = <ls_collected_charc_val>-charcvaluedependency )
          is_float_2 = VALUE #( atflv = <ls_charc_value_intersect>-charcfromnumericvalue
                                atflb = <ls_charc_value_intersect>-charctonumericvalue
                                atcod = <ls_charc_value_intersect>-charcvaluedependency ) ).
        IF lv_has_intersection = abap_true.
          APPEND INITIAL LINE TO es_collected_char_value-charc_values ASSIGNING FIELD-SYMBOL(<ls_charc_value_intersect_res>).

            IF <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
              <ls_charc_value_intersect_res> = <ls_charc_value_intersect>.
            ELSEIF <ls_collected_charc_val>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
              <ls_charc_value_intersect_res> = <ls_collected_charc_val>.
            ELSE.
              ls_float_intersection = calc_float_interval_intersect(
                iv_negativevalueisallowed = ls_collected_char_value-negativevalueisallowed
                is_float_1                = VALUE #( atflv = <ls_collected_charc_val>-charcfromnumericvalue
                                                     atflb = <ls_collected_charc_val>-charctonumericvalue
                                                     atcod = <ls_collected_charc_val>-charcvaluedependency )
                is_float_2                = VALUE #( atflv = <ls_charc_value_intersect>-charcfromnumericvalue
                                                     atflb = <ls_charc_value_intersect>-charctonumericvalue
                                                     atcod = <ls_charc_value_intersect>-charcvaluedependency )
              ).

              <ls_charc_value_intersect_res>-charcfromnumericvalue = ls_float_intersection-atflv.
              <ls_charc_value_intersect_res>-charctonumericvalue   = ls_float_intersection-atflb.
              <ls_charc_value_intersect_res>-charcvaluedependency  = ls_float_intersection-atcod.
            ENDIF.

          ENDIF.
      ENDLOOP.

    ENDLOOP.

  ENDLOOP.

  SORT es_collected_char_value-charc_values BY charcfromnumericvalue charctonumericvalue charcvaluedependency.
  DELETE ADJACENT DUPLICATES FROM es_collected_char_value-charc_values COMPARING charcfromnumericvalue charctonumericvalue charcvaluedependency.

*   handle minimal and maximal interval boundaries and build string from values
*  LOOP AT es_collected_char_value-charc_values ASSIGNING <ls_charc_value_intersect>.
*
*    IF <ls_charc_value_intersect>-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND
*       <ls_charc_value_intersect>-charcfromnumericvalue = 0 OR
*       <ls_charc_value_intersect>-charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue.
*      <ls_charc_value_intersect>-charcfromnumericvalue = <ls_charc_value_intersect>-charctonumericvalue.
*      <ls_charc_value_intersect>-charctonumericvalue  = 0.
*      <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-lt.
*    ENDIF.
*
*    IF <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
*
*      IF ( <ls_charc_value_intersect>-charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue ) AND
*           <ls_charc_value_intersect>-charctonumericvalue <> if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue.
*        <ls_charc_value_intersect>-charcfromnumericvalue = <ls_charc_value_intersect>-charctonumericvalue.
*        <ls_charc_value_intersect>-charctonumericvalue  = 0.
*        <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-le.
*      ENDIF.
*
*      IF <ls_charc_value_intersect>-charcfromnumericvalue <> 0         AND
*         <ls_charc_value_intersect>-charcfromnumericvalue <> if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue AND
*         <ls_charc_value_intersect>-charctonumericvalue   =  if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue AND
*         <ls_charc_value_intersect>-charcvaluedependency  =  if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
*        <ls_charc_value_intersect>-charctonumericvalue  = 0.
*        <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge.
*      ENDIF.
*
*      IF <ls_charc_value_intersect>-charcfromnumericvalue = 0         AND
*         <ls_charc_value_intersect>-charctonumericvalue   = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue AND
*         <ls_charc_value_intersect>-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
*        <ls_charc_value_intersect>-charctonumericvalue  = 0.
*        <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-ge.
*      ENDIF.
*
*      IF <ls_charc_value_intersect>-charcfromnumericvalue = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charcfromnumericvalue AND
*         <ls_charc_value_intersect>-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
*        <ls_charc_value_intersect>-charcfromnumericvalue = <ls_charc_value_intersect>-charctonumericvalue.
*        <ls_charc_value_intersect>-charctonumericvalue   = 0.
*        <ls_charc_value_intersect>-charcvaluedependency  = if_ngc_core_c=>gc_chr_charcvaluedependency-le.
*      ENDIF.
*
*    ENDIF.
*
*    IF <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND
*       <ls_charc_value_intersect>-charctonumericvalue  = if_ngc_core_c=>gc_charcnumericvalue_bounds-max_charctonumericvalue.
*      <ls_charc_value_intersect>-charctonumericvalue  = 0.
*      <ls_charc_value_intersect>-charcvaluedependency = if_ngc_core_c=>gc_chr_charcvaluedependency-gt.
*    ENDIF.
*
*  ENDLOOP.

ENDMETHOD.