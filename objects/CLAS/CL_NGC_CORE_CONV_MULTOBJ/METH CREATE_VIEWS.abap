METHOD create_views.
  DATA(lv_kssku_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                          `  (KSSK INNER JOIN TCLA ON kssk.klart = tcla.klart)` && cl_abap_char_utilities=>newline &&
                          `  LEFT OUTER JOIN INOB ON kssk.objek = inob.cuobj AND kssk.klart = inob.klart AND tcla.obtab = inob.obtab` && cl_abap_char_utilities=>newline &&
                          `{` && cl_abap_char_utilities=>newline &&
* WE NEED THE WHOLE KSSK here!
                          `  kssk.mandt,` && cl_abap_char_utilities=>newline &&
                          `  kssk.objek,` && cl_abap_char_utilities=>newline &&
                          `  kssk.mafid,` && cl_abap_char_utilities=>newline &&
                          `  kssk.klart,` && cl_abap_char_utilities=>newline &&
                          `  kssk.clint,` && cl_abap_char_utilities=>newline &&
                          `  kssk.adzhl,` && cl_abap_char_utilities=>newline &&
                          `  kssk.zaehl,` && cl_abap_char_utilities=>newline &&
                          `  kssk.statu,` && cl_abap_char_utilities=>newline &&
                          `  kssk.stdcl,` && cl_abap_char_utilities=>newline &&
                          `  kssk.rekri,` && cl_abap_char_utilities=>newline &&
                          `  kssk.aennr,` && cl_abap_char_utilities=>newline &&
                          `  kssk.datuv,` && cl_abap_char_utilities=>newline &&
                          `  kssk.lkenz,` && cl_abap_char_utilities=>newline &&
                          `  kssk.datub` && cl_abap_char_utilities=>newline &&
                          `} WHERE (kssk.mafid = 'O') and (tcla.multobj = ' ') and (inob.cuobj IS NULL)` &&
                             ` and (kssk.klart <> '230') and (kssk.klart <> '102')`.
  IF mv_class_type <> ''.
    lv_kssku_source = lv_kssku_source && ` and (kssk.klart = '` && mv_class_type && `')`.
  ENDIF.
  DATA(lv_auspu_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                          `  AUSP INNER JOIN ` && mv_kssku_name && ` ON ausp.objek = ` &&
                            mv_kssku_name && `.objek AND ausp.klart = ` && mv_kssku_name && `.klart` &&
                            cl_abap_char_utilities=>newline &&
                          `{` && cl_abap_char_utilities=>newline &&
* WE NEED THE WHOLE AUSP here!
                          `  ausp.mandt,` && cl_abap_char_utilities=>newline &&
                          `  ausp.objek,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atinn,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atzhl,` && cl_abap_char_utilities=>newline &&
                          `  ausp.mafid,` && cl_abap_char_utilities=>newline &&
                          `  ausp.klart,` && cl_abap_char_utilities=>newline &&
                          `  ausp.adzhl,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atwrt,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atflv,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atawe,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atflb,` && cl_abap_char_utilities=>newline &&
                          `  ausp.ataw1,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atcod,` && cl_abap_char_utilities=>newline &&
                          `  ausp.attlv,` && cl_abap_char_utilities=>newline &&
                          `  ausp.attlb,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atprz,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atinc,` && cl_abap_char_utilities=>newline &&
                          `  ausp.ataut,` && cl_abap_char_utilities=>newline &&
                          `  ausp.aennr,` && cl_abap_char_utilities=>newline &&
                          `  ausp.datuv,` && cl_abap_char_utilities=>newline &&
                          `  ausp.lkenz,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atimb,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atzis,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atsrt,` && cl_abap_char_utilities=>newline &&
                          `  ausp.atvglart,` && cl_abap_char_utilities=>newline &&
                          `  ausp.datub,` && cl_abap_char_utilities=>newline &&
                          `  ausp.dec_value_from,` && cl_abap_char_utilities=>newline &&
                          `  ausp.dec_value_to,` && cl_abap_char_utilities=>newline &&
                          `  ausp.curr_value_from,` && cl_abap_char_utilities=>newline &&
                          `  ausp.curr_value_to,` && cl_abap_char_utilities=>newline &&
                          `  ausp.currency,` && cl_abap_char_utilities=>newline &&
                          `  ausp.date_from,` && cl_abap_char_utilities=>newline &&
                          `  ausp.date_to,` && cl_abap_char_utilities=>newline &&
                          `  ausp.time_from,` && cl_abap_char_utilities=>newline &&
                          `  ausp.time_to` && cl_abap_char_utilities=>newline &&
                          `} WHERE (ausp.mafid = 'O')` &&
                             ` and (ausp.klart <> '230') and (ausp.klart <> '102')`.
  TRY.
    cl_ngc_core_data_conv=>create_view( iv_view_name = mv_kssku_name  iv_view_source = lv_kssku_source  iv_app_name = mv_appl_name ).
    cl_ngc_core_data_conv=>create_view( iv_view_name = mv_auspu_name  iv_view_source = lv_auspu_source  iv_app_name = mv_appl_name ).
    rv_success = abap_true.
  CATCH cx_root INTO DATA(lx_root).
    " Error when creating a view
    rv_success = abap_false.
    me->delete_views( iv_log_error = abap_false ).
    cl_upgba_logger=>log->error( ix_root = lx_root  iv_incl_srcpos = abap_true ).
  ENDTRY.
ENDMETHOD.