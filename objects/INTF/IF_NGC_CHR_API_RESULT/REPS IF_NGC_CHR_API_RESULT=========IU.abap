interface IF_NGC_CHR_API_RESULT
  public .


  methods GET_MESSAGES
    importing
      !IV_MESSAGE_TYPE type MSGTY optional
    returning
      value(RT_MESSAGE) type NGCT_CHARACTERISTIC_MSG .
  methods HAS_ERROR_OR_WORSE
    returning
      value(RV_HAS_ERROR_OR_WORSE) type BOOLE_D .
  methods HAS_MESSAGE
    returning
      value(RV_HAS_MESSAGE) type BOOLE_D .
endinterface.