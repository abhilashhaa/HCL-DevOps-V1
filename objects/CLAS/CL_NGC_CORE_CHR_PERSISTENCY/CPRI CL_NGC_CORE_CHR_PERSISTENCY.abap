private section.

  types:
    BEGIN OF ts_charc_ext_key_range.
  TYPES: key_date TYPE bapi_keydate.
  TYPES: characteristic TYPE RANGE OF atnam.
  TYPES: END OF ts_charc_ext_key_range .
  types:
    tt_charc_ext_key_range TYPE STANDARD TABLE OF ts_charc_ext_key_range .
  types:
    BEGIN OF ts_charc_int_key_range.
  TYPES: key_date TYPE bapi_keydate.
  TYPES: charcinternalid TYPE RANGE OF atinn.
  TYPES: END OF ts_charc_int_key_range .
  types:
    tt_charc_int_key_range TYPE STANDARD TABLE OF ts_charc_int_key_range .
  types:
    BEGIN OF ts_characteristic_changes .
      INCLUDE TYPE: ngcs_core_charc_key_ext AS chr_key_ext.
  TYPES: charcinternalid    TYPE atinn.
  TYPES: overwritterncharcinternalid    TYPE atinn.
  TYPES: timeintervalnumber TYPE adzhl.
  TYPES: charcstatus        TYPE atmst.
  TYPES: charcdatatype      TYPE atfor.
  TYPES: charclength        TYPE anzst.
  TYPES: charcdecimals      TYPE anzdz.
  TYPES: charctemplate      TYPE atsch.
  TYPES: object_state       TYPE ngc_core_object_state.
  TYPES: END OF ts_characteristic_changes .
  types:
    tt_characteristic_changes TYPE STANDARD TABLE OF ts_characteristic_changes WITH NON-UNIQUE DEFAULT KEY .
  types:
    BEGIN OF ts_characteristic_buffer .
      TYPES: charcinternalid TYPE atinn .
      TYPES: overwrittencharcinternalid TYPE atinn .
      TYPES: characteristic  TYPE atnam .
      TYPES: key_date        TYPE bapi_keydate .
      TYPES: charc           TYPE ngct_core_charc .
      TYPES: charc_value     TYPE ngct_core_charc_value .
      TYPES: charc_ref       TYPE ngct_core_charc_ref .
  types: END OF ts_characteristic_buffer .
  types:
    tt_characteristic_buffer TYPE STANDARD TABLE OF ts_characteristic_buffer .

  data MT_LOADED_DATA type TT_CHARACTERISTIC_CHANGES .
  data MO_CORE_UTIL type ref to IF_NGC_CORE_UTIL .
  data MO_CHR_UTIL_CHCKTABLE type ref to IF_NGC_CORE_CHR_UTIL_CHCKTABLE .
  data MO_CHR_UTIL_FUNCMOD type ref to IF_NGC_CORE_CHR_UTIL_FUNCMOD .
  data MT_BUFFERED_DATA type TT_CHARACTERISTIC_BUFFER .

  methods CONVERT_SEPARATOR_TO_USER_MASK
    importing
      !IV_TEMPLATE type ATSCH
    returning
      value(RV_TEMPLATE) type ATSCH .
  methods GET_CHARC_VALUES_CHECKTABLE
    importing
      !IT_CHARACTERISTIC type NGCT_CORE_CHARC
    exporting
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG
    changing
      !CT_CHARACTERISTIC_VALUE type NGCT_CORE_CHARC_VALUE .
  methods GET_CHARC_VALUES_FM
    importing
      !IT_CHARACTERISTIC type NGCT_CORE_CHARC
    exporting
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG
    changing
      !CT_CHARACTERISTIC_VALUE type NGCT_CORE_CHARC_VALUE .