interface IF_NGC_BIL_CLS_TRANSACTIONAL
  public .


  methods ADJUST_NUMBERS
    exporting
      !ET_CLASS_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_MAPPED_LATE
      !ET_CLASS_DESC_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-T_MAPPED_LATE
      !ET_CLASS_KEYWORD_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_MAPPED_LATE
      !ET_CLASS_TEXT_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-T_MAPPED_LATE
      !ET_CLASS_CHARC_MAPPED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSCHARCTP-T_MAPPED_LATE .
  methods CHECK_BEFORE_SAVE
    exporting
      !ET_CLASS_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_FAILED
      !ET_CLASS_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTP-T_REPORTED
      !ET_CLASS_DESC_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-T_FAILED
      !ET_CLASS_DESC_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSDESCTP-T_REPORTED
      !ET_CLASS_TEXT_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-T_FAILED
      !ET_CLASS_TEXT_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSTEXTTP-T_REPORTED
      !ET_CLASS_KEYWORD_FAILED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_FAILED
      !ET_CLASS_KEYWORD_REPORTED type IF_NGC_BIL_CLS_C=>LTY_CLFNCLASSKEYWORDTP-T_REPORTED .
endinterface.