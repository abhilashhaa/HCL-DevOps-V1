class CL_NGC_CORE_CONV_MULTOBJ definition
  public
  create public .

public section.

  types:
    ltt_tcla        TYPE SORTED   TABLE OF tcla WITH UNIQUE KEY klart .
  types:
    ltt_kssk        TYPE SORTED   TABLE OF kssk WITH UNIQUE KEY objek klart mafid clint adzhl .
  types:
    ltt_ausp        TYPE SORTED   TABLE OF ausp WITH UNIQUE KEY objek klart atinn atzhl mafid adzhl .
  types:
    ltst_tclao      TYPE STANDARD TABLE OF tclao .
  types:
    ltst_tclax      TYPE STANDARD TABLE OF tclax .
  types:
    ltst_inob       TYPE STANDARD TABLE OF inob .
  types:
    ltst_kssk       TYPE STANDARD TABLE OF kssk .
  types:
    ltst_ausp       TYPE STANDARD TABLE OF ausp .

  constants GC_KSSKU_NAME type VIEWNAME value 'ZMO_KSSKU' ##NO_TEXT.
  constants GC_AUSPU_NAME type VIEWNAME value 'ZMO_AUSPU' ##NO_TEXT.
  data MV_KSSKU_NAME type VIEWNAME .
  data MV_AUSPU_NAME type VIEWNAME .

  methods BEFORE_CONVERSION
    returning
      value(RV_EXIT) type BOOLE_D .
  methods AFTER_CONVERSION .
  methods CONVERT .
  methods PROCESS_PACKAGE
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    raising
      CX_DATA_CONV_ERROR .
  methods AFTER_PACKAGE
    raising
      CX_SHDB_PFW_APPL_ERROR .
  methods CONSTRUCTOR
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLASS_TYPE type KLASSENART
      !IV_CUSTOMIZING_HANDLING type I default 0 .
  class-methods INIT_LOGGER
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_LOGTYPE type UPGBA_LOGTYPE default CL_UPGBA_LOGGER=>GC_LOGTYPE_TR .