  METHOD unlock_all.

    " this call will unlock all the locked objects internally, so we don't need to check
    " our buffer mt_enqueue_log
    mo_locking->clen_dequeue_all( ).
    CLEAR: mt_enqueue_log.

    " unlock objects locked by ENQUEUE_ECKSSKXE
    LOOP AT mt_enqueue_ecksskxe_log ASSIGNING FIELD-SYMBOL(<lv_enqueue_ecksskxe_log>).
      mo_locking->dequeue_ecksskxe( <lv_enqueue_ecksskxe_log> ).
    ENDLOOP.
    CLEAR: mt_enqueue_ecksskxe_log.

  ENDMETHOD.