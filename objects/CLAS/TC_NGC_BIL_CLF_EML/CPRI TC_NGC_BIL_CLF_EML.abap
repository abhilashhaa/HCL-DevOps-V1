private section.

  class-methods CLASS_SETUP .
  class-methods CLASS_TEARDOWN .
  methods GET_CLASSINTERNALID
    importing
      !IV_CLASS type KLASSE_D
      !IV_CLASSTYPE type KLASSENART
    returning
      value(RV_CLASSINTERNALID) type CLINT .
  methods GET_NOT_EXISTING_CLASSINTID
    importing
      !IV_CLASSINTERNALID type CLINT optional
    returning
      value(RV_CLASSINTERNALID) type CLINT .
  methods CHECK_CLASSIFICATION_EXIST
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_CLFNOBJECTID type CUOBN .
  methods CHECK_CLASSIFICATION_NOT_EXIST
    importing
      !IV_CLASSINTERNALID type CLINT
      !IV_CLFNOBJECTID type CUOBN .
  methods CHECK_ERRORS_INITIAL
    importing
      !IT_REPORTED type DATA
      !IT_FAILED type DATA .
  methods GET_CHARCINTERNALID
    importing
      !IV_CHARACTERISTIC type ATNAM
    returning
      value(RV_CHARCINTERNALID) type ATINN .
  methods GET_CHARCVALPOSNR
    importing
      !IV_CLFNOBJECTID type CUOBN
      !IV_CHARCINTERNALID type ATINN
      !IV_CLASSTYPE type KLASSENART
      !IV_CHARCVALUE type ATWRT
    returning
      value(RV_CHARCVALPOSNR) type ADZHL .
  methods CHECK_CHAR_VAL_NOT_EXIST
    importing
      !IV_CLFNOBJECTID type CUOBN
      !IV_CHARCINTERNALID type ATINN
      !IV_CLASSTYPE type KLASSENART
      !IV_CHARCVALUE type ATWRT .
  methods CHECK_CHARC_VAL_NOT_EXIST
    importing
      !IV_CLFNOBJECTID type CUOBN
      !IV_CHARCINTERNALID type ATINN
      !IV_CLASSTYPE type KLASSENART
      !IV_CHARCVALPOSNR type ADZHL .