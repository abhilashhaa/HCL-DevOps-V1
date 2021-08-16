class CL_NGC_CORE_CLS_UTIL definition
  public
  final
  create public .

public section.

  constants GC_DATE_INITIAL type DATS value '00000000' ##NO_TEXT.
  constants GC_DATE_INFINITE type DATS value '99991231' ##NO_TEXT.

  class-methods MINIMUM_DATE
    importing
      !IV_DATE1 type DATS
      !IV_DATE2 type DATS
      !IV_DATE3 type DATS
    returning
      value(RV_MIN_DATE) type DATS .
  class-methods MAXIMUM_DATE
    importing
      !IV_DATE1 type DATS
      !IV_DATE2 type DATS
      !IV_DATE3 type DATS
    returning
      value(RV_MAX_DATE) type DATS .
  class-methods CHECK_OVERLAP
    importing
      !IV_VALID_FROM1 type DATS
      !IV_VALID_TO1 type DATS
      !IV_VALID_FROM2 type DATS
      !IV_VALID_TO2 type DATS
    returning
      value(RV_OVERLAP) type ABAP_BOOL .