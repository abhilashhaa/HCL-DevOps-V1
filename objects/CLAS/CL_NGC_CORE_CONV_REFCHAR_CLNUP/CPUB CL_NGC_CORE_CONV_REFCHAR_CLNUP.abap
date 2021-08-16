class CL_NGC_CORE_CONV_REFCHAR_CLNUP definition
  public
  final
  create public .

public section.

  interfaces IF_SERIALIZABLE_OBJECT .

  types:
    BEGIN OF lts_nodekey,
        obtab     TYPE tabelle,
        objek     TYPE cuobn,
        auspobjek TYPE cuobn,
        atinn     TYPE atinn,
        klart     TYPE klassenart,
        attab     TYPE attab,
        atfel     TYPE atfel,
        datuv     TYPE datuv,
        atnam     TYPE atnam,
      END OF lts_nodekey .
  types:
    BEGIN OF lts_delete_ausp,
        trueobjek TYPE cuobn,
        objek     TYPE cuobn,
        klart     TYPE klassenart,
        atinn     TYPE atinn,
        atnam     TYPE atnam,
      END OF lts_delete_ausp .
  types:
    ltt_reftabs        TYPE STANDARD TABLE OF cltable WITH NON-UNIQUE DEFAULT KEY .
  types:
    ltt_nodekey        TYPE SORTED TABLE OF lts_nodekey WITH UNIQUE KEY obtab objek datuv auspobjek atinn attab atfel klart atnam .
  types:
    ltt_delete_ausp    TYPE SORTED TABLE OF lts_delete_ausp WITH UNIQUE KEY trueobjek objek klart atinn atnam .
  types:
    ltt_ausp           TYPE STANDARD TABLE OF ausp .
  types:
    BEGIN OF lts_event_count,
        event TYPE i,
        param TYPE string,
        count TYPE i,
      END OF lts_event_count .
  types:
    ltt_event_count TYPE STANDARD TABLE OF lts_event_count WITH KEY event param .
  types:
    BEGIN OF lts_object_check_name,
        obtab   TYPE tabelle,
        fkbname TYPE rs38l_fnam,
      END OF lts_object_check_name .
  types:
    ltt_object_check_names    TYPE HASHED TABLE OF lts_object_check_name WITH UNIQUE KEY obtab .
  types:
    ltr_obtab  TYPE RANGE OF tabelle .
  types:
    ltr_objek  TYPE RANGE OF cuobn .

  constants GC_REFCHARS_NAME type VIEWNAME value 'ZRCC_REFVALS' ##NO_TEXT.
  constants GC_NODES_NAME type VIEWNAME value 'ZRCC_NODES' ##NO_TEXT.
  class-data GV_REFCHARS_NAME type VIEWNAME .
  class-data GV_NODES_NAME type VIEWNAME .
  constants GC_EV_OBJ_CHK_NEXIST type I value 1 ##NO_TEXT.
  constants GC_EV_BO_NEXIST type I value 2 ##NO_TEXT.
  constants GC_EV_BO_FLOCK type I value 3 ##NO_TEXT.
  constants GC_EV_BO_SYSFAIL type I value 4 ##NO_TEXT.
  constants GC_EV_TYPE_CONV_FAIL type I value 5 ##NO_TEXT.
  constants GC_EV_BO_ERRMSG type I value 6 ##NO_TEXT.
  constants GC_EV_NUM_DEL_ENTRIES type I value 7 ##NO_TEXT.
  constants GC_NO_NAME type RS38L_FNAM value '-' ##NO_TEXT.
  data MV_1_COND_P_LINE_LIMIT type I .
  data MV_2_COND_P_LINE_LIMIT type I .
  data MV_3_COND_P_LINE_LIMIT type I .
  constants GC_LINE_SIZE type I value 140 ##NO_TEXT.

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
      !IV_LOCK type BOOLE_D
      !IV_LOG2FILE type BOOLE_D default ' '
      !IV_TESTMODE type BOOLE_D
      !ITR_OBJEK type LTR_OBJEK optional .
  methods INIT_LOGGER
    importing
      !IV_APPL_NAME type IF_SHDB_PFW_DEF=>TV_PFW_APPL_NAME
      !IV_LOG2FILE type BOOLE_D default ' ' .