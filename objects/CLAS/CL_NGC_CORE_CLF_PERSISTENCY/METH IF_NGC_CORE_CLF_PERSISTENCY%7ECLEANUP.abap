  METHOD if_ngc_core_clf_persistency~cleanup.

    " Clear internal buffers.
    CLEAR:
      mt_ausp_changes,
      mt_classes,
      mt_classtypes,
      mt_classtypes_redun,
      mt_inob_changes,
      mt_inob_new,
      mt_kssk_changes,
      mt_loaded_data.

    " Remove locks.
    me->unlock_all( ).

  ENDMETHOD.