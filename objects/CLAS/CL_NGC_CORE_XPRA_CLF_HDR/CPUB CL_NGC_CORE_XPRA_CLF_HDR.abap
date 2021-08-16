class CL_NGC_CORE_XPRA_CLF_HDR definition
  public
  final
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .

  types:
    begin of lts_event_count,
      event TYPE i,
      param TYPE string,
      count TYPE i,
    end of lts_event_count .
  types:
    ltt_event_count TYPE STANDARD TABLE OF lts_event_count WITH KEY event param .

  constants GC_CLFHDRS_NAME type VIEWNAME value 'ZCH_CLFHDRS' ##NO_TEXT.
  constants GC_CLFHDRM_NAME type VIEWNAME value 'ZCH_CLFHDRM' ##NO_TEXT.
  constants GC_KSSKS_NAME type VIEWNAME value 'ZCH_KSSKS' ##NO_TEXT.
  constants GC_KSSKM_NAME type VIEWNAME value 'ZCH_KSSKM' ##NO_TEXT.
  constants GC_KSSKK_NAME type VIEWNAME value 'ZCH_KSSKK' ##NO_TEXT.
  constants GC_EV_MULTICUOBJ type I value 1 ##NO_TEXT.

  class-methods BEFORE_CONVERSION
    importing
      !IV_CLIENT type SYMANDT
    returning
      value(RV_EXIT) type BOOLE_D .
  class-methods AFTER_CONVERSION .
  methods CONVERT .
  methods PROCESS_PACKAGE_CM
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods PROCESS_PACKAGE_CS
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods PROCESS_PACKAGE_M
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods PROCESS_PACKAGE_K
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods PROCESS_PACKAGE_S
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods AFTER_PACKAGE
    importing
      !IT_EVENTS type LTT_EVENT_COUNT
    raising
      CX_SHDB_PFW_APPL_ERROR .
  methods CONSTRUCTOR
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT type SYMANDT .