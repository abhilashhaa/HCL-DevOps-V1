  METHOD if_ngc_core_clf_locking~enqueue_ecksskxe.

    CLEAR: ev_subrc.

    CALL FUNCTION 'ENQUEUE_ECKSSKXE'
      EXPORTING
        mode_ksskx     = 'E'
*       MANDT          = SY-MANDT
*       KLART          =
*       CLASS          =
        mafid          = 'O'
        objek          = iv_objek
*       X_KLART        = ' '
*       X_CLASS        = ' '
*       X_MAFID        = ' '
*       X_OBJEK        = ' '
*       _SCOPE         = '2'
*       _WAIT          = ' '
*       _COLLECT       = ' '
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.

    ev_subrc = sy-subrc.

  ENDMETHOD.