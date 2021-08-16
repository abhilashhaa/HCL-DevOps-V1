  METHOD if_ngc_core_clf_locking~clen_enqueue_classification.

    CLEAR: ev_subrc.


    CALL FUNCTION 'CLEN_ENQUEUE_CLASSIFICATION'
      EXPORTING
        iv_enqmode     = iv_enqmode
        iv_klart       = iv_klart
        iv_class       = iv_class
        iv_mafid       = iv_mafid
        iv_objek       = iv_objek
      EXCEPTIONS
        foreign_lock   = 1
        system_failure = 2
        OTHERS         = 3.

    ev_subrc = sy-subrc.

  ENDMETHOD.