interface IF_NGC_CORE_CHR_UTIL_CHCKTABLE
  public .


  methods GET_KEY_FIELD
    importing
      !IV_CHECK_TABLE_NAME type TABELLE
    exporting
      !EV_KEY_FIELD_NAME type FIELDNAME
      !EV_CONVERSION_EXIT type CONVEXIT
      !EV_LENGTH type DDLENG
    exceptions
      TABLE_NOT_FOUND .
  methods CHECKTABLE_EXSISTS
    importing
      !IV_TABLE_NAME type TABELLE
    returning
      value(RV_EXISTS) type ABAP_BOOL .
  methods GET_TABLE_DETAILS
    importing
      !IV_TABLE_NAME type TABELLE
    exporting
      !ET_FIELD_LIST type DD_X031L_TABLE
      !ET_FIELD_INFO type DDFIELDS
    exceptions
      NOT_FOUND .
  methods SELECT_TABLE_DATA
    importing
      !IV_TABLE_NAME type ATPRT
    exporting
      !ET_VALUES type STANDARD TABLE .
endinterface.