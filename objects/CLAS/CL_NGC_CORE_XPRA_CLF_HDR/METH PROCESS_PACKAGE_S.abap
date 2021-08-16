METHOD PROCESS_PACKAGE_S.

  DATA:
    lv_packsel_whr TYPE string,
    lt_clf_hdr     TYPE TABLE OF clf_hdr.

  FIELD-SYMBOLS:
    <ls_packsel>   TYPE if_shdb_pfw_package_provider=>ts_packsel.

  DATA(lv_packcnt) = lines( it_packsel ).
  MESSAGE i034(upgba) WITH 'Received' lv_packcnt 'packages to be processed in phase S' INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

  " We might get multiple packages into one worker process / this is auto tuned by PFW.
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_clf_hdr.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING.
    cl_upgba_logger=>log->trace_single( ).

    " Convert the package selection criteria into a WHERE clause.
    TEST-SEAM combine_seltabs_s_seam.
      lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    END-TEST-SEAM.

    TEST-SEAM select_cds_s_seam.
      SELECT *
        FROM (gc_kssks_name)                             "#EC CI_DYNTAB
        CLIENT SPECIFIED                                 "#EC CI_CLIENT
        WHERE (lv_packsel_whr)                           "#EC CI_DYNWHERE
        INTO CORRESPONDING FIELDS OF TABLE @lt_clf_hdr.
    END-TEST-SEAM.

    " Fill the new field
    LOOP AT lt_clf_hdr ASSIGNING FIELD-SYMBOL(<ls_clf_hdr>).
      <ls_clf_hdr>-objekp = <ls_clf_hdr>-objek.
    ENDLOOP.

    " Here we have new entries, so we have to fill the creator with timestamp.
    me->update_creator(
      CHANGING
        ct_clf_hdr = lt_clf_hdr
    ).

    " Insert into table
    INSERT clf_hdr CLIENT SPECIFIED FROM TABLE @lt_clf_hdr. "#EC CI_CLIENT

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

ENDMETHOD.