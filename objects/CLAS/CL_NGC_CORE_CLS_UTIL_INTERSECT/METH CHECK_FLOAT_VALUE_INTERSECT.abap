METHOD check_float_value_intersect.

*--------------------------------------------------------------------*
* This implementation is adapted from
*  function group: CTIH
*  form:           CHECK_VALUE_INTERSECTION
*  (include:       LCTIHF06)
*--------------------------------------------------------------------*

  DATA:
    lv_float_from_low  TYPE atflv,
    lv_float_from_high TYPE atflv,
    lv_float_to_low    TYPE atflb,
    lv_float_to_high   TYPE atflb.

  CLEAR: rv_has_intersection.

  IF is_float_1-atflv GE 0.
    lv_float_from_low  = is_float_1-atflv * ( 1 - gc_float_eps ).
    lv_float_from_high = is_float_1-atflv * ( 1 + gc_float_eps ).
  ELSE.
    lv_float_from_low  = is_float_1-atflv * ( 1 + gc_float_eps ).
    lv_float_from_high = is_float_1-atflv * ( 1 - gc_float_eps ).
  ENDIF.
  IF is_float_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt
  OR is_float_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le
  OR is_float_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt
  OR is_float_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
    IF is_float_1-atflb GE 0.
      lv_float_to_low  = is_float_1-atflb * ( 1 - gc_float_eps ).
      lv_float_to_high = is_float_1-atflb * ( 1 + gc_float_eps ).
    ELSE.
      lv_float_to_low  = is_float_1-atflb * ( 1 + gc_float_eps ).
      lv_float_to_high = is_float_1-atflb * ( 1 - gc_float_eps ).
    ENDIF.
  ELSE.
    CLEAR: lv_float_to_low, lv_float_to_high.
  ENDIF.


  CASE is_float_1-atcod.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                             " EQ
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GE lv_float_from_low  AND
             is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LE lv_float_from_high AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LE lv_float_from_high AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_from_low  AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_from_low  AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                          " GE LT
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GE lv_float_from_low  AND
             is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LT lv_float_to_low  AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_to_high AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_to_high AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                          " GE LE
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GE lv_float_from_low  AND
             is_float_2-atflv LE lv_float_to_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LE lv_float_to_high AND
             is_float_2-atflb GT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LE lv_float_to_high AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_to_high AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_to_high AND
             is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LE lv_float_to_high.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                          " GT LT
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GT lv_float_from_high  AND
             is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                          " GT LE
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GT lv_float_from_high  AND
             is_float_2-atflv LE lv_float_to_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LE lv_float_to_high AND
             is_float_2-atflb GT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LE lv_float_to_high AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_to_low AND
             is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_to_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LE lv_float_to_high.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                             " LT
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                             " LE
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT
          IF is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE
          IF is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          IF is_float_2-atflv LT lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          IF is_float_2-atflv LE lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                             " GT
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          rv_has_intersection = abap_true.
      ENDCASE.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                             " GE
      CASE is_float_2-atcod.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-eq.                         " EQ
          IF is_float_2-atflv GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.                      " GE LT  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.                      " GE LE  FIXED
          IF is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.                      " GT LT  FIXED
          IF is_float_2-atflb GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.                      " GT LE  FIXED
          IF is_float_2-atflb GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                         " LT
          IF is_float_2-atflv GT lv_float_from_high.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                         " LE
          IF is_float_2-atflv GE lv_float_from_low.
            rv_has_intersection = abap_true.
          ENDIF.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                         " GT
          rv_has_intersection = abap_true.
        WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                         " GE
          rv_has_intersection = abap_true.
      ENDCASE.
  ENDCASE.

ENDMETHOD.