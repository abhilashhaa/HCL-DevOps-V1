protected section.

  data MO_CUT type ref to CL_NGC_BIL_CHR .
  class-data GO_SQL_ENVIRONMENT type ref to IF_OSQL_TEST_ENVIRONMENT .

  methods SET_CHARACTERISTIC
    importing
      !IT_CHARACTERISTIC type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARC
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC_DESC
    importing
      !IT_CHARC_DESC type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARCDESC
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC_REF
    importing
      !IT_CHARC_REF type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARCREF
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC_RSTR
    importing
      !IT_CHARC_RSTR type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARCRSTRCN .
  methods SET_CHARC_VAL
    importing
      !IT_CHARC_VAL type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARCVALUE
      !IV_KEYDATE type DATS default SY-DATUM .
  methods SET_CHARC_VAL_DESC
    importing
      !IT_CHARC_VAL_DESC type CL_NGC_BIL_CHR=>LTY_CLFN_CHARC_CDS-T_CHARCVALUEDESC
      !IV_KEYDATE type DATS default SY-DATUM .