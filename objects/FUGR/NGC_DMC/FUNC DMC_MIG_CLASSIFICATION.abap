FUNCTION dmc_mig_classification .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(OBJECTKEYNEW) LIKE  BAPI1003_KEY-OBJECT OPTIONAL
*"     VALUE(OBJECTTABLENEW) LIKE  BAPI1003_KEY-OBJECTTABLE
*"     VALUE(CLASSNUMNEW) LIKE  BAPI1003_KEY-CLASSNUM
*"     VALUE(CLASSTYPENEW) LIKE  BAPI1003_KEY-CLASSTYPE
*"     VALUE(STATUS) LIKE  BAPI1003_KEY-STATUS DEFAULT '1'
*"     VALUE(STANDARDCLASS) LIKE  BAPI1003_KEY-STDCLASS OPTIONAL
*"     VALUE(CHANGENUMBER) LIKE  BAPI1003_KEY-CHANGENUMBER OPTIONAL
*"     VALUE(KEYDATE) LIKE  BAPI1003_KEY-KEYDATE DEFAULT SY-DATUM
*"     VALUE(NO_DEFAULT_VALUES) LIKE  BAPI1003_KEY-FLAG DEFAULT SPACE
*"     VALUE(OBJECTKEYNEW_LONG) LIKE  BAPI1003_KEY-OBJECT_LONG OPTIONAL
*"     VALUE(TESTRUN) LIKE  BAPIE1GLOBAL_DATA-TESTRUN OPTIONAL
*"  EXPORTING
*"     VALUE(CLASSIF_STATUS) LIKE  BAPI1003_KEY-STATUS
*"  TABLES
*"      ALLOCVALUESNUM STRUCTURE  BAPI1003_ALLOC_VALUES_NUM OPTIONAL
*"      ALLOCVALUESCHAR STRUCTURE  BAPI1003_ALLOC_VALUES_CHAR OPTIONAL
*"      ALLOCVALUESCURR STRUCTURE  BAPI1003_ALLOC_VALUES_CURR OPTIONAL
*"      RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
*  This BAPI creates an allcation and its validation if the
*  allocation doesn't exist already.
*....Check object is no class...........................................
*....Initialization....................................................
*....Log initialization.................................................
*....Authority check....................................................
*....Check existence of allocation......................................
*....Set return messages: Allocation exists.............................
*....Convert BAPI format to CACL format.................................
*....Get class name from class number...................................
*....Create allocation..................................................
*....Set return messages................................................
*....Get log messages to BAPI return table..............................

  CALL FUNCTION 'BAPI_OBJCL_CREATE'
    EXPORTING
      objectkeynew      = objectkeynew
      objecttablenew    = objecttablenew
      classnumnew       = classnumnew
      classtypenew      = classtypenew
      status            = status
      standardclass     = standardclass
      changenumber      = changenumber
      keydate           = keydate
      no_default_values = no_default_values
      objectkeynew_long = objectkeynew_long
    IMPORTING
      classif_status    = classif_status
    TABLES
      allocvaluesnum    = allocvaluesnum
      allocvalueschar   = allocvalueschar
      allocvaluescurr   = allocvaluescurr
      return            = return.

  IF testrun = 'X'.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  ENDIF.

ENDFUNCTION.