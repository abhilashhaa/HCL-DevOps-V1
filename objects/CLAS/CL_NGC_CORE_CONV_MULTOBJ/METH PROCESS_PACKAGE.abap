METHOD process_package.
  DATA:
    lv_packsel_whr   TYPE string,
    lv_packno        TYPE i.

  DATA:
    lt_kssk          TYPE ltt_kssk,
    lt_kssk_ins      TYPE STANDARD TABLE OF kssk,
    lt_ausp          TYPE ltt_ausp,
    lt_ausp_ins      TYPE STANDARD TABLE OF ausp,
    lt_inob_ins      TYPE STANDARD TABLE OF inob,
    lv_del_whr       TYPE string VALUE '',
    lv_del_num       TYPE i      VALUE 0,
    lv_tab           TYPE string,
    lv_cuobj_min     TYPE inob-cuobj,
    lv_cuobj_max     TYPE inob-cuobj,
    lv_inob_exists   TYPE i,
    lv_kssk_exists   TYPE i,
    lv_ausp_exists   TYPE i.

  FIELD-SYMBOLS:
    <ls_packsel>     TYPE if_shdb_pfw_package_provider=>ts_packsel.

  " now process the data in packages defined by package selection criteria
  LOOP AT it_packsel ASSIGNING <ls_packsel>.
    CLEAR: lt_kssk, lt_kssk_ins, lt_ausp, lt_ausp_ins, lt_inob_ins.

    MESSAGE i036(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    "convert the package selection criteria into a WHERE clause
    lv_packsel_whr = cl_shdb_pfw_seltab=>combine_seltabs( <ls_packsel>-selection ).

    " Read in the kssk entries which do not have inob entries
    SELECT *
      FROM (mv_kssku_name)
      CLIENT SPECIFIED " This is needed because mandt is already in the where condition
      WHERE (lv_packsel_whr)
      INTO CORRESPONDING FIELDS OF TABLE @lt_kssk.

    IF lines( lt_kssk ) = 0. " Theoretically this should never happen
      MESSAGE i033(upgba) WITH 'Empty package:' 'Skipped!' INTO cl_upgba_logger=>mv_logmsg.
      cl_upgba_logger=>log->trace_single( ).
      CONTINUE.
    ENDIF.

    " Read in the relevant ausp entries
    SELECT *
      FROM (mv_auspu_name)
      CLIENT SPECIFIED " This is needed because mandt is already in the where condition
      WHERE (lv_packsel_whr)
      INTO CORRESPONDING FIELDS OF TABLE @lt_ausp.

    me->make_new_entries(
      EXPORTING
        it_kssk     = lt_kssk
        it_ausp     = lt_ausp
      IMPORTING
        et_kssk_ins = lt_kssk_ins
        et_ausp_ins = lt_ausp_ins
        et_inob_ins = lt_inob_ins
    ).

    " Since we are replacing key fields, we have to delete the previous rows first
    " Delete all objek-klart we processed (and will insert) in KSSK and AUSP:
    lv_del_whr = ''.
    lv_del_num = 0.
    LOOP AT lt_kssk ASSIGNING FIELD-SYMBOL(<ls_kssk_>)
    GROUP BY ( key1 = <ls_kssk_>-objek  key2 = <ls_kssk_>-klart ) WITHOUT MEMBERS
    ASSIGNING FIELD-SYMBOL(<ls_kssk_groupkey>).
      " Having one DELETE statement per line would not be so performant, so we join as much as we can into one DELETE.
      IF lv_del_num GT 0.
        lv_del_whr = lv_del_whr && ` OR `.
      ENDIF.
      lv_del_whr = lv_del_whr && `(objek = '` && <ls_kssk_groupkey>-key1 && `' AND klart = '` && <ls_kssk_groupkey>-key2 && `')`.
      ADD 1 TO lv_del_num.
      IF lv_del_num GT 8140.
        " Why 8140?  - The maximum number of conditions in a WHERE clause is 16380. And we have 2 conditions per line, so...
        DELETE FROM kssk WHERE (lv_del_whr).
        DELETE FROM ausp WHERE (lv_del_whr).
        lv_del_whr = ''.
        lv_del_num = 0.
      ENDIF.
    ENDLOOP.
    IF lv_del_num GT 0.
      DELETE FROM kssk WHERE (lv_del_whr).
      DELETE FROM ausp WHERE (lv_del_whr).
      lv_del_whr = ''.
      lv_del_num = 0.
    ENDIF.

    DO.
      lv_cuobj_min = lt_inob_ins[ 1 ]-cuobj.
      lv_cuobj_max = lt_inob_ins[ lines( lt_inob_ins ) ]-cuobj.

      lv_inob_exists = 0.
      lv_kssk_exists = 0.
      lv_ausp_exists = 0.
      SELECT SINGLE 1 INTO @lv_inob_exists FROM inob WHERE cuobj >= @lv_cuobj_min AND cuobj <= @lv_cuobj_max.
      SELECT SINGLE 1 INTO @lv_kssk_exists FROM kssk WHERE objek >= @lv_cuobj_min AND objek <= @lv_cuobj_max.
      SELECT SINGLE 1 INTO @lv_ausp_exists FROM ausp WHERE objek >= @lv_cuobj_min AND objek <= @lv_cuobj_max.

      IF lv_inob_exists = 1 OR lv_kssk_exists = 1 OR lv_ausp_exists = 1.
        lv_tab = ''.
        IF lv_inob_exists = 1.
          lv_tab = 'INOB'.
        ENDIF.
        IF lv_kssk_exists = 1.
          IF lv_tab <> ''.
            lv_tab = lv_tab && `, `.
          ENDIF.
          lv_tab = lv_tab && 'KSSK'.
        ENDIF.
        IF lv_ausp_exists = 1.
          IF lv_tab <> ''.
            lv_tab = lv_tab && `, `.
          ENDIF.
          lv_tab = lv_tab && 'AUSP'.
        ENDIF.

        MESSAGE w035(upgba) WITH `There are entries in ` && lv_tab ` with CUOBJ in range of ` lv_cuobj_min && ` .. ` && lv_cuobj_max && `.` `Reassigning CUOBJs in package...` INTO cl_upgba_logger=>mv_logmsg.
        cl_upgba_logger=>log->trace_single( ).

        me->make_new_entries(
          EXPORTING
            it_kssk     = lt_kssk
            it_ausp     = lt_ausp
          IMPORTING
            et_kssk_ins = lt_kssk_ins
            et_ausp_ins = lt_ausp_ins
            et_inob_ins = lt_inob_ins
        ).
      ELSE.
        EXIT.
      ENDIF.
    ENDDO.

    TRY.
      lv_tab = 'INOB'.
      INSERT inob FROM TABLE lt_inob_ins.
      lv_tab = 'KSSK'.
      INSERT kssk FROM TABLE lt_kssk_ins.
      lv_tab = 'AUSP'.
      INSERT ausp FROM TABLE lt_ausp_ins.
    CATCH cx_root.
      CALL FUNCTION 'DB_ROLLBACK'.
      RAISE EXCEPTION TYPE cx_data_conv_error
        MESSAGE ID 'UPGBA'
        TYPE 'E'
        NUMBER '034'
        WITH 'INSERT into' lv_tab 'failed!'.
    ENDTRY.

    MESSAGE i037(upgba) WITH <ls_packsel>-packno cl_ngc_core_data_conv=>get_current_time( ) INTO cl_upgba_logger=>mv_logmsg.
    cl_upgba_logger=>log->trace_single( ).

    CALL FUNCTION 'DB_COMMIT'.
  ENDLOOP.
ENDMETHOD.