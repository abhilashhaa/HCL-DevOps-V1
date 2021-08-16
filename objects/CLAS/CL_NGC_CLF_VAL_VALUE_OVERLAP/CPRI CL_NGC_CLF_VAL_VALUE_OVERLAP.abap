private section.

  constants MC_MIN type ATFLV value '-9.999999999999999E+99' ##NO_TEXT.
  constants MC_MIN_2 type ATFLV value '-9.999999999999900E+99' ##NO_TEXT.
  constants MC_MAX_2 type ATFLV value '9.999999999999900E+99' ##NO_TEXT.
  constants MC_MAX type ATFLV value '9.999999999999999E+99' ##NO_TEXT.

  methods CONV_SING_TO_MULT_RELATIONS
    changing
      !CT_VALUATION_DATA type NGCT_VALUATION_DATA_UPD .
  methods CONV_MULT_TO_SING_RELATIONS
    changing
      !CT_VALUATION_DATA type NGCT_VALUATION_DATA_UPD .