interface IF_NGC_CORE_CHR_VALUE_CHECK
  public .


  methods CHECK_VALUE
    importing
      !IS_CHARC_HEADER type NGCS_CORE_CHARC
    exporting
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG
    changing
      !CS_CHARC_VALUE type NGCS_CORE_CHARC_VALUE
    raising
      CX_NGC_CORE_CHR_EXCEPTION .
endinterface.