  METHOD if_ngc_core_clf_locking~dequeue_ecksskxe.

    CALL FUNCTION 'DEQUEUE_ECKSSKXE'
      EXPORTING
        mode_ksskx = 'E'
*       MANDT      = SY-MANDT
*       KLART      =
*       CLASS      =
*       MAFID      =
        objek      = iv_objek
*       X_KLART    = ' '
*       X_CLASS    = ' '
*       X_MAFID    = ' '
*       X_OBJEK    = ' '
*       _SCOPE     = '3'
*       _SYNCHRON  = ' '
*       _COLLECT   = ' '
      .

  ENDMETHOD.