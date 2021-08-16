class CL_NGC_CLF_API_RESULT definition
  public
  final
  create public .

public section.

  interfaces IF_NGC_CLF_API_RESULT .

  methods ADD_MESSAGES
    importing
      !IT_MESSAGE type NGCT_CLASSIFICATION_MSG .
  methods ADD_MESSAGES_FROM_CORE
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IT_CORE_MESSAGE type NGCT_CORE_MSG
      !IR_REF_KEY type ref to DATA optional
      !IV_REF_TYPE type DDOBJNAME optional .
  methods ADD_MESSAGES_FROM_CORE_CLF
    importing
      !IT_CORE_MESSAGE type NGCT_CORE_CLASSIFICATION_MSG .
  methods ADD_MESSAGES_FROM_SPI
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IT_SPI_MSG type /PLMB/T_SPI_MSG
      !IR_REF_KEY type ref to DATA optional
      !IV_REF_TYPE type DDOBJNAME optional .
  methods ADD_MESSAGE_FROM_SY
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IR_REF_KEY type ref to DATA optional
      !IV_REF_TYPE type DDOBJNAME optional .
  methods ADD_MESSAGES_FROM_SYMSG_TAB
    importing
      !IS_CLASSIFICATION_KEY type NGCS_CLASSIFICATION_KEY
      !IT_SYMSG_TAB type SYMSG_TAB .
  methods ADD_MESSAGES_FROM_API_RESULT
    importing
      !IO_CLF_API_RESULT type ref to IF_NGC_CLF_API_RESULT .