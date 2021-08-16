METHOD get_time_boundaries.

  CONSTANTS:
    lc_time_min TYPE tims VALUE '000000',
    lc_time_max TYPE tims VALUE '235959'.

  me->get_value_boundaries(
    EXPORTING
      iv_value_from = iv_time_from
      iv_value_to   = iv_time_to
      iv_value_min  = lc_time_min
      iv_value_max  = lc_time_max
      iv_increment  = 1
      iv_atcod      = iv_atcod
    IMPORTING
      ev_value_from = ev_time_from
      ev_value_to   = ev_time_to
  ).

ENDMETHOD.