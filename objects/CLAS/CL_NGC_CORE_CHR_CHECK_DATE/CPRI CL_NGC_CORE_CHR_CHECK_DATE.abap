private section.

  class-data GO_INSTANCE type ref to IF_NGC_CORE_CHR_VALUE_CHECK .

  methods VALIDATE_DAY
    importing
      !IV_DATE type DATS
      !IS_CHARC_HEADER type NGCS_CORE_CHARC
    exporting
      !ET_MESSAGE type NGCT_CORE_CHARC_MSG
    raising
      CX_NGC_CORE_CHR_EXCEPTION .