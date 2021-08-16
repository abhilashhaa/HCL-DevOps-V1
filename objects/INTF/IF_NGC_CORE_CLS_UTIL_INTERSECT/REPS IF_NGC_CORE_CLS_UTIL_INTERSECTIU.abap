interface IF_NGC_CORE_CLS_UTIL_INTERSECT
  public .


  types:
    BEGIN OF ts_float_value,
      atflv TYPE atflv,
      atflb TYPE atflb,
      atcod TYPE atcod,
    END OF ts_float_value .
  types:
    tt_float_value TYPE STANDARD TABLE OF ts_float_value WITH NON-UNIQUE DEFAULT KEY .

  methods CALCULATE_INTERSECTION
    importing
      !IV_CHARCDATATYPE type ATFOR
      !IT_COLLECTED_CHAR_VALUES type NGCT_CORE_CLASS_CHARC_INTER
    exporting
      !ES_COLLECTED_CHAR_VALUE type NGCS_CORE_CLASS_CHARC_INTER .
  methods BUILD_STRING
    importing
      !IV_CHARCINTERNALID type ATINN
      !IS_CHARC_HEAD type NGCS_CORE_CHARC_HEADER
      !IV_SIMPLIFY_VALUE type ABAP_BOOL default ABAP_FALSE
    exporting
      !ET_CORE_MESSAGE type NGCT_CORE_MSG
    changing
      !CS_CHARC_VALUE type NGCS_CORE_CHARC_VALUE_DATA .
endinterface.