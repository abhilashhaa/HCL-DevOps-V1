  METHOD if_ngc_core_clf_locking~clen_dequeue_classification.

    CALL FUNCTION 'CLEN_DEQUEUE_CLASSIFICATION'
      EXPORTING
        iv_enqmode = iv_enqmode
        iv_klart   = iv_klart
        iv_class   = iv_class
        iv_mafid   = iv_mafid
        iv_objek   = iv_objek.

  ENDMETHOD.