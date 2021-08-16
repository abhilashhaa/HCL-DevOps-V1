private section.

  types:
    BEGIN OF ts_checktable,
        mandt TYPE mandt,
        key   TYPE c LENGTH 20,
        desc  TYPE c LENGTH 20,
      END OF ts_checktable .
  types:
    tt_checktable TYPE STANDARD TABLE OF ts_checktable .

  methods SETUP .
  methods SET_CHECKTABLE_EXISTING
    importing
      !IV_CHECKTABLE type TABELLE .
  methods SET_TEXT_TABLE
    importing
      !IV_TABLE_NAME type DDOBJNAME
      !IV_TEXTTABLE type DD08V-TABNAME
      !IV_CHECKFIELD type DD08V-FIELDNAME .
  methods SET_TABLE_DETAILS
    importing
      !IV_TABLE_NAME type TABELLE
      !IT_FIELD_LIST type DD_X031L_TABLE optional
      !IT_FIELD_INFO type DDFIELDS optional .
  methods SET_SELECT_DATA
    importing
      !IV_TABLE_NAME type ATPRT
      !IT_VALUES type STANDARD TABLE .