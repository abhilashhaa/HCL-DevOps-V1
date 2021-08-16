METHOD get_num_interval_details.

  DATA:
    lv_exp     TYPE i,
    lv_exp_inc TYPE i,
    lv_exp_max TYPE i.

  CLEAR:
    ev_min, ev_max, ev_inc.

  CASE iv_atdex.
    WHEN 0.
      lv_exp     = 0.
      lv_exp_inc = lv_exp.
      lv_exp_inc = iv_anzdz - lv_exp.
    WHEN 2.
      lv_exp     = iv_atdim.
      lv_exp_inc = iv_anzdz - lv_exp.    "-xx/+xx exponent is entered explicitly
    WHEN 1 OR 3.
      lv_exp     = 99.
      lv_exp_inc = iv_anzdz + lv_exp.    "-99 as exponent is used to calc. min. increment
  ENDCASE.

  " LCTCVTOP - MAX_EXPON = '102+', MIN_EXPON = '102-'
  IF lv_exp_inc > 102.
   lv_exp_inc = 102.
  ENDIF.

  ev_inc = 1 / ipow( base = 10 exp = lv_exp_inc ).

  lv_exp_max = iv_anzst - iv_anzdz + lv_exp.
  ev_max = ipow( base = 10 exp = lv_exp_max ) - ev_inc.

  IF iv_atvor = abap_true.
    ev_min = ev_max * -1.
  ENDIF.

ENDMETHOD.