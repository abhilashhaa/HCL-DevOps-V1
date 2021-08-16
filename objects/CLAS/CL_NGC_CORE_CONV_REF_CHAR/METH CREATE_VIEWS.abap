METHOD create_views.

  " These views handle the mandt automatically (even in the ON clause of the join conditions).

  "$.Region view: refchars
  " refchars: Reference Characteristics in the system, with all alternative references (CABNZ).
  DATA(lv_refchars_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
                             `  CABN` && cl_abap_char_utilities=>newline &&
                             `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                             `  CABNZ ON cabn.atinn = cabnz.atinn` && cl_abap_char_utilities=>newline &&
                             `{` && cl_abap_char_utilities=>newline &&
                             `  cabn.atinn,` && cl_abap_char_utilities=>newline &&
                             `  cabnz.attab,` && cl_abap_char_utilities=>newline &&
                             `  cabnz.atfel,` && cl_abap_char_utilities=>newline &&
                             `  cabn.atfor,` && cl_abap_char_utilities=>newline &&
                             `  cabn.atkon,` && cl_abap_char_utilities=>newline &&
                             `  cabn.msehi,` && cl_abap_char_utilities=>newline &&
                             `  cabn.anzdz` && cl_abap_char_utilities=>newline &&
                             `} WHERE lkenz = ' ' AND atxac = 'X'` && cl_abap_char_utilities=>newline &&
                             `UNION` && cl_abap_char_utilities=>newline &&
  " Here we can not use UNION ALL, because there can be more lines as same (because adzhl),
  " even in a situation where one is in the first set, and one in the second.
                             `SELECT FROM` && cl_abap_char_utilities=>newline &&
                             `  CABN` && cl_abap_char_utilities=>newline &&
                             `{` && cl_abap_char_utilities=>newline &&
                             `  cabn.atinn,` && cl_abap_char_utilities=>newline &&
                             `  cabn.attab,` && cl_abap_char_utilities=>newline &&
                             `  cabn.atfel,` && cl_abap_char_utilities=>newline &&
                             `  cabn.atfor,` && cl_abap_char_utilities=>newline &&
                             `  cabn.atkon,` && cl_abap_char_utilities=>newline &&
                             `  cabn.msehi,` && cl_abap_char_utilities=>newline &&
                             `  cabn.anzdz` && cl_abap_char_utilities=>newline &&
                             `} WHERE lkenz = ' ' AND atxac = ' ' AND attab <> '' AND atfel <> ''` ##NO_TEXT.
  "$.Endregion view: refchars

  "$.Region view: refkssk
  " refkssk: All KSSK entries which lead to at least one Reference Characteristic in the system
  " with their Ref.Char. master data as joined.
  DATA(lv_refkssk_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  KSML ON ` && gv_refchars_name && `.atinn = ksml.imerk` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  TCLA ON ksml.klart = tcla.klart` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  NGC_CLHIER_IDX ON ksml.clint = ngc_clhier_idx.ancestor` && cl_abap_char_utilities=>newline &&
                            `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                            `  KSSK ON ngc_clhier_idx.node = kssk.clint` && cl_abap_char_utilities=>newline &&
                            `{` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.atinn,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.attab,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.atfel,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.atfor,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.atkon,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.msehi,` && cl_abap_char_utilities=>newline &&
                            `  ` && gv_refchars_name && `.anzdz,` && cl_abap_char_utilities=>newline &&
                            `  ksml.klart,` && cl_abap_char_utilities=>newline &&
                            `  tcla.multobj,` && cl_abap_char_utilities=>newline &&
                            `  tcla.obtab AS tclaobtab,` && cl_abap_char_utilities=>newline &&
                            `  kssk.objek AS ksskobjek,` && cl_abap_char_utilities=>newline &&
                            `  kssk.aennr AS ksskaennr,` && cl_abap_char_utilities=>newline &&
                            `  kssk.datuv AS ksskdatuv,` && cl_abap_char_utilities=>newline &&
                            `  kssk.lkenz AS kssklkenz,` && cl_abap_char_utilities=>newline &&
                            `  kssk.datub AS ksskdatub` && cl_abap_char_utilities=>newline &&
                            `} WHERE ksml.lkenz = ' ' AND ksml.klart <> '' AND kssk.mafid = 'O'` ##NO_TEXT.
  "$.Endregion view: refkssk

  "$.Region view: refbo
  " refbo: All Business Objects which are Reference Characteristic relevant
  " with their Ref.Char. master data as joined + INOB data resolved (where needed).
  DATA(lv_refbo_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && cl_abap_char_utilities=>newline &&
                          `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                          `  INOB ON ` && gv_refkssk_name && `.ksskobjek = inob.cuobj` && cl_abap_char_utilities=>newline &&
                          `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_nodes_name && ` ON ` && gv_refkssk_name && `.ksskobjek = ` && gv_nodes_name && `.cuobj` && cl_abap_char_utilities=>newline &&
                          `{` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atinn,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.attab,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atfel,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atfor,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atkon,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.msehi,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.anzdz,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.klart,` && cl_abap_char_utilities=>newline &&
                          `  inob.obtab AS obtab,` && cl_abap_char_utilities=>newline &&
                          `  inob.objek AS objek,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskaennr,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskdatuv,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.kssklkenz,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskdatub,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskobjek AS auspobjek` && cl_abap_char_utilities=>newline &&
                          `} WHERE ` && gv_refkssk_name && `.multobj = 'X' AND ` && gv_nodes_name && `.objek IS NULL` && cl_abap_char_utilities=>newline &&
                          `UNION ALL` && cl_abap_char_utilities=>newline &&
  " It is quicker to have the DISTINCT on both end instead of using UNION (without ALL), since the two subsets are disjunct.
                          `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && cl_abap_char_utilities=>newline &&
                          `{` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atinn,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.attab,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atfel,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atfor,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.atkon,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.msehi,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.anzdz,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.klart,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.tclaobtab AS obtab,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskobjek AS objek,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskaennr,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskdatuv,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.kssklkenz,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskdatub,` && cl_abap_char_utilities=>newline &&
                          `  ` && gv_refkssk_name && `.ksskobjek AS auspobjek` && cl_abap_char_utilities=>newline &&
                          `} WHERE ` && gv_refkssk_name && `.multobj = ' '` ##NO_TEXT.
  "$.Endregion view: refbo

  "$.Region view: refbou
  " refbou: Same as refbo, but the lines where the BO already has reference values in the AUSP -> they are filtered out
  " This ensures that when the report is aborted for some reason, next time it will not start from the beginnging,
  " but continue where it stopped. (Of course only when rework=false)
  DATA(lv_refbou_source) = `SELECT DISTINCT FROM` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && cl_abap_char_utilities=>newline &&
                           `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
                           `  AUSP ON ` && gv_refbo_name && `.auspobjek = ausp.objek` && cl_abap_char_utilities=>newline &&
                           `      AND ` && gv_refbo_name && `.atinn = ausp.atinn` && cl_abap_char_utilities=>newline &&
                           `      AND ausp.mafid = 'O'` && cl_abap_char_utilities=>newline &&
                           `      AND ` && gv_refbo_name && `.klart = ausp.klart` && cl_abap_char_utilities=>newline &&
                           `{` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.atinn,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.attab,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.atfel,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.atfor,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.atkon,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.msehi,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.anzdz,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.klart,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.obtab,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.objek,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskaennr,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskdatuv,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.kssklkenz,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskdatub,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.auspobjek` && cl_abap_char_utilities=>newline &&
                           `} WHERE ausp.objek IS NULL` ##NO_TEXT.
  "$.Endregion view: refbou

  "$.Region view: siblchrs_old
  " This is the archived version of siblchrs, which handles ALL siblings, between ALL KLARTs of the BO.
  " Unfortunatelly the JOIN conditions are too complex for the DB to handle with bigger data.
*  " siblchrs: Sibling characteristic intervals.
*  " Sibling characteristic: All characteristics of the BO which has values (in the AUSP).
*  " The goal of this view is to gain potential validity intervals from the Sibling characteristics,
*  " because these are the time intervals which may be worth to check for a possible reference value.
*  DATA(lv_siblchrs_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && cl_abap_char_utilities=>newline &&
*                           `  LEFT OUTER JOIN` && cl_abap_char_utilities=>newline &&
*                           `  INOB ON ` && gv_refbo_name && `.obtab = inob.obtab AND ` && gv_refbo_name && `.objek = inob.objek` && cl_abap_char_utilities=>newline &&
*                           `  INNER JOIN` && cl_abap_char_utilities=>newline &&
*                           `  AUSP ON ` && gv_refbo_name && `.auspobjek = ausp.objek OR inob.cuobj = ausp.objek OR ` && gv_refbo_name && `.objek = ausp.objek ` && cl_abap_char_utilities=>newline &&
*                           `{` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && `.obtab,` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && `.objek,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.objek AS auspobjek,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.atinn,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.atzhl,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.klart,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.adzhl,` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && `.ksskdatuv,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.datuv AS auspdatuv,` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && `.ksskdatub,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.datub AS auspdatub,` && cl_abap_char_utilities=>newline &&
*                           `  ` && gv_refbo_name && `.ksskaennr,` && cl_abap_char_utilities=>newline &&
*                           `  ausp.aennr AS auspaennr` && cl_abap_char_utilities=>newline &&
*                           `} WHERE ausp.mafid='O' AND ausp.datuv <> '00000000'` && cl_abap_char_utilities=>newline &&
*                           `  AND (` && gv_refbo_name && `.ksskdatuv = '00000000' OR NOT ` &&
*                                 `(` && gv_refbo_name && `.ksskdatub < ausp.datuv OR ausp.datub < ` && gv_refbo_name && `.ksskdatuv))` ##NO_TEXT.
*  " ---------------------------------------------------------------------------
*  " Why do we have this condition?:
*  " inob.cuobj = ausp.objek
*  " if we already have this condition:
*  " refbo.auspobjek = ausp.objek
*  " Answer:
*  " Imagine that we have a material (Material_1) with two assigned classes:
*  " Class_1 in Class type: 001 (clint=0000001) with assigned ref.characteristic: atinn=0000001
*  " Class_2 in Class type: 002 (clint=0000002) with assigned characteristic: atinn=0000002
*  " Class type 001 is MULTOBJ=false (which means we DO NOT have INOB entry)
*  " Class type 002 is MULTOBJ=true  (which means we have INOB entry)
*  "
*  " This way - for example - we will have this in AUSP:
*  " OBJEK        ATINN    KLART
*  " Material_1   0000001  001  ...
*  " 0000001234   0000002  002  ...
*  "
*  " And this in INOB:
*  " CUOBJ        OBJEK       KLART
*  " 0000001234   Material_1  002
*  "
*  " And we have in refbo only this:
*  " OBJEK        AUSPOBJEK    ATINN    KLART
*  " Material_1   Material_1   0000001  001  ...
*  "
*  " Now, if we check only refbo.auspobjek = ausp.objek, where refbo.objek=Material_1,
*  " it will never match for ausp.objek=0000001234 and we will miss a sibling characteristic value (atinn=0000002).
*  " By Left outer joining INOB, and then use inob.cuobj = ausp.objek as well we will find this sibling too.
*  " Of course using inob.cuobj = ausp.objek alone would miss non-INOB cases, so we need both conditions.
*  "
*  " Let's see the opposite case:
*  " Class_1 in Class type: 001 (clint=0000001) with assigned characteristic: atinn=0000001
*  " Class_2 in Class type: 002 (clint=0000002) with assigned ref.characteristic: atinn=0000002
*  "
*  " This way - for example - we will have this in AUSP:
*  " OBJEK        ATINN    KLART
*  " Material_1   0000001  001  ...
*  " 0000001234   0000002  002  ...
*  "
*  " And this in INOB:
*  " CUOBJ        OBJEK       KLART
*  " 0000001234   Material_1  002
*  "
*  " And we have in refbo only this:
*  " OBJEK        AUSPOBJEK    ATINN    KLART
*  " Material_1   0000001234   0000002  002  ...
*  "
*  " Now refbo.objek=Material_1, refbo.auspobjek = ausp.objek won't match, because 0000001234!=Material_1,
*  " inob.cuobj = ausp.objek also won't match, because 0000001234!=Material_1.
*  " In this case only refbo.objek = ausp.objek will match, and by this we will have sibling characteristic value atinn=0000001.
*  "
*  " But there is a risk with this refbo.objek = ausp.objek condition:
*  " This condition is independent from OBTAB!
*  " While a CUOBJ is associated with a certain OBTAB, a true OBJEK (where it is not a CUOBJ) can be any type BO!
*  " So in the system there can be a Material with OBJEK=TESTOBJ, and an Equipment with OBJEK=TESTOBJ, and a Document with OBJEK=TESTOBJ,
*  " and with this refbo.objek = ausp.objek condition we can mix up them!
*  " Of course we are talking about wrong sibling characteristic validities coming in the picture here,
*  " and this means the program will check for ref.values on validity dates which are not relevant,
*  " so the AUSP-output of the program will be the same anyways, but will be a little slower because of unnecessary checks
*  " and this is the worst case.
*  " ---------------------------------------------------------------------------
  "$.Endregion view: siblchrs_old

  "$.Region view: siblchrs
  DATA(lv_siblchrs_source) = `SELECT FROM` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && cl_abap_char_utilities=>newline &&
                           `  INNER JOIN` && cl_abap_char_utilities=>newline &&
                           `  AUSP ON ` && gv_refbo_name && `.auspobjek = ausp.objek ` && cl_abap_char_utilities=>newline &&
                           `{` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.obtab,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.objek,` && cl_abap_char_utilities=>newline &&
                           `  ausp.objek AS auspobjek,` && cl_abap_char_utilities=>newline &&
                           `  ausp.atinn,` && cl_abap_char_utilities=>newline &&
                           `  ausp.atzhl,` && cl_abap_char_utilities=>newline &&
                           `  ausp.klart,` && cl_abap_char_utilities=>newline &&
                           `  ausp.adzhl,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskdatuv,` && cl_abap_char_utilities=>newline &&
                           `  ausp.datuv AS auspdatuv,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskdatub,` && cl_abap_char_utilities=>newline &&
                           `  ausp.datub AS auspdatub,` && cl_abap_char_utilities=>newline &&
                           `  ` && gv_refbo_name && `.ksskaennr,` && cl_abap_char_utilities=>newline &&
                           `  ausp.aennr AS auspaennr` && cl_abap_char_utilities=>newline &&
                           `} WHERE ausp.mafid='O' AND ausp.datuv <> '00000000'` && cl_abap_char_utilities=>newline &&
                           `  AND (` && gv_refbo_name && `.ksskdatub >= ausp.datuv AND ausp.datub >= ` && gv_refbo_name && `.ksskdatuv)` ##NO_TEXT.
  "$.Endregion view: siblchrs
  TRY.
    cl_ngc_core_data_conv=>create_nodeleaf_view(
      iv_view_name   = gv_nodes_name
      iv_app_name    = mv_appl_name
    ).
    cl_ngc_core_data_conv=>create_view(
      iv_view_name   = gv_refchars_name
      iv_view_source = lv_refchars_source
      iv_app_name    = mv_appl_name
    ).
    cl_ngc_core_data_conv=>create_view(
      iv_view_name   = gv_refkssk_name
      iv_view_source = lv_refkssk_source
      iv_app_name    = mv_appl_name
    ).
    cl_ngc_core_data_conv=>create_view(
      iv_view_name   = gv_refbo_name
      iv_view_source = lv_refbo_source
      iv_app_name    = mv_appl_name
    ).
    cl_ngc_core_data_conv=>create_view(
      iv_view_name   = gv_refbou_name
      iv_view_source = lv_refbou_source
      iv_app_name    = mv_appl_name
    ).
    cl_ngc_core_data_conv=>create_view(
      iv_view_name   = gv_siblchrs_name
      iv_view_source = lv_siblchrs_source
      iv_app_name    = mv_appl_name
    ).
    rv_success = abap_true.
  CATCH cx_root INTO DATA(lx_root) ##CATCH_ALL.
    " Error when creating a view
    rv_success = abap_false.
    me->delete_views( iv_log_error = abap_false ).
    cl_upgba_logger=>log->error(
      ix_root        = lx_root
      iv_incl_srcpos = abap_true
    ).
    cl_upgba_logger=>log->close( ).
  ENDTRY.

ENDMETHOD.