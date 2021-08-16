METHOD process_package.

  DATA:
    lv_packsel_whr TYPE string,
    lt_refbou      TYPE ltt_refbou,
    lt_refbou_i    TYPE ltt_refbou,
    lt_siblchrs    TYPE ltt_auspvalidity,
    lt_refvals     TYPE ltt_refvalidity,
    lt_ausp_modify TYPE ltt_ausp,
    ls_refvals     TYPE lts_refvalidity.

  FIELD-SYMBOLS:
    <ls_packsel>   TYPE if_shdb_pfw_package_provider=>ts_packsel,
    <ls_refvals>   TYPE lts_refvalidity.

  cl_upgba_logger=>create( iv_logid     = mv_appl_name
                           iv_logtype   = cl_upgba_logger=>gc_logtype_db
                           iv_processid = cl_shdb_pfw=>ms_process_data-process_counter
                           iv_skip_init = abap_true ).

  DATA(lv_packcnt) = lines( it_packsel ).
  MESSAGE i034(upgba) WITH 'Received' lv_packcnt 'packages to be processed' INTO cl_upgba_logger=>mv_logmsg ##NO_TEXT.
  cl_upgba_logger=>log->trace_single( ).

  " We might get multiple packages into one worker process / this is auto tuned by PFW.
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_ausp_modify, lt_refbou.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING.
    cl_upgba_logger=>log->trace_single( ).

    " Convert the package selection criteria into a WHERE clause.
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).

    " Read the Reference Characteristic relevant - UNPROCESSED / ALL - BOs.
    SELECT
      atinn, attab, atfel, atfor, atkon, msehi, anzdz, klart,
      obtab, objek, ksskaennr, ksskdatuv, kssklkenz, ksskdatub, auspobjek
      FROM (mv_refbo_name)                             "#EC CI_DYNTAB
      CLIENT SPECIFIED                                 "#EC CI_CLIENT
      WHERE (lv_packsel_whr)                         "#EC CI_DYNWHERE
      GROUP BY obtab, objek, auspobjek, atinn, attab, atfel, klart, ksskdatuv, kssklkenz, ksskdatub, atfor, atkon, msehi, anzdz, ksskaennr
      INTO CORRESPONDING FIELDS OF TABLE @lt_refbou.
    " With the DISTINCT (which is inside the view now) we filtered out the cases where a Ref.Characteristic
    " appears more because of multiple inheritance (different nodes),
    " and we have dropped the node (class) itself, we don't need it.

    " Read the validities of the relevant Sibling Characteristic values.
    IF mo_refval_reader->get_change_of_date_supported( ) = abap_true.
      " This SELECT might cause short dump if the view is too complex and there is too much data in the database.
      " This means a DBSQL_SQL_INTERNAL_DB_ERROR with code 2048 (STATEMENT_MEMORY_LIMIT),
      " or a TIMEOUT error (too slow).
      " Currently it seems none of them can be caught even with cx_root.
      " Because of these, we have archived the complex view (see create_views)
      " and we use a simplified version, which should not cause this dump, of course with some compromise.
      " With the complex version or even with the simplified version, if these short dumps come at this statement,
      " ideally they should be caught, and the conversion should continue instead of a dump
      " even with an empty result of this SELECT statement.
      " Reason:
      " The sibling characteristic validities are used only for a "hint" during the conversion.
      " The KSSK validities are used anyways, and they are the major points.
      SELECT DISTINCT " Here we do not use all columns from the view, so the DISTINCT must be here instead of inside the view.
        obtab, objek, auspobjek, atinn, ksskdatuv, auspdatuv, ksskdatub, auspdatub, ksskaennr, auspaennr
        FROM (gv_siblchrs_name)                            "#EC CI_DYNTAB
        CLIENT SPECIFIED                                   "#EC CI_CLIENT
        WHERE (lv_packsel_whr)                           "#EC CI_DYNWHERE
        INTO CORRESPONDING FIELDS OF TABLE @lt_siblchrs.
    ENDIF.

    " Read all objects (MARA/MCHA/etc) in the case of mo_refval_reader is not the general reader.
    mo_refval_reader->read_objects( it_refbou = lt_refbou ).

    " Iterate through all different BOs:
    LOOP AT lt_refbou ASSIGNING FIELD-SYMBOL(<ls_refbou>)
    GROUP BY ( obtab = <ls_refbou>-obtab  objek = <ls_refbou>-objek )
    ASSIGNING FIELD-SYMBOL(<ls_refbou_groupkey>).
      CLEAR: lt_refbou_i, lt_refvals.

      " Collect all lines with current BO:
      LOOP AT GROUP <ls_refbou_groupkey> ASSIGNING FIELD-SYMBOL(<ls_refbou_groupmember>).
        INSERT <ls_refbou_groupmember> INTO TABLE lt_refbou_i.
        " In the meantime, collect the kssk-validities as well (but only when it is not an unassignment):
        IF <ls_refbou_groupmember>-kssklkenz NE 'X'.
          " And we have to avoid duplicates at this point because of the AENNR:
          READ TABLE lt_refvals ASSIGNING <ls_refvals> WITH KEY datuv = <ls_refbou_groupmember>-ksskdatuv.
          IF sy-subrc NE 0.
            CLEAR ls_refvals.
            ls_refvals-datuv = <ls_refbou_groupmember>-ksskdatuv.
            ls_refvals-aennr = <ls_refbou_groupmember>-ksskaennr.
            INSERT ls_refvals INTO TABLE lt_refvals.
          ELSEIF <ls_refbou_groupmember>-ksskaennr <> '' AND <ls_refvals>-aennr = ''.
            " Maybe we can gain an aennr here (this case is probably a DB inconsistency).
            <ls_refvals>-aennr = <ls_refbou_groupmember>-ksskaennr.
          ENDIF.
          " We might include the DATUBs as well, but that would mean invalid time-intervals (more unnecessary OBJECT_CHECK calls).
        ENDIF.
      ENDLOOP.

      " Collect the relevant sibling characteristic value validities for this BO.
      me->collect_validities(
        EXPORTING
          it_siblchrs = lt_siblchrs
          iv_obtab    = <ls_refbou_groupkey>-obtab
          iv_objek    = <ls_refbou_groupkey>-objek
        CHANGING
          ct_refvals  = lt_refvals
      ).

      me->process_bo(
        EXPORTING
          it_attabs      = lt_refbou_i
        CHANGING
          ct_refvals     = lt_refvals
          ct_ausp_modify = lt_ausp_modify
          ct_events      = rt_events
      ).
    ENDLOOP.

    " We might have multiple rows for the same value as splitted to more validity intervals,
    " so combine them if we can:
    me->merge_time_intervals( CHANGING ct_ausp = lt_ausp_modify ).

    " We must ensure that no remnants of previous AUSP rows will be left:
    IF mv_rework EQ abap_true.
      " Delete all objek-atinn-klart we just processed (and will insert) in AUSP.
      me->cleanup_ausp( it_ausp = lt_ausp_modify ).
    ENDIF.

    MODIFY ausp FROM TABLE @lt_ausp_modify.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg ##MG_MISSING.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

  " Grant the refval reader a chance to generate final events
  mo_refval_reader->add_package_end_msgs(
    CHANGING
      ct_events = rt_events
  ).

  cl_upgba_logger=>log->close( ).

ENDMETHOD.