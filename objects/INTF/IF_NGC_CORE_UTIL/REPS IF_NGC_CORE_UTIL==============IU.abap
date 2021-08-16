interface IF_NGC_CORE_UTIL
  public .


  methods GET_NUMBER_SEPARATOR_SIGNS
    exporting
      !EV_DECIMAL_SIGN like SY-BATCH
      !EV_SEPARATOR like SY-BATCH .
  methods GET_CLF_USER_PARAMS
    exporting
      !ES_CLF_USER_PARAMS type CLPROF .
  methods FUNCTION_EXISTS
    importing
      !IV_FUNCTION_NAME type RS38L_FNAM
    returning
      value(RV_FUNCTION_EXISTS) type BOOLE_D .
  methods GET_TEXTTABLE
    importing
      !IV_TABLE_NAME type DDOBJNAME
    exporting
      !EV_TEXTTABLE type DD08V-TABNAME
      !EV_CHECKFIELD type DD08V-FIELDNAME .
  methods CTCV_SYNTAX_CHECK
    importing
      !ATTRIBUT type ATNAM
      !BASEUNIT type MSEHI default SPACE
      !DECIMALS type ANZDZ default 0
      !DEC_PRESENTATION type CHAR1 default ','
      !EXPONENT type ATDIM default SPACE
      !EXPONENT_ART type ATDEX default '0'
      !FORMAT type ATFOR default 'CHAR'
      !INTERVAL type ATINT default SPACE
      !LANGUAGE type SYST_LANGU default SY-LANGU
      !LENGTH type ANZST default 0
      !LOWERCASE type ATKLE default SPACE
      !MASK type ATSCH default SPACE
      !MASK_ALLOWED type BOOLE_D default ' '
      !NEGATIV type ATVOR default SPACE
      !SCREEN_NAME type FNAM_____4 default SPACE
      !SINGLE_SELECTION type ATEIN default SPACE
      !STRING type ATWRT
      !VALUE_SEPERATOR type CHAR1 default ';'
      !CLASSTYPE type KLASSENART default SPACE
      !T_SEPARATOR type CHAR1 default ' '
      !ERR_NAME type ATBEZ optional
    exporting
      !STRING_IS_MASKED type SYST_BATCH
      !TSTRG type CLSX_TT_STRG
      !SY_SUBRC type SYST_SUBRC .
endinterface.