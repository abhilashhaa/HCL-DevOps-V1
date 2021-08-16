protected section.

  data MO_CUT type ref to CL_NGC_BIL_CLS .
  class-data GO_SQL_ENVIRONMENT type ref to IF_OSQL_TEST_ENVIRONMENT .

*  methods SET_TEST_DOUBLE .
  methods GET_EXPECTED_BUFFER
    returning
      value(RT_BUFFER) type CL_NGC_BIL_CLS=>LTY_T_CLASS_CHANGE .
  methods SET_CLASS
    importing
      !IT_CLASS type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASS
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CLASS_CHARC
    importing
      !IT_CLASS_CHARC type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSCHARC
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CLASS_DESC
    importing
      !IT_CLASS_DESC type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSDESC
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CLASS_KEYWORD
    importing
      !IT_CLASS_KEYWORD type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSKEYWORD
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CLASS_TEXT
    importing
      !IT_CLASS_TEXT type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSTEXT
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC_RSTRCN
    importing
      !IT_CHARC_RSTRCN type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CHARCRSTRCN
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC
    importing
      !IT_CHARC type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CHARC
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_TEXT_ID
    importing
      !IT_TEXT_ID type CL_NGC_BIL_CLS=>LTY_CLFN_CLASS_CDS-T_CLASSTEXT_ID .