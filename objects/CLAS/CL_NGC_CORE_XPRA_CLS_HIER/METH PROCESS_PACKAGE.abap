METHOD process_package.

  DATA:
    lv_packsel_whr   TYPE string,
    lt_klah          TYPE STANDARD TABLE OF klah,
    lt_kssk          TYPE STANDARD TABLE OF kssk,
    lo_cls_hier_db   TYPE REF TO lcl_ngc_xpra_cls_hier_dbaccess,
    lo_cls_hier      TYPE REF TO if_ngc_core_cls_hier_maint.

  FIELD-SYMBOLS:
    <ls_packsel>     TYPE if_shdb_pfw_package_provider=>ts_packsel.

  " Create Graph Index maintenance class.
  lo_cls_hier_db = NEW #( mv_client ).
  lo_cls_hier    = NEW cl_ngc_core_cls_hier_maint( lo_cls_hier_db ).

  " now process the data in packages defined by package selection criteria
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_klah.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).
    SELECT * FROM klah CLIENT SPECIFIED WHERE (lv_packsel_whr) INTO TABLE @lt_klah.
    LOOP AT lt_klah ASSIGNING FIELD-SYMBOL(<ls_klah>).
      IF <ls_klah>-bisdt IS INITIAL.
        <ls_klah>-bisdt = '99991231'.
      ENDIF.

      " Let's decrease the peak memory usage by iv_upd_relev (cl_ngc_core_cls_hier_maint->mt_relevant_relations
      " will be reseted at the start of update_relations() so there is no point to fill it at this point)
      lo_cls_hier->add_node(
        iv_klart     = <ls_klah>-klart
        iv_node      = <ls_klah>-clint
        iv_datuv     = <ls_klah>-vondt
        iv_datub     = <ls_klah>-bisdt
        iv_upd_relev = abap_false
      ).
    ENDLOOP.

    CLEAR: lt_klah. " Let's decrease the peak memory usage

    SELECT * FROM kssk CLIENT SPECIFIED WHERE (lv_packsel_whr) AND mafid = 'K' AND lkenz = ' ' INTO TABLE @lt_kssk.

    " Add new relations to graph index.
    lo_cls_hier->update_relations(
        it_relations = lt_kssk
        iv_action    = 'I').

    " Delete the previous contents of this Class Type(s) in NGC_CLHIER_IDX, because we want to overwrite
    DELETE FROM ngc_clhier_idx CLIENT SPECIFIED WHERE (lv_packsel_whr).

    " Now write the new contents of this Class Type(s) to NGC_CLHIER_IDX
    lo_cls_hier->update( mv_client ).

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.

ENDMETHOD.