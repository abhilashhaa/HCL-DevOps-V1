  METHOD if_sdm_migration~migrate_data_finished.

    " Perform the final switch to the new data model, this may involve
    "  - activation of feature toggle or similar to enable new/changed application functionality
    "  - in case the production still writes data into old data model:
    "     - exclusive lock of the table defined in IF_SDM_MIGRATION~GET_TABLE_NAME
    "     - final migration of data with IF_SDM_MIGRATION~GET_STATUS_FIELD not equal to
    "       IF_SDM_MIGRATION~GET_STATUS_VALUE_DONE

    MESSAGE i100(sdmi) WITH |Migration has finished in client { sy-mandt }| INTO me->mo_logger->mv_logmsg ##NO_TEXT.
    me->mo_logger->add_message( iv_probclass = if_sdm_logger=>c_probclass_high ).

  ENDMETHOD.