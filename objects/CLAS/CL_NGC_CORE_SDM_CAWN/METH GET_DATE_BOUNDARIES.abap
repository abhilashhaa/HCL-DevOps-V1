METHOD get_date_boundaries.

  CONSTANTS:
    lc_date_min TYPE dats VALUE '19000101',
    lc_date_max TYPE dats VALUE '99991231'.


  me->get_value_boundaries(
    EXPORTING
      iv_value_from = iv_date_from
      iv_value_to   = iv_date_to
      iv_value_min  = lc_date_min
      iv_value_max  = lc_date_max
      iv_increment  = 1
      iv_atcod      = iv_atcod
    IMPORTING
      ev_value_from = ev_date_from
      ev_value_to   = ev_date_to
  ).

ENDMETHOD.