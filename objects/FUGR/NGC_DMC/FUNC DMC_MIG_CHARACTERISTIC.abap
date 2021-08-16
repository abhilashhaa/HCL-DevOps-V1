FUNCTION dmc_mig_characteristic.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CHARACTDETAIL) LIKE  BAPICHARACTDETAIL STRUCTURE
*"        BAPICHARACTDETAIL
*"     VALUE(CHANGENUMBER) LIKE  BAPICHARACTKEY-CHANGENUM OPTIONAL
*"     VALUE(KEYDATE) LIKE  BAPICHARACTKEY-KEYDATE DEFAULT SY-DATUM
*"     VALUE(TESTRUN) LIKE  BAPIE1GLOBAL_DATA-TESTRUN OPTIONAL
*"  TABLES
*"      CHARACTDESCR STRUCTURE  BAPICHARACTDESCR
*"      CHARACTVALUESNUM STRUCTURE  BAPICHARACTVALUESNUM OPTIONAL
*"      CHARACTVALUESCHAR STRUCTURE  BAPICHARACTVALUESCHAR OPTIONAL
*"      CHARACTVALUESCURR STRUCTURE  BAPICHARACTVALUESCURR OPTIONAL
*"      CHARACTVALUESDESCR STRUCTURE  BAPICHARACTVALUESDESCR OPTIONAL
*"      CHARACTREFERENCES STRUCTURE  BAPICHARACTREFERENCES OPTIONAL
*"      CHARACTRESTRICTIONS STRUCTURE  BAPICHARACTRESTRICTIONS OPTIONAL
*"      RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
*  This BAPI creates a charact from the obtained info if the
*  charact doesn't already exist.
*  First an existence check is executed. Then some of the
*  BAPI exchange tables are converted to the database format
*  which is needed afterwards. The BAPI tables are converted
*  to the format requested by the CAMA module. Now the charact
*  is created by this module.
*....Initialization.....................................................
*....Authority check....................................................
*....Check whether charact exists, exit if no...........................
*....Initialize log.....................................................
*....Fill internal tables CABN, CAWN from BAPI-tables...................
*....Fill tables for maintainance from BAPI-tables......................
*....Create charact.....................................................
*....Put log messages to return table...................................

  CALL FUNCTION 'BAPI_CHARACT_CREATE'
    EXPORTING
      charactdetail       = charactdetail
      changenumber        = changenumber
      keydate             = keydate
    TABLES
      charactdescr        = charactdescr
      charactvaluesnum    = charactvaluesnum
      charactvalueschar   = charactvalueschar
      charactvaluescurr   = charactvaluescurr
      charactvaluesdescr  = charactvaluesdescr
      charactreferences   = charactreferences
      charactrestrictions = charactrestrictions
      return              = return.


  IF testrun = 'X'.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  ENDIF.


ENDFUNCTION.