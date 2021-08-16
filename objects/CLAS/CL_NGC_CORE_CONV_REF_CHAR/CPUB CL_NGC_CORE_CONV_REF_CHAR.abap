class CL_NGC_CORE_CONV_REF_CHAR definition
  public
  final
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .

  types:
    begin of lts_refbou,
    atinn         TYPE atinn,
    attab         TYPE attab,
    atfel         TYPE atfel,
    atfor         TYPE atfor,
    atkon         TYPE atkon,
    msehi         TYPE msehi,
    anzdz         TYPE anzdz,
    klart         TYPE klassenart,
    obtab         TYPE tabelle,
    objek         TYPE cuobn,
    ksskaennr     TYPE aennr,
    ksskdatuv     TYPE datuv,
    kssklkenz     TYPE lkenz,
    ksskdatub     TYPE datub,
    auspobjek     TYPE cuobn,
  end of lts_refbou .
  types:
    begin of lts_auspvalidity,
    obtab         TYPE tabelle,
    objek         TYPE cuobn,
    auspobjek     TYPE cuobn,
    atinn         TYPE atinn,
    ksskdatuv     TYPE datuv,
    auspdatuv     TYPE datuv,
    ksskdatub     TYPE datub,
    auspdatub     TYPE datub,
    ksskaennr     TYPE aennr,
    auspaennr     TYPE aennr,
  end of lts_auspvalidity .
  types:
    ltt_reftabs   TYPE STANDARD TABLE OF cltable WITH NON-UNIQUE DEFAULT KEY .
  types:
    begin of lts_refvalidity,
    datuv         TYPE datuv,
    aennr         TYPE aennr,
    reftabs       TYPE ltt_reftabs,
  end of lts_refvalidity .
  types:
    ltt_refbou        TYPE SORTED TABLE OF lts_refbou WITH UNIQUE KEY obtab objek auspobjek atinn attab atfel klart ksskdatuv kssklkenz ksskdatub .
  types:
    ltt_auspvalidity  TYPE SORTED TABLE OF lts_auspvalidity WITH UNIQUE KEY obtab objek auspobjek atinn ksskdatuv ksskdatub auspdatuv auspdatub ksskaennr auspaennr .
  types:
    ltt_refvalidity   TYPE SORTED TABLE OF lts_refvalidity WITH UNIQUE KEY datuv .
  types:
    ltt_ausp          TYPE STANDARD TABLE OF ausp .
  types:
    begin of lts_event_count,
      event TYPE i,
      param TYPE string,
      count TYPE i,
    end of lts_event_count .
  types:
    ltt_event_count TYPE STANDARD TABLE OF lts_event_count WITH KEY event param .
  types:
    begin of lts_clstype_ech,
      klart      TYPE klassenart,
      obtab      TYPE tabelle,
      aediezuord TYPE claedizuor,
    end of lts_clstype_ech .
  types:
    ltt_clstype_ech TYPE HASHED TABLE OF lts_clstype_ech WITH UNIQUE KEY klart obtab .
  types:
    ltt_attabs TYPE HASHED TABLE OF attab WITH UNIQUE KEY table_line .
  types:
    ltr_obtab  TYPE RANGE OF tabelle .

  constants GC_NODES_NAME type VIEWNAME value 'ZRC_NODES' ##NO_TEXT.
  constants GC_REFCHARS_NAME type VIEWNAME value 'ZRC_REFCHARS' ##NO_TEXT.
  constants GC_REFKSSK_NAME type VIEWNAME value 'ZRC_REFKSSK' ##NO_TEXT.
  constants GC_REFBO_NAME type VIEWNAME value 'ZRC_REFBO' ##NO_TEXT.
  constants GC_REFBOU_NAME type VIEWNAME value 'ZRC_REFBOU' ##NO_TEXT.
  constants GC_SIBLCHRS_NAME type VIEWNAME value 'ZRC_SIBLCHRS' ##NO_TEXT.
  constants GC_MIN_DATE type DATUB value '00000000' ##NO_TEXT.
  constants GC_MAX_DATE type DATUB value '99991231' ##NO_TEXT.
  class-data GV_NODES_NAME type VIEWNAME .
  class-data GV_REFCHARS_NAME type VIEWNAME .
  class-data GV_REFKSSK_NAME type VIEWNAME .
  class-data GV_REFBO_NAME type VIEWNAME .
  class-data GV_REFBOU_NAME type VIEWNAME .
  class-data GV_SIBLCHRS_NAME type VIEWNAME .
  constants GC_EV_OBJ_CHK_NEXIST type I value 1 ##NO_TEXT.
  constants GC_EV_BO_NEXIST type I value 2 ##NO_TEXT.
  constants GC_EV_BO_FLOCK type I value 3 ##NO_TEXT.
  constants GC_EV_BO_SYSFAIL type I value 4 ##NO_TEXT.
  constants GC_EV_TYPE_CONV_FAIL type I value 5 ##NO_TEXT.
  constants GC_EV_BO_ERRMSG type I value 6 ##NO_TEXT.
  data MV_1_COND_P_LINE_LIMIT type I .
  data MV_2_COND_P_LINE_LIMIT type I .
  data MV_3_COND_P_LINE_LIMIT type I .

  class-methods CLASS_CONSTRUCTOR .
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
  methods AFTER_PACKAGE
    importing
      !IT_EVENTS type LTT_EVENT_COUNT
    raising
      CX_SHDB_PFW_APPL_ERROR .
  methods CONSTRUCTOR
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_LANGUAGE like SY-LANGU
      !IV_REWORK type BOOLE_D .
  class-methods INIT_LOGGER
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME .