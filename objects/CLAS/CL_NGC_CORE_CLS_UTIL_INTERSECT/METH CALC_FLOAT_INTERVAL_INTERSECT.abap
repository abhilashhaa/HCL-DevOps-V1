METHOD calc_float_interval_intersect.

*--------------------------------------------------------------------*
* The basis of this method is:
* Function group: CTIH
* Form:           CHECK_INTERVALL_INTERVALL
* (include: LCTIHF06)
*
* This method calculates the intersecion of two numeric characteristic
* domain value intervals.
*
* Interpretation of ATCOD values:
*   1 EQ        =  V1
*   2 GE  LT    >= V1    <  V2
*   3 GE  LE    >= V1    <= V2
*   4 GT  LT    >  V1    <  V2
*   5 GT  LE    >  V1    <= V2
*   6 LT        <  V1
*   7 LE        <= V1
*   8 GT        >  V1
*   9 GE        >= V1
*--------------------------------------------------------------------*

  DATA:
    lv_value_from_changed TYPE boole_d VALUE abap_false, " indicates that the characteristic value from has been changed
    lv_value_to_changed   TYPE boole_d VALUE abap_false, " indicates that the characteristic value from has been changed
    ls_value_1            TYPE if_ngc_core_cls_util_intersect~ts_float_value,
    ls_value_2            TYPE if_ngc_core_cls_util_intersect~ts_float_value,
    ls_val                TYPE if_ngc_core_cls_util_intersect~ts_float_value,
    ls_restore_x          TYPE if_ngc_core_cls_util_intersect~ts_float_value,
    ls_restore_y          TYPE if_ngc_core_cls_util_intersect~ts_float_value.

  CLEAR: rs_float_intersection.

  ls_value_1 = is_float_1.
  ls_value_2 = is_float_2.

  " Prepare open interval ls_value_1
  CASE ls_value_1-atcod.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                "<
      ls_restore_x = ls_value_1.
      ls_value_1-atflb = ls_value_1-atflv.
      IF iv_negativevalueisallowed NE abap_false.
        ls_value_1-atflv = if_ngc_core_c=>gc_max_charcnumericvaluefrom.
      ELSE.
        ls_value_1-atflv = 0.
      ENDIF.
      ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                "<=
      ls_restore_x = ls_value_1.
      ls_value_1-atflb = ls_value_1-atflv.
      IF iv_negativevalueisallowed NE abap_false.
        ls_value_1-atflv = if_ngc_core_c=>gc_max_charcnumericvaluefrom.
      ELSE.
        ls_value_1-atflv = 0.
      ENDIF.
      ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                ">
      ls_restore_x = ls_value_1.
      ls_value_1-atflb = if_ngc_core_c=>gc_max_charcnumericvalueto.
      ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                ">=
      ls_restore_x = ls_value_1.
      ls_value_1-atflb = if_ngc_core_c=>gc_max_charcnumericvalueto.
      ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

  ENDCASE.

  " Prepare open interval ls_value_2
  CASE ls_value_2-atcod.
    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-lt.                "<
      ls_restore_y = ls_value_2.
      ls_value_2-atflb = ls_value_2-atflv.
      IF iv_negativevalueisallowed NE abap_false.
        ls_value_2-atflv = if_ngc_core_c=>gc_max_charcnumericvaluefrom.
      ELSE.
        ls_value_2-atflv = 0.
      ENDIF.
      ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-le.                "<=
      ls_restore_y = ls_value_2.
      ls_value_2-atflb = ls_value_2-atflv.
      IF iv_negativevalueisallowed NE abap_false.
        ls_value_2-atflv = if_ngc_core_c=>gc_max_charcnumericvaluefrom.
      ELSE.
        ls_value_2-atflv = 0.
      ENDIF.
      ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-gt.                ">
      ls_restore_y = ls_value_2.
      ls_value_2-atflb = if_ngc_core_c=>gc_max_charcnumericvalueto.
      ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.

    WHEN if_ngc_core_c=>gc_chr_charcvaluedependency-ge.                ">=
      ls_restore_y = ls_value_2.
      ls_value_2-atflb = if_ngc_core_c=>gc_max_charcnumericvalueto.
      ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

  ENDCASE.

  " Cut between intervals
  lv_value_from_changed = abap_false.
  lv_value_to_changed = abap_false.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    " 2 - 2
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb GT ls_value_2-atflv AND
       ls_value_1-atflb LE ls_value_2-atflb.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb GT ls_value_1-atflv AND
       ls_value_2-atflb LE ls_value_1-atflb.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 2 - 3
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LE ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb = ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GE ls_value_1-atflv.
      rs_float_intersection-atflb = ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LT ls_value_1-atflb.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
    ELSE.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 2 - 4
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb = ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GT ls_value_1-atflv.
      rs_float_intersection-atflb = ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflv LE ls_value_2-atflv.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
    ELSE.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 2 - 5
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LE ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GE ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflv GT ls_value_2-atflv.
      IF ls_value_2-atflb LT ls_value_1-atflb.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
      ELSE.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
      ENDIF.
    ELSE.
      IF ls_value_2-atflb LT ls_value_1-atflb.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
      ELSE.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
      ENDIF.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
    " 3 - 3
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LE ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LE ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GE ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GE ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 3 - 4
    IF ls_value_1-atflv GT ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GT ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflv GT ls_value_2-atflv.
      IF ls_value_1-atflb LT ls_value_2-atflb.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
      ELSE.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_lt.
      ENDIF.
    ELSE.
      IF ls_value_1-atflb LT ls_value_2-atflb.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
      ELSE.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
      ENDIF.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 3 - 5
    IF ls_value_1-atflv GT ls_value_2-atflv AND
       ls_value_1-atflv LE ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GE ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflv GT ls_value_2-atflv.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge_le.
    ELSE.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
    " 4 - 4
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GT ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le
  OR ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
    IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
      ls_val = ls_value_1.
      ls_value_1 = ls_value_2.
      ls_value_2 = ls_val.
      ls_val = ls_restore_x.
      ls_restore_x = ls_restore_y.
      ls_restore_y = ls_val.
    ENDIF.
    " 4 - 5
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb LE ls_value_2-atflb AND
       ls_value_1-atflb GT ls_value_2-atflv.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LE ls_value_1-atflb AND
       ls_value_2-atflb GT ls_value_1-atflv.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb LT ls_value_1-atflb.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
    ELSE.
      rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_lt.
    ENDIF.

  ENDIF.

  IF ls_value_1-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le AND ls_value_2-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.
    " 5 - 5
    IF ls_value_1-atflv GE ls_value_2-atflv AND
       ls_value_1-atflv LT ls_value_2-atflb.
      rs_float_intersection-atflv = ls_value_1-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflv GE ls_value_1-atflv AND
       ls_value_2-atflv LT ls_value_1-atflb.
      rs_float_intersection-atflv = ls_value_2-atflv.
      lv_value_from_changed = abap_true.
    ENDIF.

    IF ls_value_1-atflb GT ls_value_2-atflv AND
       ls_value_1-atflb LE ls_value_2-atflb.
      rs_float_intersection-atflb =  ls_value_1-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    IF ls_value_2-atflb GT ls_value_1-atflv AND
       ls_value_2-atflb LE ls_value_1-atflb.
      rs_float_intersection-atflb =  ls_value_2-atflb.
      lv_value_to_changed = abap_true.
    ENDIF.

    rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt_le.

  ENDIF.


  IF lv_value_from_changed NE abap_false
  OR lv_value_to_changed   NE abap_false.

    IF     rs_float_intersection-atflv = ls_value_1-atflv
       AND rs_float_intersection-atflb = ls_value_1-atflb
       AND rs_float_intersection-atcod = ls_value_1-atcod.
      IF ls_restore_x IS INITIAL.
        MOVE-CORRESPONDING ls_value_1 TO rs_float_intersection.
      ELSE.
        MOVE-CORRESPONDING ls_restore_x TO rs_float_intersection.
      ENDIF.
    ENDIF.

    IF  rs_float_intersection-atflv = ls_value_2-atflv
    AND rs_float_intersection-atflb = ls_value_2-atflb
    AND rs_float_intersection-atcod = ls_value_2-atcod.
      IF ls_restore_y IS INITIAL.
        MOVE-CORRESPONDING ls_value_2 TO rs_float_intersection.
      ELSE.
        MOVE-CORRESPONDING ls_restore_y TO rs_float_intersection.
      ENDIF.
    ENDIF.

    IF rs_float_intersection-atflv = rs_float_intersection-atflb.
      " Special case: 0
      IF rs_float_intersection-atflv = 0.
        IF (   ls_restore_x-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-lt OR ls_restore_x-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-le
           AND ls_restore_y-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-lt OR ls_restore_y-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-le )
        OR (   ls_restore_x-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt OR ls_restore_x-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge
           AND ls_restore_y-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-gt OR ls_restore_y-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-ge ).
          "RS_FLOAT_INTERSECTION-ATCOD will not change!
        ELSE.
          rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
        ENDIF.
      ELSE.
        rs_float_intersection-atflb = 0.
        rs_float_intersection-atcod = if_ngc_core_c=>gc_chr_charcvaluedependency-eq.
      ENDIF.
    ENDIF.

  ELSE.
    CLEAR rs_float_intersection.

  ENDIF.

ENDMETHOD.