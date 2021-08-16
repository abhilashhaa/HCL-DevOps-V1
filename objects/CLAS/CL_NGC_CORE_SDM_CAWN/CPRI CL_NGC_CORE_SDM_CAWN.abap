private section.

  constants MC_LEADING_TABLE_NAME type TABNAME value 'CAWN' ##NO_TEXT.
  constants MC_RELATED_TABLE_NAME type TABNAME value 'CABN' ##NO_TEXT.
  constants MC_DB_VIEW_NAME type TABNAME value 'PSDMCAWN' ##NO_TEXT.
  constants MC_CLIENT_FIELD_NAME type FIELDNAME value 'MANDT' ##NO_TEXT.
  constants MC_KEY_FIELD_NAME type FIELDNAME value 'ATINN' ##NO_TEXT.
  constants MC_STATUS_FIELD_NAME type FIELDNAME value 'SDM_STATUS' ##NO_TEXT.
  constants MC_STATUS_VALUE_DONE type SDM_STATUS_VALUE_DONE value '02' ##NO_TEXT.
  constants MC_PACKAGE_SIZE type I value 100000 ##NO_TEXT.
  constants MC_MAX_LEN_NEW_CURR_VAL type I value 23 ##NO_TEXT.

  methods CONVERT_FLTP_TO_DATS
    importing
      !IV_ATNAM type ATNAM
      !IV_FLTP_VALUE type FLTP_VALUE
    returning
      value(RV_DATS) type DATS
    raising
      CX_SDM_MIGRATION .
  methods CONVERT_FLTP_TO_TIMS
    importing
      !IV_ATNAM type ATNAM
      !IV_FLTP_VALUE type FLTP_VALUE
    returning
      value(RV_TIMS) type TIMS
    raising
      CX_SDM_MIGRATION .
  methods CONVERT_FLTP_TO_CURR
    importing
      !IV_ATNAM type ATNAM
      !IV_FLTP_VALUE type FLTP_VALUE
      !IV_CURRENCY type WAERS
    exporting
      !EV_ERROR type BOOLE_D
    returning
      value(RV_CURR) type CAWN_CURR_FROM
    raising
      CX_SDM_MIGRATION .
  methods CONVERT_FLTP_TO_D34N
    importing
      !IV_ATNAM type ATNAM
      !IV_FLTP_VALUE type FLTP_VALUE
      !IV_DECIMALS type ANZDZ
      !IV_EXPONENT type ATDIM
      !IV_EXP_DISP_FORMAT type ATDEX
      !IV_BUOM type MSEHI
      !IV_UOM type MSEHI
    returning
      value(RV_D34N) type D34N
    raising
      CX_SDM_MIGRATION .
  methods CONVERT_FLTP_BUOM_TO_UOM
    importing
      !IV_ATNAM type ATNAM
      !IV_FLTP_VALUE type FLTP_VALUE
      !IV_BUOM type MSEHI
      !IV_UOM type MSEHI
    exporting
      !EV_FLTP_VALUE type FLTP_VALUE
      !EV_NUMERATOR type D16N
      !EV_DENOMINATOR type D16N
      !EV_ADD_CONST type D16N
    raising
      CX_SDM_MIGRATION .
  methods CONVERT_D34N_UOM_TO_BUOM
    importing
      !IV_D34N type D34N
      !IV_BUOM2UOM_NUMERATOR type D16N
      !IV_BUOM2UOM_DENOMINATOR type D16N
      !IV_BUOM2UOM_ADD_CONST type D16N
    returning
      value(RV_D34N) type D34N .
  methods GET_DATE_BOUNDARIES
    importing
      !IV_DATE_FROM type CAWN_DATE_FROM
      !IV_DATE_TO type CAWN_DATE_TO
      !IV_ATCOD type ATCOD
    exporting
      !EV_DATE_FROM type CAWN_DATE_FROM
      !EV_DATE_TO type CAWN_DATE_TO .
  methods GET_TIME_BOUNDARIES
    importing
      !IV_TIME_FROM type CAWN_TIME_FROM
      !IV_TIME_TO type CAWN_TIME_TO
      !IV_ATCOD type ATCOD
    exporting
      !EV_TIME_FROM type CAWN_TIME_FROM
      !EV_TIME_TO type CAWN_TIME_TO .
  methods GET_CURR_BOUNDARIES
    importing
      !IV_CURR_FROM type CAWN_CURR_FROM
      !IV_CURR_TO type CAWN_CURR_TO
      !IV_ATCOD type ATCOD
      !IV_ANZST type ANZST
      !IV_ATVOR type ATVOR
    exporting
      !EV_CURR_FROM type CAWN_CURR_FROM
      !EV_CURR_TO type CAWN_CURR_TO .
  methods GET_D34N_BOUNDARIES
    importing
      !IV_DEC_FROM type CAWN_DEC_FROM
      !IV_DEC_TO type CAWN_DEC_TO
      !IV_ATCOD type ATCOD
      !IV_ANZST type ANZST
      !IV_ANZDZ type ANZDZ
      !IV_ATVOR type ATVOR
      !IV_ATDEX type ATDEX
      !IV_ATDIM type ATDIM
    exporting
      !EV_DEC_FROM type CAWN_DEC_FROM
      !EV_DEC_TO type CAWN_DEC_TO .
  methods GET_VALUE_BOUNDARIES
    importing
      !IV_VALUE_FROM type ANY
      !IV_VALUE_TO type ANY
      !IV_VALUE_MIN type ANY
      !IV_VALUE_MAX type ANY
      !IV_INCREMENT type ANY
      !IV_ATCOD type ATCOD
    exporting
      !EV_VALUE_FROM type ANY
      !EV_VALUE_TO type ANY .
  methods GET_NUM_INTERVAL_DETAILS
    importing
      !IV_ANZST type ANZST
      !IV_ANZDZ type ANZDZ
      !IV_ATDEX type ATDEX
      !IV_ATDIM type ATDIM
      !IV_ATVOR type ATVOR
    exporting
      !EV_MIN type D34N
      !EV_MAX type D34N
      !EV_INC type D34N .