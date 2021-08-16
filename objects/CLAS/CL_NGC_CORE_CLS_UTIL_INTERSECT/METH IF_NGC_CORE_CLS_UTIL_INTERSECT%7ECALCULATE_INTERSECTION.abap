METHOD if_ngc_core_cls_util_intersect~calculate_intersection.

  DATA: ls_collected_char_value TYPE ngcs_core_class_charc_inter.

  CLEAR: es_collected_char_value.

  CHECK it_collected_char_values IS NOT INITIAL.

  " Use header values of the first item
  es_collected_char_value = it_collected_char_values[ 1 ].

  " Remove duplicate values where intersection calculation is not required
  DATA(lt_items_with_intersection) = get_items_with_intersection( it_collected_char_values ).
  IF lines( lt_items_with_intersection ) = 1.
    RETURN.
  ENDIF.

  IF iv_charcdatatype = if_ngc_core_c=>gc_charcdatatype-char.
    me->calc_intersect_char_type(
      EXPORTING
        it_collected_char_values = lt_items_with_intersection
      IMPORTING
        es_collected_char_value  = ls_collected_char_value
    ).
  ELSEIF iv_charcdatatype = if_ngc_core_c=>gc_charcdatatype-num
      OR iv_charcdatatype = if_ngc_core_c=>gc_charcdatatype-curr
      OR iv_charcdatatype = if_ngc_core_c=>gc_charcdatatype-date
      OR iv_charcdatatype = if_ngc_core_c=>gc_charcdatatype-time.

    me->calc_intersect_not_char_type(
      EXPORTING
        it_collected_char_values = lt_items_with_intersection
      IMPORTING
        es_collected_char_value  = ls_collected_char_value
    ).
  ENDIF.

  es_collected_char_value-charc_values = ls_collected_char_value-charc_values.

ENDMETHOD.