class CL_NGC_CORE_XPRA_INOB_CLEANUP definition
  public
  final
  create public .

public section.

  types:
    begin of lts_event_count,
      event TYPE i,
      param TYPE string,
      count TYPE i,
    end of lts_event_count .
  types:
    ltt_event_count TYPE STANDARD TABLE OF lts_event_count WITH KEY event param .

  methods BEFORE_CONVERSION
    returning
      value(RV_EXIT) type BOOLE_D .
  methods AFTER_CONVERSION .
  methods CONVERT .
  methods PROCESS_PACKAGE
    importing
      !IT_PACKSEL type IF_SHDB_PFW_PACKAGE_PROVIDER=>TT_PACKSEL
    returning
      value(RT_EVENTS) type LTT_EVENT_COUNT .
  methods CONSTRUCTOR
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_CLIENT type SYMANDT .