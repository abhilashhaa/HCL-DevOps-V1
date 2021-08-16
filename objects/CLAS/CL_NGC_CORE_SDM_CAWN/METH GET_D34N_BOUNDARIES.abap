METHOD get_d34n_boundaries.

  DATA:
    lv_inc   TYPE  decfloat34,
    lv_min   TYPE  cawn_dec_from,
    lv_max   TYPE  cawn_dec_to.

  me->get_num_interval_details(
    EXPORTING
      iv_anzst = iv_anzst
      iv_anzdz = iv_anzdz
      iv_atdex = iv_atdex
      iv_atdim = iv_atdim
      iv_atvor = iv_atvor
    IMPORTING
      ev_min   = lv_min
      ev_max   = lv_max
      ev_inc   = lv_inc
  ).

  me->get_value_boundaries(
    EXPORTING
      iv_value_from = iv_dec_from
      iv_value_to   = iv_dec_to
      iv_value_min  = lv_min
      iv_value_max  = lv_max
      iv_increment  = lv_inc
      iv_atcod      = iv_atcod
    IMPORTING
      ev_value_from = ev_dec_from
      ev_value_to   = ev_dec_to
  ).

ENDMETHOD.