METHOD get_curr_boundaries.

  DATA:
    lv_inc   TYPE  cawn_curr_from,
    lv_min   TYPE  cawn_curr_from,
    lv_max   TYPE  cawn_curr_to.

  lv_inc = 1 / ipow( base = 10 exp = 2 ).

  lv_max = ipow( base = 10 exp = ( iv_anzst - 2 ) ) - lv_inc.
  IF iv_atvor = abap_true.
    lv_min = lv_max * -1.
  ENDIF.

  me->get_value_boundaries(
    EXPORTING
      iv_value_from = iv_curr_from
      iv_value_to   = iv_curr_to
      iv_value_min  = lv_min
      iv_value_max  = lv_max
      iv_increment  = lv_inc
      iv_atcod      = iv_atcod
    IMPORTING
      ev_value_from = ev_curr_from
      ev_value_to   = ev_curr_to
  ).

ENDMETHOD.