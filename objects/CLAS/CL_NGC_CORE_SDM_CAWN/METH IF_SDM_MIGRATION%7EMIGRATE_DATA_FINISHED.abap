  METHOD if_sdm_migration~migrate_data_finished.

    MESSAGE i099(sdmi) WITH `Migration has finished in client ` sy-mandt INTO me->mo_logger->mv_logmsg ##NO_TEXT.
    me->mo_logger->add_message( iv_probclass = if_sdm_logger=>c_probclass_high ).

  ENDMETHOD.