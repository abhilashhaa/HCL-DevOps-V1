class CL_NGC_CHR_API_RESULT definition
  public
  final
  create public .

public section.

  interfaces IF_NGC_CHR_API_RESULT .

  methods ADD_MESSAGES
    importing
      !IT_MESSAGE type NGCT_CHARACTERISTIC_MSG .
  methods ADD_MESSAGES_FROM_CORE
    importing
      !IT_CORE_MESSAGE type NGCT_CORE_CHARC_MSG .
  methods ADD_MESSAGES_FROM_SPI
    importing
      !IS_CHARACTERISTIC_KEY type NGCS_CHARACTERISTIC_KEY
      !IR_REF_KEY type ref to DATA optional
      !IT_SPI_MSG type /PLMB/T_SPI_MSG .
  methods ADD_MESSAGE_FROM_SY
    importing
      !IS_CHARACTERISTIC_KEY type NGCS_CHARACTERISTIC_KEY
      !IR_REF_KEY type ref to DATA optional .
  methods ADD_MESSAGES_FROM_API_RESULT
    importing
      !IO_CHR_API_RESULT type ref to IF_NGC_CHR_API_RESULT .