  METHOD serialize.

    DATA: lv_max      TYPE i,
          li_progress TYPE REF TO zif_abapgit_progress.

    FIELD-SYMBOLS: <ls_tadir> LIKE LINE OF it_tadir.


    CLEAR mt_files.

    lv_max = determine_max_threads( iv_force_sequential ).
    mv_free = lv_max.
    mi_log = ii_log.

    li_progress = zcl_abapgit_progress=>get_instance( lines( it_tadir ) ).

    LOOP AT it_tadir ASSIGNING <ls_tadir>.

      li_progress->show(
        iv_current = sy-tabix
        iv_text    = |Serialize { <ls_tadir>-obj_name }, { lv_max } threads| ).

      IF lv_max = 1.
        run_sequential(
          is_tadir    = <ls_tadir>
          iv_language = iv_language ).
      ELSE.
        run_parallel(
          is_tadir    = <ls_tadir>
          iv_task     = |{ sy-tabix }|
          iv_language = iv_language ).
        WAIT UNTIL mv_free > 0 UP TO 120 SECONDS.
      ENDIF.
    ENDLOOP.

    WAIT UNTIL mv_free = lv_max UP TO 120 SECONDS.
    rt_files = mt_files.

  ENDMETHOD.