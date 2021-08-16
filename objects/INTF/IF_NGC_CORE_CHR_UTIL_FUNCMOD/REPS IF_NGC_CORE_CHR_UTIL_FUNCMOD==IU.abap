interface IF_NGC_CORE_CHR_UTIL_FUNCMOD
  public .


  types:
    tt_rctvalues TYPE STANDARD TABLE OF rctvalues WITH DEFAULT KEY .

  methods CALL_F4_FM
    importing
      !IV_FUNCTION_NAME type RS38L_FNAM
      !IV_CHARACTERISTIC type ATNAM
      !IV_CHARCINTERNALID type ATINN
    returning
      value(RT_VALUES) type TT_RCTVALUES .
  methods CHECK_CHARC_IS_PHRASED
    importing
      !IV_CHARCINTERNALID type ATINN
    returning
      value(RV_PHRASED) type BOOLE_D .
  methods READ_PHRASED_TEXT
    importing
      !IV_PHRASE_KEY type RCGATF4PHR-PHRKEY
    exporting
      !EV_PHRASE_CODE type RCGATF4PHR-PHRCODE
    exceptions
      PHRASE_NOT_FOUND .
endinterface.