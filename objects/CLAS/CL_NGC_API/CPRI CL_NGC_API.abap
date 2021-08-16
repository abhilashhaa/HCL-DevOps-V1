private section.

  types:
    BEGIN OF lty_s_class_of_classification .
      TYPES: class_key TYPE ngcs_class_key.
      TYPES: classification_key TYPE ngcs_classification_key.
    TYPES: END OF lty_s_class_of_classification .
  types:
    lty_t_class_of_classification TYPE STANDARD TABLE OF lty_s_class_of_classification WITH NON-UNIQUE DEFAULT KEY .

  data MO_API_FACTORY type ref to CL_NGC_API_FACTORY .
  data MO_CLF_PERSISTENCY type ref to IF_NGC_CORE_CLF_PERSISTENCY .
  data MO_CLS_PERSISTENCY type ref to IF_NGC_CORE_CLS_PERSISTENCY .
  data MO_CLF_VALIDATION_MGR type ref to CL_NGC_CLF_VALIDATION_MGR .
  data MO_CHR_PERSISTENCY type ref to IF_NGC_CORE_CHR_PERSISTENCY .
  class-data:
    GT_VALID_CHARCDATATYPE type range of ATFOR .

  methods GET_UPDATED_DATA
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !ET_CORE_CLASSIFICATION_UPD type NGCT_CORE_CLASSIFICATION_UPD
      !ET_CORE_CLASS type NGCT_CORE_CLASS
      !ET_CLF_CORE_MESSAGE type NGCT_CORE_CLASSIFICATION_MSG .
  methods GET_CLASSES_BY_CLASSIFICATION
    importing
      !IT_CLASSIFICATION type NGCT_CORE_CLASSIFICATION
    exporting
      !ET_CLASS type NGCT_CLASS_OBJECT
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .
  methods UPDATE
    importing
      !IT_CLASSIFICATION_OBJECT type NGCT_CLASSIFICATION_OBJECT
    exporting
      !EO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .