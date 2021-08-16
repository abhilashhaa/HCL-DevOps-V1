METHOD PROCESS_PACKAGE_M.

  DATA:
    lv_packsel_whr TYPE string,
    lt_clf_hdr     TYPE TABLE OF clf_hdr.

  FIELD-SYMBOLS:
    <ls_packsel>      TYPE if_shdb_pfw_package_provider=>ts_packsel,
    <ls_clf_hdr_prev> TYPE clf_hdr.

  DATA(lv_packcnt) = lines( it_packsel ).
  MESSAGE i034(upgba) WITH 'Received' lv_packcnt 'packages to be processed in phase M' INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

  " We might get multiple packages into one worker process / this is auto tuned by PFW.
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_clf_hdr.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING.
    cl_upgba_logger=>log->trace_single( ).

    " Convert the package selection criteria into a WHERE clause.
    TEST-SEAM combine_seltabs_m_seam.
      lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    END-TEST-SEAM.

    TEST-SEAM select_cds_m_seam.
      SELECT *
        FROM (gc_ksskm_name)                             "#EC CI_DYNTAB
        CLIENT SPECIFIED                                 "#EC CI_CLIENT
        WHERE (lv_packsel_whr)                           "#EC CI_DYNWHERE
        INTO CORRESPONDING FIELDS OF TABLE @lt_clf_hdr.
    END-TEST-SEAM.

    " There might be different CUOBJs for the same obtab-objek-mafid-klart, we have to choose one
    " Normally this should never happen, because this is an inconsistency
    IF lines( lt_clf_hdr ) > 1.
      SORT lt_clf_hdr BY obtab objek mafid klart cuobj.
      LOOP AT lt_clf_hdr ASSIGNING FIELD-SYMBOL(<ls_clf_hdr>).
        IF <ls_clf_hdr_prev> IS ASSIGNED.
          IF <ls_clf_hdr_prev>-obtab = <ls_clf_hdr>-obtab
          AND <ls_clf_hdr_prev>-objek = <ls_clf_hdr>-objek
          AND <ls_clf_hdr_prev>-mafid = <ls_clf_hdr>-mafid
          AND <ls_clf_hdr_prev>-klart = <ls_clf_hdr>-klart.
            MESSAGE w035(upgba) WITH `DB inconsistency: Multiple CUOBJs for same`
                                     `klart-obtab-objek in table INOB!`
                                     `  klart = ` && <ls_clf_hdr_prev>-klart &&
                                     `  obtab = ` && <ls_clf_hdr_prev>-obtab
                                     `  objek = ` && <ls_clf_hdr_prev>-objek
                                     INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
            cl_upgba_logger=>log->trace_single( ).
            MESSAGE w034(upgba) WITH `  cuobj-1 = ` && <ls_clf_hdr_prev>-cuobj
                                     `  cuobj-2 = ` && <ls_clf_hdr>-cuobj
                                     `  Choosing the first one and skipping the second.` INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
            cl_upgba_logger=>log->trace_single( ).
            me->increase_event( EXPORTING iv_event  = gc_ev_multicuobj CHANGING ct_events = rt_events ).
            " We do not want duplicates with different CUOBJs, so delete the second
            DELETE lt_clf_hdr.
            " Go to the next line without updating <ls_clf_hdr_prev>:
            CONTINUE.
          ENDIF.
        ENDIF.
        ASSIGN <ls_clf_hdr> TO <ls_clf_hdr_prev>.
      ENDLOOP.
      UNASSIGN <ls_clf_hdr_prev>.
    ENDIF.

    " Fill the new field
    LOOP AT lt_clf_hdr ASSIGNING <ls_clf_hdr>.
      <ls_clf_hdr>-objekp = <ls_clf_hdr>-cuobj.
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