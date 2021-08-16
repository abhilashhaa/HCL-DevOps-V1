FUNCTION dmc_mig_class_hiera .
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(CLASSNUM) LIKE  BAPI1003_KEY-CLASSNUM
*"     VALUE(CLASSTYPE) LIKE  BAPI1003_KEY-CLASSTYPE
*"     VALUE(KEYDATE) LIKE  BAPI1003_KEY-KEYDATE DEFAULT SY-DATUM
*"     VALUE(CHANGENUMBER) LIKE  BAPI1003_KEY-CHANGENUMBER OPTIONAL
*"     VALUE(TESTRUN) LIKE  BAPIE1GLOBAL_DATA-TESTRUN OPTIONAL
*"  TABLES
*"      SUBSTRUCLIST STRUCTURE  BAPI1003_TREE
*"      RETURN STRUCTURE  BAPIRET2
*"----------------------------------------------------------------------
*   This BAPI creates a substructure of the input class given in the
*   table SUBTREELIST.
*   First an check on the consistency of the struc-
*   ture is performed. Any error found there leads to a termination
*   of the program without creating any allocation. Those errors are
*   logged in the table RETURN as to make mending possible. Then, the
*   table RETURN containes only messages of the type 'E'.
*   If in this check no error was found, the single allocations are
*   created. Anyway, errors can occur at this state. They are reported
*   in the table RETURN, yet each correct allocation is created. For
*   each allocation being created the table RETURN containes a message
*   of the type 'S'.
*   To know what has happend indeed it's necessary to have a look on
*   the table RETURN or to apply the BAPI Class.GetSubstructure and
*   to compare the the intended with the achieved result!
*"----------------------------------------------------------------------
*....consistency checks.................................................
*....create allocations.................................................
*"----------------------------------------------------------------------

  CALL FUNCTION 'BAPI_HIERA_ADDSUBSTRUCTURE'
    EXPORTING
      classnum     = classnum
      classtype    = classtype
      keydate      = keydate
      changenumber = changenumber
    TABLES
      substruclist = substruclist
      return       = return.

  IF testrun = 'X'.
    CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
  ENDIF.

ENDFUNCTION.