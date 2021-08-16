FUNCTION dmc_mig_class.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CLASSNUMNEW) LIKE  BAPI_CLASS_KEY-CLASSNUM
*"     VALUE(CLASSTYPENEW) LIKE  BAPI_CLASS_KEY-CLASSTYPE
*"     VALUE(CHANGENUMBER) LIKE  BAPI1003_KEY-CHANGENUMBER OPTIONAL
*"     VALUE(CLASSBASICDATA) LIKE  BAPI1003_BASIC STRUCTURE
*"        BAPI1003_BASIC
*"     VALUE(CLASSDOCUMENT) LIKE  BAPI1003_DOCU STRUCTURE
*"        BAPI1003_DOCU OPTIONAL
*"     VALUE(CLASSADDITIONAL) LIKE  BAPI1003_ADD STRUCTURE
*"        BAPI1003_ADD OPTIONAL
*"     VALUE(CLASSSTANDARD) LIKE  BAPI1003_STAND STRUCTURE
*"        BAPI1003_STAND OPTIONAL
*"     VALUE(TESTRUN) LIKE  BAPIE1GLOBAL_DATA-TESTRUN OPTIONAL
*"  TABLES
*"      RETURN STRUCTURE  BAPIRET2
*"      CLASSDESCRIPTIONS STRUCTURE  BAPI1003_CATCH
*"      CLASSLONGTEXTS STRUCTURE  BAPI1003_LONGTEXT OPTIONAL
*"      CLASSCHARACTERISTICS STRUCTURE  BAPI1003_CHARACT OPTIONAL
*"      CHARACTOVERWRITE STRUCTURE  BAPI1003_CHARACT_OVERWR OPTIONAL
*"      CHARACTVALUEOVERWRITE STRUCTURE  BAPI1003_CHARACT_VALUE_OVR
*"       OPTIONAL
*"      CHARACTVALUETEXTOVR STRUCTURE  BAPI1003_CHARVALTEXT OPTIONAL
*"----------------------------------------------------------------------

  CALL FUNCTION 'BAPI_CLASS_CREATE'
    EXPORTING
      classnumnew           = classnumnew
      classtypenew          = classtypenew
      changenumber          = changenumber
      classbasicdata        = classbasicdata
      classdocument         = classdocument
      classadditional       = classadditional
      classstandard         = classstandard
    TABLES
      return                = return
      classdescriptions     = classdescriptions
      classlongtexts        = classlongtexts
      classcharacteristics  = classcharacteristics
      charactoverwrite      = charactoverwrite
      charactvalueoverwrite = charactvalueoverwrite
      charactvaluetextovr   = charactvaluetextovr.


  IF testrun = 'X'.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  ENDIF.


ENDFUNCTION.