class TH_NGC_CORE_CLS_PERS_DATA definition
  public
  final
  create public
  for testing .

public section.

  types:
    tt_i_clfnclass TYPE STANDARD TABLE OF i_clfnclassforkeydate WITH DEFAULT KEY .
  types:
    tt_i_clfnclassstatus TYPE STANDARD TABLE OF i_clfnclassstatus WITH DEFAULT KEY .
  types:
    tt_i_clfnclasshiercharc TYPE STANDARD TABLE OF i_clfnclasshiercharcforkeydate WITH DEFAULT KEY .
  types:
    tt_i_clfnobjectcharcvaluebasic TYPE STANDARD TABLE OF i_clfnobjectcharcvaluebasic WITH DEFAULT KEY .
  types:
    tt_i_clfnobjectclassbasic TYPE STANDARD TABLE OF i_clfnobjectclassbasic WITH DEFAULT KEY .
  types:
    tt_i_clfnclasssuperior TYPE STANDARD TABLE OF i_clfnclasssuperiorforkeydate WITH DEFAULT KEY .
  types:
    tt_i_clfnclasscharcbasic TYPE STANDARD TABLE OF i_clfnclasscharcbasic WITH DEFAULT KEY .
  types:
    tt_i_clfncharcbasic TYPE STANDARD TABLE OF i_clfncharcbasic WITH DEFAULT KEY .
  types:
    BEGIN OF ts_class_with_keydate,
        classes TYPE tt_i_clfnclass,
        keydate TYPE dats,
      END OF ts_class_with_keydate .
  types:
    tt_class_with_keydate TYPE STANDARD TABLE OF ts_class_with_keydate .
  types:
    BEGIN OF ts_class_chr_with_keydate,
        class_charcs TYPE tt_i_clfnclasshiercharc,
        keydate TYPE dats,
      END OF ts_class_chr_with_keydate .
  types:
    tt_class_chr_with_keydate TYPE STANDARD TABLE OF ts_class_chr_with_keydate .

  constants CV_CLASS_NAME type KLASSE_D value 'TEST_CLASS' ##NO_TEXT.
  constants CV_CLASS_01_ID type CLINT value '0000000001' ##NO_TEXT.
  constants CV_CLASS_02_ID type CLINT value '0000000002' ##NO_TEXT.
  constants CV_KEYDATE_2017 type DATS value '20170101' ##NO_TEXT.
  constants CV_KEYDATE_2018 type DATS value '20180101' ##NO_TEXT.
  constants CV_CLASSTYPE_001 type KLASSENART value '001' ##NO_TEXT.
  constants CV_CLASSTYPE_300 type KLASSENART value '300' ##NO_TEXT.
  constants CV_CHARC_01_ID type ATINN value '0000000001' ##NO_TEXT.
  constants CV_CHARC_02_ID type ATINN value '0000000002' ##NO_TEXT.
  constants CV_CHARC_OVERWRITTEN_ID type ATINN value '2000000000' ##NO_TEXT.

  class-methods GET_CLASSES_2017
    returning
      value(RT_CLASS) type TT_I_CLFNCLASS .
  class-methods GET_CLASSES_2018
    returning
      value(RT_CLASS) type TT_I_CLFNCLASS .
  class-methods GET_CLASS_CHARCS_2017
    returning
      value(RT_CLASS_CHARC) type TT_I_CLFNCLASSHIERCHARC .
  class-methods GET_CLASS_CHARCS_2018
    returning
      value(RT_CLASS_CHARC) type TT_I_CLFNCLASSHIERCHARC .
  class-methods GET_CLASS_CHARCS_OVERWR_2017
    returning
      value(RT_CLASS_CHARC) type TT_I_CLFNCLASSHIERCHARC .
  class-methods GET_CLASS_CHARCS_INHERIT_2017
    returning
      value(RT_CLASS_CHARC) type TT_I_CLFNCLASSHIERCHARC .
  class-methods GET_CLASS_CLASSIFICATION_BASIC
    returning
      value(RT_CLASS) type TT_I_CLFNOBJECTCLASSBASIC .
  class-methods GET_CHARC_VALUES
    returning
      value(RT_CHARC_VALUE) type NGCT_CORE_CHARC_VALUE .
  class-methods GET_CHARC_VALUES_OVERWR
    returning
      value(RT_CHARC_VALUE) type NGCT_CORE_CHARC_VALUE .
  class-methods GET_CHARC_VALUES_INHERIT
    returning
      value(RT_CHARC_VALUE) type NGCT_CORE_CHARC_VALUE .
  class-methods GET_CHARC_VALUES_INHERIT_DB
    returning
      value(RT_CLASS_CHARC_VALUE) type TT_I_CLFNOBJECTCHARCVALUEBASIC .
  class-methods GET_CHARC_REF
    returning
      value(RT_CHARC_REF) type NGCT_CORE_CHARC_REF .
  class-methods GET_CLASS_STATUSES
    returning
      value(RT_STATUS) type TT_I_CLFNCLASSSTATUS .
  class-methods GET_CLASS_SUPERIOR_2017
    returning
      value(RT_CLASS_SUPERIOR) type TT_I_CLFNCLASSSUPERIOR .
  class-methods GET_CLASS_CHARC_BASIC_2017
    returning
      value(RT_CLASS_CHARC_BASIC) type TT_I_CLFNCLASSCHARCBASIC .
  class-methods GET_CHARC_BASIC_2017
    returning
      value(RT_CHARC_BASIC) type TT_I_CLFNCHARCBASIC .
  class-methods GET_CLASS_SUPERIOR_2018
    returning
      value(RT_CLASS_SUPERIOR) type TT_I_CLFNCLASSSUPERIOR .
  class-methods GET_CLASS_CHARC_BASIC_2018
    returning
      value(RT_CLASS_CHARC_BASIC) type TT_I_CLFNCLASSCHARCBASIC .
  class-methods GET_CHARC_BASIC_2018
    returning
      value(RT_CHARC_BASIC) type TT_I_CLFNCHARCBASIC .
  class-methods GET_CLASS_SUPERIOR_INH_2017
    returning
      value(RT_CLASS_SUPERIOR) type TT_I_CLFNCLASSSUPERIOR .
  class-methods GET_CLASS_CHARC_BASIC_INH_2017
    returning
      value(RT_CLASS_CHARC_BASIC) type TT_I_CLFNCLASSCHARCBASIC .
  class-methods GET_CHARC_BASIC_INH_2017
    returning
      value(RT_CHARC_BASIC) type TT_I_CLFNCHARCBASIC .
  class-methods GET_CLASS_SUPERIOR_OVR_2017
    returning
      value(RT_CLASS_SUPERIOR) type TT_I_CLFNCLASSSUPERIOR .
  class-methods GET_CLASS_CHARC_BASIC_OVR_2017
    returning
      value(RT_CLASS_CHARC_BASIC) type TT_I_CLFNCLASSCHARCBASIC .
  class-methods GET_CHARC_BASIC_OVR_2017
    returning
      value(RT_CHARC_BASIC) type TT_I_CLFNCHARCBASIC .