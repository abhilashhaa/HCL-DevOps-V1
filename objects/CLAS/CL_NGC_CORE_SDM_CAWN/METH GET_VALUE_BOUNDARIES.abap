METHOD get_value_boundaries.

  CASE iv_atcod.
    WHEN 1.                  " =
      ev_value_from = ev_value_to = iv_value_from.

    WHEN 2 OR 3 OR 4 OR 5.   "  [) , []  ,  ()  ,  (]
      " Left open interval
      IF iv_atcod = 4 OR iv_atcod = 5.
        ev_value_from = iv_value_from + iv_increment.
      ELSE.
        ev_value_from = iv_value_from.
      ENDIF.

      " Right open interval
      IF iv_atcod = 2 OR iv_atcod = 4.
        ev_value_to = iv_value_to - iv_increment.
      ELSE.
        ev_value_to = iv_value_to.
      ENDIF.

    WHEN 6 OR 7.              " <  ,  <=
      " Special handling for CAWN:
      " For 6,7 the upper boundary is in CAWN-ATFLV (lower boundary).
      " Therefore we need to process IV_VALUE_FROM !!!

      ev_value_from = iv_value_min.

      " Right open interval
      IF iv_atcod = 6.
        ev_value_to = iv_value_from - iv_increment.
      ELSE.
        ev_value_to = iv_value_from.
      ENDIF.

    WHEN 8 OR 9.              "  >  ,  >=
      ev_value_to = iv_value_max.

      " Left open interval
      IF iv_atcod = 8.
        ev_value_from = iv_value_from + iv_increment.
      ELSE.
        ev_value_from = iv_value_from.
      ENDIF.
  ENDCASE.

ENDMETHOD.