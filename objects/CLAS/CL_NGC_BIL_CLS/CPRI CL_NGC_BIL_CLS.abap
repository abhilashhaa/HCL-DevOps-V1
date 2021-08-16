private section.

  types:
    BEGIN OF lty_s_class_create,
      cid             TYPE string,
      classinternalid TYPE clint,
      classtype       TYPE klassenart,
      class           TYPE klasse_d,
      changenumber    TYPE aennr,
      s_class         TYPE lty_clfn_class_cds-s_class,
      t_classdesc     TYPE lty_clfn_class_cds-t_classdesc,
      t_classkeyword  TYPE lty_clfn_class_cds-t_classkeyword,
      t_classtext     TYPE lty_clfn_class_cds-t_classtext,
      t_classcharc    TYPE lty_clfn_class_cds-t_classcharc,
    END OF lty_s_class_create .
  types:
    lty_t_class_create TYPE STANDARD TABLE OF lty_s_class_create  WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_class_keyword.
      INCLUDE TYPE bapi1003_catch_new.
  TYPES: classkeywordpositionnumber TYPE klapos.
  TYPES: created TYPE abap_bool.
  TYPES: END OF lty_s_class_keyword .
  types:
    lty_t_class_keyword TYPE STANDARD TABLE OF lty_s_class_keyword WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_class_charc.
      INCLUDE TYPE bapi1003_charact_new.
  TYPES: charcinternalid TYPE atinn.
  TYPES: END OF lty_s_class_charc .
  types:
    lty_t_class_charc TYPE STANDARD TABLE OF lty_s_class_charc WITH DEFAULT KEY .
  types:
    BEGIN OF lty_s_class_change,
      cid                TYPE string,
      classinternalid    TYPE clint,
      classtype          TYPE klassenart,
      class              TYPE klasse_d,
      t_classdesc        TYPE tt_bapi1003_catch_new,
      t_classkeyword     TYPE lty_t_class_keyword,
      t_classtext        TYPE tt_bapi1003_longtext,
      t_classcharc       TYPE lty_t_class_charc,
      s_classbasic_new   TYPE bapi1003_basic_new,
      s_classbasic       TYPE bapi1003_basic_new,
      t_classdesc_new    TYPE tt_bapi1003_catch_new,
      t_classkeyword_new TYPE lty_t_class_keyword,
      t_classtext_new    TYPE tt_bapi1003_longtext,
      t_classcharc_new   TYPE lty_t_class_charc,
      t_operation_log    TYPE STANDARD TABLE OF string WITH DEFAULT KEY,
    END OF lty_s_class_change .
  types:
    lty_t_class_change TYPE STANDARD TABLE OF lty_s_class_change WITH DEFAULT KEY .

  constants:
    BEGIN OF gc_operation_type,
      create_class   TYPE string VALUE 'CLASS_CREATE',
      delete_class   TYPE string VALUE 'CLASS_DELETE',
      update_class   TYPE string VALUE 'CLASS_UPDATE',
      create_desc    TYPE string VALUE 'DESC_CREATE',
      delete_desc    TYPE string VALUE 'DESC_DELETE',
      update_desc    TYPE string VALUE 'DESC_UPDATE',
      create_keyword TYPE string VALUE 'KEYWORD_CREATE',
      delete_keyword TYPE string VALUE 'KEYWORD_DELETE',
      update_keyword TYPE string VALUE 'KEYWORD_UPDATE',
      create_text    TYPE string VALUE 'TEXT_CREATE',
      delete_text    TYPE string VALUE 'TEXT_DELETE',
      update_text    TYPE string VALUE 'TEXT_UPDATE',
      create_charc   TYPE string VALUE 'CHARC_CREATE',
      delete_charc   TYPE string VALUE 'CHARC_DELETE',
      update_charc   TYPE string VALUE 'CHARC_UPDATE',
    END OF gc_operation_type .
  class-data GO_INSTANCE type ref to IF_NGC_BIL_CLS .
  data MO_BAPI_MESSAGE_CONVERT type ref to IF_RAP_PLMI_BAPI_MSG_CONVERT .
  data MO_SY_MESSAGE_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT .
  data MO_VDM_API_MAPPER type ref to IF_VDM_PLMB_API_MAPPER .
  data MO_NGC_DB_ACCESS type ref to IF_NGC_RAP_CLS_BAPI_UTIL .
  data MO_EXC_MESSAGE_CONVERT type ref to IF_RAP_PLMI_EXC_MSG_CONVERT  ##NEEDED.
  data MT_CLASS_DELETE type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_DELETE .
  constants GC_ERROR_TYPES type STRING value 'EAX' ##NO_TEXT.
  data MT_CLASS_CHANGE type LTY_T_CLASS_CHANGE .
  data MT_CLASS_CREATE type LTY_T_CLASS_CHANGE .

  methods CONSTRUCTOR
    importing
      !IO_SY_MSG_CONVERT type ref to IF_RAP_PLMI_SY_MSG_CONVERT
      !IO_VDM_API_MAPPER type ref to IF_VDM_PLMB_API_MAPPER
      !IO_BAPI_MESSAGE_CONVERT type ref to IF_RAP_PLMI_BAPI_MSG_CONVERT
      !IO_EXC_MESSAGE_CONVERT type ref to IF_RAP_PLMI_EXC_MSG_CONVERT optional
      !IO_CLS_BAPI_UTIL type ref to IF_NGC_RAP_CLS_BAPI_UTIL optional .
  methods GET_ANCESTOR_IDX
    importing
      !IV_CID_REF type STRING
    returning
      value(RV_IDX) type I .
  methods LOAD_CLASS_DATA
    importing
      !IV_CLASSINTERNALID type CLINT .
  methods MODIFY_CLASS_DATA
    importing
      !IS_CLASS_DATA type LTY_S_CLASS_CHANGE
      !IV_CLEAR_BUFFER type ABAP_BOOL optional
      !IV_DEEP_INSERT type ABAP_BOOL optional
    returning
      value(RT_RETURN) type BAPIRETTAB .
  methods MAP_CLASSDESC_VDM_API
    importing
      !IS_CLASSDESC_VDM type I_CLFNCLASSDESCFORKEYDATETP optional
      !IS_CLASSDESC_VDM_UPD type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-S_UPDATE optional
      !IS_CLASSDESC_NEW_API type BAPI1003_CATCH_NEW optional
    returning
      value(RS_CLASSDESC_API) type BAPI1003_CATCH_NEW .
  methods MAP_CLASSKEYWORD_VDM_API
    importing
      !IS_CLASSKEYWORD_VDM type I_CLFNCLASSKEYWORDFORKEYDATETP optional
      !IS_CLASSKEYWORD_VDM_UPD type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-S_UPDATE optional
      !IS_CLASSKEYWORD_NEW_API type LTY_S_CLASS_KEYWORD optional
    returning
      value(RS_CLASSKEYWORD_API) type LTY_S_CLASS_KEYWORD .
  methods MAP_CLASSTEXT_VDM_API
    importing
      !IS_CLASSTEXT_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASSTEXT optional
      !IS_CLASSTEXT_API type BAPI1003_LONGTEXT optional
      !IS_CLASSTEXT_VDM_UPD type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-S_UPDATE optional
    returning
      value(RS_CLASSTEXT_API) type BAPI1003_LONGTEXT .
  methods MAP_CLASSCHARC_VDM_API
    importing
      !IS_CLASSCHARC_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASSCHARC optional
      !IS_CLASSCHARC_VDM_UPD type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSCHARCTP-S_UPDATE optional
      !IS_CLASSCHARC_NEW_API type LTY_S_CLASS_CHARC optional
    returning
      value(RS_CLASSCHARC_API) type LTY_S_CLASS_CHARC .
  methods MAP_CLASSBASIC_VDM_API
    importing
      !IS_CLASS_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS optional
      !IS_CLASS_VDM_UPD type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-S_UPDATE optional
      !IS_CLASSBASIC_NEW_API type BAPI1003_BASIC_NEW optional
    returning
      value(RS_CLASSBASIC_API) type BAPI1003_BASIC_NEW .
  methods MAP_CLASSADDITIONAL_VDM_API
    importing
      !IS_CLASS_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS
    returning
      value(RS_CLASSADDITIONAL_API) type BAPI1003_ADD  ##NEEDED ##RELAX.
  methods MAP_CLASSSTANDARD_VDM_API
    importing
      !IS_CLASS_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS
    returning
      value(RS_CLASSSTANDARD_API) type BAPI1003_STAND  ##NEEDED ##RELAX.
  methods MAP_CLASSDOCUMENT_VDM_API
    importing
      !IS_CLASS_VDM type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS
    returning
      value(RS_CLASSDOCUMENT_API) type BAPI1003_DOCU  ##NEEDED ##RELAX.
  methods ADD_CLASS_MESSAGE
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_CID type STRING
      !IV_SET_FAILED type ABAP_BOOL default ABAP_TRUE
      !IS_BAPIRET type BAPIRET2 optional
    changing
      !CT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_FAILED .
  methods ADD_CLASSDESC_MESSAGE
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_LANGUAGE type SPRAS default SY-LANGU
      !IV_CID type STRING
      !IS_BAPIRET type BAPIRET2 optional
      !IV_SET_FAILED type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-T_FAILED .
  methods ADD_CLASSKEYWORD_MESSAGE
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_CLASSKEYWORDPOSITIONNUMBER type KLAPOS
      !IV_LANGUAGE type SPRAS
      !IV_CID type STRING
      !IS_BAPIRET type BAPIRET2 optional
      !IV_SET_FAILED type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_FAILED .
  methods ADD_CLASSTEXT_MESSAGE
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_LANGUAGE type LANGU
      !IV_LONGTEXTID type TEXTID
      !IV_CID type STRING
      !IS_BAPIRET type BAPIRET2 optional
      !IV_SET_FAILED type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-T_FAILED .
  methods ADD_CLASSCHARC_MESSAGE
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_CHARCINTERNALID type ATINN
      !IV_CID type STRING
      !IS_BAPIRET type BAPIRET2 optional
      !IV_SET_FAILED type ABAP_BOOL default ABAP_TRUE
    changing
      !CT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSCHARCTP-T_REPORTED
      !CT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSCHARCTP-T_FAILED .
  methods READ_CLASS_DATA_BY_ID
    importing
      !IV_CLASSINTERNALID type ATINN
    exporting
      !ES_CLASS type LTY_CLFN_CLASS_CDS-S_CLASS
      !ET_CLASSDESC type LTY_CLFN_CLASS_CDS-T_CLASSDESC
      !ET_CLASSKEYWORD type LTY_CLFN_CLASS_CDS-T_CLASSKEYWORD
      !ET_CLASSTEXT type LTY_CLFN_CLASS_CDS-T_CLASSTEXT
      !ET_CLASSCHARC type LTY_CLFN_CLASS_CDS-T_CLASSCHARC .
  methods SINGLE_CLASS_BY_EXT_ID
    importing
      !IV_CLASS type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASS
      !IV_CLASSTYPE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSTYPE
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RS_CLASS) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS .
  methods SINGLE_CLASS_BY_INT_ID
    importing
      !IV_CLASSINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSINTERNALID
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RS_CLASS) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS .
  methods CLASSKEYWORD_BY_INT_ID
    importing
      !IV_CLASSINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSINTERNALID
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RT_CLASSKEYWORD) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSKEYWORD .
  methods CLASSDESC_BY_INT_ID
    importing
      !IV_CLASSINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSINTERNALID
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RT_CLASSDESC) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSDESC .
  methods CLASSTEXT_BY_INT_ID
    importing
      !IV_CLASSINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSINTERNALID
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RT_CLASSTEXT) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSTEXT .
  methods CLASSCHARC_BY_INT_ID
    importing
      !IV_CLASSINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSINTERNALID
      !IV_KEYDATE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-KEYDATE default SY-DATUM
    returning
      value(RT_CLASSCHARC) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSCHARC .
  methods CLASSTEXT_ID
    importing
      !IV_CLASSTYPE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSTYPE
    returning
      value(RT_CLASSTEXT_ID) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSTEXT_ID .
  methods GET_CHARACTERISTIC
    importing
      !IV_CHARCINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CHARC-CHARCINTERNALID
    returning
      value(RV_CHARACTERISTIC) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CHARC-CHARACTERISTIC .
  methods GET_CHARCINTERNALID
    importing
      !IV_CHARACTERISTIC type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CHARC-CHARACTERISTIC
    returning
      value(RV_CHARCINTERNALID) type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CHARC-CHARCINTERNALID .
  methods IS_CHARC_RESTICTED
    importing
      !IV_CHARCINTERNALID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CHARC-CHARCINTERNALID
      !IV_CLASSTYPE type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-S_CLASS-CLASSTYPE
    returning
      value(RV_RESULT) type BOOLE_D .