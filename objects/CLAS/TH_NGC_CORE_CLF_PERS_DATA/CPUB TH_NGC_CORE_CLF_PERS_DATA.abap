class TH_NGC_CORE_CLF_PERS_DATA definition
  public
  final
  create public
  for testing .

public section.

  types:
    tt_i_clfnobjectclass TYPE STANDARD TABLE OF i_clfnobjectclassforkeydate WITH DEFAULT KEY .
  types:
    tt_i_clfnobjectcharcval TYPE STANDARD TABLE OF i_clfnobjectcharcvalforkeydate WITH DEFAULT KEY .
  types:
    tt_i_clfnclasstype TYPE STANDARD TABLE OF i_clfnclasstype WITH DEFAULT KEY .
  types:
    BEGIN OF ts_clfn_with_kdate,
      classification TYPE tt_i_clfnobjectclass,
      keydate        TYPE dats,
    END OF ts_clfn_with_kdate .
  types:
    tt_clfn_with_kdate TYPE STANDARD TABLE OF ts_clfn_with_kdate WITH DEFAULT KEY .
  types:
    BEGIN OF ts_val_with_kdate,
      valuation      TYPE tt_i_clfnobjectcharcval,
      keydate        TYPE dats,
    END OF ts_val_with_kdate .
  types:
    tt_val_with_kdate TYPE STANDARD TABLE OF ts_val_with_kdate WITH DEFAULT KEY .

  constants CV_KEYDATE_2017 type DATS value '20170101' ##NO_TEXT.
  constants CV_KEYDATE_2018 type DATS value '20180101' ##NO_TEXT.
  constants CV_OBJECT_KEY_01 type CUOBN value 'OBJECT_01' ##NO_TEXT.
  constants CV_OBJECT_KEY_02 type CUOBN value 'OBJECT_02' ##NO_TEXT.
  constants CV_OBJECT_INTKEY_02 type CUOBN value '000000000000000002' ##NO_TEXT.
  constants CV_OBJECT_INTKEY_03 type CUOBN value '000000000000000003' ##NO_TEXT.
  constants CV_OBJECT_TABLE_MARA type TABELLE value 'MARA' ##NO_TEXT.
  constants CV_OBJECT_TABLE_MARAT type TABELLE value 'MARAT' ##NO_TEXT.
  constants CV_CLASSTYPE_001 type KLASSENART value '001' ##NO_TEXT.
  constants CV_CLASSTYPE_026 type KLASSENART value '026' ##NO_TEXT.
  constants CV_CLASSTYPE_300 type KLASSENART value '300' ##NO_TEXT.
  constants CV_CLASS_01_ID type CLINT value '0000000001' ##NO_TEXT.
  constants CV_CLASS_02_ID type CLINT value '0000000002' ##NO_TEXT.
  constants CV_CLASS_03_ID type CLINT value '0000000003' ##NO_TEXT.
  constants CV_CLASS_04_ID type CLINT value '0000000004' ##NO_TEXT.
  constants CV_CLASS_NEW_ID type CLINT value '1000000000' ##NO_TEXT.

  class-methods GET_CLASSIFICATION_2017
    returning
      value(RT_CLASSIFICATION) type TT_I_CLFNOBJECTCLASS .
  class-methods GET_CLASSIFICATION_2017_026
    returning
      value(RT_CLASSIFICATION) type TT_I_CLFNOBJECTCLASS .
  class-methods GET_VALUATION_2017
    returning
      value(RT_VALUATION) type TT_I_CLFNOBJECTCHARCVAL .
  class-methods GET_CLASS_DATA_2017
    returning
      value(RT_CLASS_DATA) type NGCT_CORE_CLASS .
  class-methods GET_AUSP_CHANGES_2017
    returning
      value(RT_AUSP_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_AUSP_CHANGES .
  class-methods GET_VALUATION_2017_026
    returning
      value(RT_VALUATION) type TT_I_CLFNOBJECTCHARCVAL .
  class-methods GET_KSSK_CHANGES_2017
    returning
      value(RT_KSSK_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_KSSK_CHANGES .
  class-methods GET_CLASS_DATA_2017_026
    returning
      value(RT_CLASS_DATA) type NGCT_CORE_CLASS .
  class-methods GET_INOB_CHANGES_2017
    returning
      value(RT_INOB_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_INOB_CHANGES .
  class-methods GET_CLASSIFICATION_UPD_2017
    returning
      value(RT_CLASSIFICATION_UPD) type NGCT_CORE_CLASSIFICATION_UPD .
  class-methods GET_AUSP_CHANGES_2017_026
    returning
      value(RT_AUSP_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_AUSP_CHANGES .
  class-methods GET_CLASSIFICATION_CREATE_2017
    returning
      value(RT_CLASSIFICATION_UPD) type NGCT_CORE_CLASSIFICATION_UPD .
  class-methods GET_CLASSIFICATION_UPDATE_2017
    returning
      value(RT_CLASSIFICATION_UPD) type NGCT_CORE_CLASSIFICATION_UPD .
  class-methods GET_CLASSIFICATION_DELETE_2017
    returning
      value(RT_CLASSIFICATION_UPD) type NGCT_CORE_CLASSIFICATION_UPD .
  class-methods GET_KSSK_CHANGES_2017_026
    returning
      value(RT_KSSK_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_KSSK_CHANGES .
  class-methods GET_LOADED_AUSP_CHANGES_2017
    returning
      value(RT_AUSP_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_AUSP_CHANGES .
  class-methods GET_INOB_CHANGES_2017_026
    returning
      value(RT_INOB_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_INOB_CHANGES .
  class-methods GET_LOADED_KSSK_CHANGES_2017
    returning
      value(RT_KSSK_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_KSSK_CHANGES .
  class-methods GET_LOADED_INOB_CHANGES_2017
    returning
      value(RT_INOB_CHANGES) type CL_NGC_CORE_CLF_PERSISTENCY=>LTY_T_INOB_CHANGES .
  class-methods GET_CLASSIFICATION_CREATE_026
    returning
      value(RT_CLASSIFICATION_UPD) type NGCT_CORE_CLASSIFICATION_UPD .
  class-methods GET_CLASSTYPES
    returning
      value(RT_CLASSTYPE) type TT_I_CLFNCLASSTYPE .
  class-methods GET_CLASSTYPES_OBJTYPE_REDUN
    returning
      value(RT_TCLAO) type TT_TCLAO .