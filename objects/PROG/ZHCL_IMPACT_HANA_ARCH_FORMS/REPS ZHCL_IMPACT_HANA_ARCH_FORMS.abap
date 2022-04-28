*----------------------------------------------------------------------*
***INCLUDE ZHCL_IMPACT_HANA_ARCH_FORMS.
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Form  F_SCAN_CONTENTS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GI_CONTENT  text
*      -->P_GI_KEYWORDS  text
*      <--P_GI_TOKEN  text
*      <--P_GI_STATEMENTS  text
*      <--P_GI_LEVEL  text
*      <--P_GV_OVERFLOW  text
*----------------------------------------------------------------------*
FORM f_scan_contents  USING    pi_content TYPE tty_content
                               pi_keywords TYPE tty_keywords
                               pv_start TYPE int4
                               pv_end   TYPE int4
                      CHANGING pi_token  TYPE stokex_tab
                               pi_statements TYPE sstmnt_tab
                               pi_level TYPE slevel_tab
                               pv_overflow.

  IF pv_start IS NOT INITIAL AND pv_end IS NOT INITIAL.
    SCAN ABAP-SOURCE pi_content
      FROM pv_start TO pv_end
      KEYWORDS FROM pi_keywords
      TOKENS INTO pi_token
      STATEMENTS INTO pi_statements
*      LEVELS INTO pi_level
      OVERFLOW INTO pv_overflow
      WITH ANALYSIS.
*      WITH INCLUDES.

  ELSE.
    SCAN ABAP-SOURCE pi_content
      KEYWORDS FROM pi_keywords
      TOKENS INTO pi_token
      STATEMENTS INTO pi_statements
      LEVELS INTO pi_level
      OVERFLOW INTO pv_overflow
      WITH ANALYSIS
      WITH INCLUDES.
  ENDIF.

ENDFORM.                    " F_SCAN_CONTENTS
*&---------------------------------------------------------------------*
*&      Form  F_FILL_ALV_PROG
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_GV_PROG  text
*      <--P_GI_FINAL_ALV  text
*----------------------------------------------------------------------*
FORM f_fill_alv_prog  USING    pv_prog TYPE programm
                               pi_keywords TYPE tty_keywords
                      CHANGING pi_final_alv TYPE tty_final_alv.

  DATA: li_content         TYPE STANDARD TABLE OF t_content,
        li_level           TYPE STANDARD TABLE OF slevel,
        li_lvl_sel         TYPE STANDARD TABLE OF slevel,
        li_lvl_srt         TYPE STANDARD TABLE OF slevel,
        li_keywords        TYPE STANDARD TABLE OF t_keywords,
        li_statements      TYPE STANDARD TABLE OF sstmnt,
        li_fields          TYPE STANDARD TABLE OF t_fields,
        ls_fields          TYPE                   t_fields,
        li_stmt_sel        TYPE STANDARD TABLE OF sstmnt,
        ls_stmt_sel        TYPE                   sstmnt,
        li_stmt_srt        TYPE STANDARD TABLE OF sstmnt,
        ls_statements      TYPE                   sstmnt,
        lv_flag            TYPE                   char1,
        lv_ordby_flg       TYPE                   char1,
        lv_srt_flg         TYPE                   char1,
        lv_table           TYPE                   token_str,
        lv_overflow(10000),
        ls_config          TYPE                   t_config,
        ls_final           TYPE                   t_final_alv,
        ls_token           TYPE                   stokex,
        lv_tabix           TYPE                   sytabix,
        ls_token_data      TYPE                   stokex,
        ls_tok_data        TYPE                   stokex,
        ls_level           TYPE                   slevel,
        ls_keywords        TYPE                   t_keywords,
        lv_tok_idx         TYPE                   sytabix,
        lv_tok_idx1        TYPE                   sytabix,
        li_tkn_sel         TYPE STANDARD TABLE OF stokex,
        li_tkn_srt         TYPE STANDARD TABLE OF stokex,
        li_token           TYPE STANDARD TABLE OF stokex.

  READ REPORT pv_prog INTO li_content.

  ls_keywords-key = 'SELECT'.
  APPEND ls_keywords TO li_keywords.

  PERFORM f_scan_contents USING    li_content
                                   li_keywords
                                   0 0
                          CHANGING li_tkn_sel
                                   li_stmt_sel
                                   li_lvl_sel
                                   lv_overflow.

  CLEAR li_keywords.
  ls_keywords-key = 'SORT'.
  APPEND ls_keywords TO li_keywords.

  PERFORM f_scan_contents USING    li_content
                                   li_keywords
                                   0 0
                          CHANGING li_tkn_srt
                                   li_stmt_srt
                                   li_lvl_srt
                                   lv_overflow.

  PERFORM f_scan_contents USING    li_content
                                   pi_keywords
                                   0 0
                          CHANGING li_token
                                   li_statements
                                   li_level
                                   lv_overflow.

  LOOP AT li_statements INTO ls_statements.
    READ TABLE li_token INTO ls_token INDEX ls_statements-from.
    IF sy-subrc = 0.
      READ TABLE gi_config INTO ls_config WITH KEY pattern_desc = ls_token-str.
      IF sy-subrc = 0.
        ls_final-objtyp = 'PROG'.
        ls_final-errcod = ls_config-error_id.
        ls_final-errdsc = ls_config-error_desc.
        ls_final-recsol = ls_config-rec_sol.
        CASE ls_config-pattern_id.
          WHEN c_1.
            CLEAR li_fields.
            READ TABLE li_token INTO ls_token_data INDEX ls_statements-to.
            IF sy-subrc = 0 AND ls_token_data-type = 'I' AND
               ls_token_data-str = 'SEARCH'.
              lv_tok_idx = ls_statements-from + 2.
              READ TABLE li_token INTO ls_token_data INDEX lv_tok_idx.
              IF sy-subrc = 0.
                lv_table = ls_token_data-str.
                CLEAR lv_flag.
                LOOP AT li_token INTO ls_token_data FROM lv_tok_idx TO ls_statements-to.
                  IF lv_flag = 'X' AND lv_tok_idx1 <> ( ls_statements-to - 1 ).
                    READ TABLE li_token INTO ls_tok_data INDEX lv_tok_idx1.
                    IF sy-subrc = 0.
                      ls_fields-name = ls_tok_data-str.
                      APPEND ls_fields TO li_fields.
                    ENDIF.
                    CLEAR lv_flag.
                  ENDIF.
                  IF ls_token_data-str = '='.
                    lv_flag = 'X'.
                    lv_tok_idx1 = sy-tabix - 1.
                  ENDIF.
                ENDLOOP.
              ENDIF.

              CLEAR lv_ordby_flg.
              IF lv_table IS NOT INITIAL AND li_fields IS NOT INITIAL.
                READ TABLE li_tkn_sel TRANSPORTING NO FIELDS WITH KEY str = lv_table.
                IF sy-subrc = 0.
                  LOOP AT li_stmt_sel INTO ls_stmt_sel WHERE from LT sy-tabix AND to GT sy-tabix.
                    EXIT.
                  ENDLOOP.
                  LOOP AT li_tkn_sel INTO ls_token_data FROM ls_stmt_sel-from TO ls_stmt_sel-to.
                    IF ls_token_data-str = 'ORDER'.
                      lv_ordby_flg = 'X'.
                      EXIT.
                    ENDIF.
                  ENDLOOP.
                ENDIF.
              ENDIF.

              CLEAR: lv_srt_flg, ls_token_data.
              IF lv_ordby_flg IS INITIAL.
                LOOP AT li_tkn_srt INTO ls_token_data WHERE str = lv_table.
                  LOOP AT li_stmt_srt INTO ls_stmt_sel WHERE from LT sy-tabix AND to GT sy-tabix.
                    EXIT.
                  ENDLOOP.
                  CLEAR lv_tabix.
                  LOOP AT li_fields INTO ls_fields.
                    LOOP AT li_tkn_srt INTO ls_token_data FROM ls_stmt_sel-from TO ls_stmt_sel-to
                                                          WHERE str = ls_fields-name.
                      IF lv_tabix IS NOT INITIAL.
                        IF sy-tabix = ( lv_tabix + 1 ).
                          lv_tabix = sy-tabix.
                        ELSE.
                          lv_srt_flg = 'X'.
                        ENDIF.
                      ENDIF.
                      IF lv_tabix IS INITIAL.
                        lv_tabix = sy-tabix.
                      ENDIF.
                      EXIT.
                    ENDLOOP.
                    IF sy-subrc <> 0.
                      lv_srt_flg = 'X'.
                    ENDIF.
                  ENDLOOP.
                  IF lv_srt_flg IS INITIAL.
                    EXIT.
                  ENDIF.
                ENDLOOP.
                IF ls_token_data IS INITIAL.
                  lv_srt_flg = 'X'.
                ENDIF.
              ENDIF.

              IF lv_srt_flg IS NOT INITIAL.
                IF ls_statements-level = 1.
                  ls_final-objnam = pv_prog.
                ELSE.
                  READ TABLE li_level INTO ls_level INDEX ls_statements-level.
                  IF sy-subrc = 0.
                    ls_final-objnam = ls_level-name.
                  ENDIF.
                ENDIF.
                PERFORM f_get_objname CHANGING ls_final-objtyp
                                               ls_final-objnam
                                               ls_final-cpdname.
                ls_final-line = ls_token-row.
                APPEND ls_final TO pi_final_alv.
              ENDIF.
            ENDIF.
          WHEN c_2.
            lv_tok_idx = ls_statements-from + 2.
            READ TABLE li_token INTO ls_token_data INDEX lv_tok_idx.
            IF sy-subrc = 0 AND
             ( ls_token_data-str CS 'DB_EXISTS_INDEX' OR
               ls_token_data-str CS 'DD_INDEX_NAME' ).
              IF ls_statements-level = 1.
                ls_final-objnam = pv_prog.
              ELSE.
                READ TABLE li_level INTO ls_level INDEX ls_statements-level.
                IF sy-subrc = 0.
                  ls_final-objnam = ls_level-name.
                ENDIF.
              ENDIF.
              PERFORM f_get_objname CHANGING ls_final-objtyp
                                             ls_final-objnam
                                             ls_final-cpdname.
              ls_final-line = ls_token-row.
              APPEND ls_final TO pi_final_alv.
            ELSE.
              CLEAR ls_final.
            ENDIF.
        ENDCASE.
      ENDIF.
    ENDIF.
  ENDLOOP.

ENDFORM.                    " F_FILL_ALV_PROG
*&---------------------------------------------------------------------*
*&      Form  F_GET_CONFIG_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_get_config_data .

  DATA: ls_config   TYPE t_config,
        ls_keywords TYPE t_keywords.

  CLEAR:    gi_final,
            gi_class,
            gi_cls_incl,
            gi_cls_incl_tmp,
            gi_trdir,
            gi_tfdir,
            gi_tfdir_tmp,
            gt_alv,
            gi_keywords.

  SELECT a~pattern_id b~pattern_desc
         a~error_id c~error_desc c~rec_sol
    INTO TABLE gi_config
    FROM ( ( zhcl_hana_config AS a
    INNER JOIN zhcl_hana_patrn AS b
    ON b~pattern_id = a~pattern_id )
     INNER JOIN zhcl_hana_error AS c
    ON c~error_id = a~error_id )
    WHERE a~program_name = 'ZHCL_IMPACT_HANA_ARCH'.

  IF sy-subrc = 0.
    SORT gi_config BY pattern_id.
    LOOP AT gi_config INTO ls_config.
      ls_keywords-key = ls_config-pattern_desc.
      APPEND ls_keywords TO gi_keywords.
    ENDLOOP.
  ENDIF.

ENDFORM.                    " F_GET_CONFIG_DATA
*&---------------------------------------------------------------------*
*&      Form  F_DISPLAY_ALV
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM f_display_alv .
*  DATA: lo_functions      TYPE REF TO cl_salv_functions_list,
*        lc_msg            TYPE REF TO cx_salv_msg   ##NEEDED,
*        lo_columns        TYPE REF TO cl_salv_columns_table,
*        lo_column         TYPE REF TO cl_salv_column,
*        lr_events         TYPE REF TO cl_salv_events_table,
*        lr_columns        TYPE REF TO cl_salv_columns_table, "columns instance
*        lr_col            TYPE REF TO cl_salv_column_table,
*        lo_salv_not_found TYPE REF TO cx_salv_not_found,
*        lo_msg            TYPE        string.
*
*  TRY.
*      CALL METHOD cl_salv_table=>factory
*        IMPORTING
*          r_salv_table = gt_alv
*        CHANGING
*          t_table      = gi_final.
*    CATCH cx_salv_msg INTO lc_msg ##NO_HANDLER.
*  ENDTRY.
*
*
*
*  CALL METHOD gt_alv->get_columns  "get all columns
*    RECEIVING
*      value = lr_columns.
*
*  TRY.
*      lr_col ?= lr_columns->get_column( 'LINE' ). "get MATNR columns to insert hotspot
*    CATCH cx_salv_not_found.
*  ENDTRY.
*
*  TRY.
*      CALL METHOD lr_col->set_cell_type "set cell type hotspot
*        EXPORTING
*          value = if_salv_c_cell_type=>hotspot.
*      .
*    CATCH cx_salv_data_error .
*  ENDTRY.
*
*  TRY.
*      lo_columns = gt_alv->get_columns( ).
** To change the name of the column in ALV.
*      lo_column = lo_columns->get_column( 'OBJTYP' ).
*      lo_column->set_long_text( 'Object type' ).
*      lo_column->set_medium_text( 'Object type' ).
*      lo_column->set_short_text( 'Obj type' ).
*      lo_columns->set_optimize( 'X' ).
*
*      lo_column = lo_columns->get_column( 'OBJNAM' ).
*      lo_column->set_long_text( 'Object name' ).
*      lo_column->set_medium_text( 'Object name' ).
*      lo_column->set_short_text( 'Obj name' ).
*
*      lo_column = lo_columns->get_column( 'CPDNAME' ).
*      lo_column->set_long_text( 'Method Name' ).
*      lo_column->set_medium_text( 'Method name' ).
*      lo_column->set_short_text( 'Meth Nam' ).
*      IF rb_clas IS INITIAL.
*        lo_column->set_visible( ' ' ).
*      ENDIF.
*
*      lo_column = lo_columns->get_column( 'LINE' ).
*      lo_column->set_long_text( 'Line number' ).
*      lo_column->set_medium_text( 'Line number' ).
*      lo_column->set_short_text( 'Line no' ).
*
*      lo_column = lo_columns->get_column( 'ERRCOD' ).
*      lo_column->set_long_text( 'Error code' ).
*      lo_column->set_medium_text( 'Error code' ).
*      lo_column->set_short_text( 'Err code' ).
*
*      lo_column = lo_columns->get_column( 'ERRDSC' ).
*      lo_column->set_long_text( 'Error description' ).
*      lo_column->set_medium_text( 'Error description' ).
*      lo_column->set_short_text( 'Err desc' ).
*
*      lo_column = lo_columns->get_column( 'RECSOL' ).
*      lo_column->set_long_text( 'Recommended Solution' ).
*      lo_column->set_medium_text( 'Recommended Solution' ).
*      lo_column->set_short_text( 'Rec Sol' ).
*
**- Catch the Exceptions
*    CATCH cx_salv_not_found INTO lo_salv_not_found.
*      lo_msg = lo_salv_not_found->get_text( ).
*      MESSAGE lo_msg TYPE 'E'.
*  ENDTRY.
*
** PF Status
*  lo_functions = gt_alv->get_functions( ).
*  lo_functions->set_all( abap_true ).
*
*  lr_events = gt_alv->get_event( ).
*  CREATE OBJECT event_handler.
*  SET HANDLER event_handler->on_link_click FOR lr_events.
*
** Displaying the ALV
*  gt_alv->display( ).

  DATA : v_repid TYPE sy-repid,
         w_print TYPE slis_print_alv,
         v_subrc TYPE sy-subrc.
  PERFORM build_fieldcat_data.


  v_repid = sy-repid.
  wa_layout-zebra = 'X'.
  wa_layout-colwidth_optimize = 'X'.
  wa_layout-box_fieldname     = 'FLAG'.
  w_print-no_print_listinfos = 'X'.

  IF gi_final IS NOT INITIAL.
*** Display of output data ***
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program       = v_repid
        i_callback_pf_status_set = 'SET_PF_STATUS'
        i_callback_user_command  = 'HYPERLINK_FIELD'
        is_layout                = wa_layout
        it_fieldcat              = it_fieldcat
        is_print                 = w_print
      TABLES
        t_outtab                 = gi_final
      EXCEPTIONS
        ##fm_subrc_ok
        program_error            = 1
        OTHERS                   = 2.


  ENDIF.
ENDFORM.                    " F_DISPLAY_ALV
*&---------------------------------------------------------------------*
*&      Form  F_GET_OBJNAME
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      <--P_LS_FINAL_OBJNAM  text
*----------------------------------------------------------------------*
FORM f_get_objname  CHANGING pv_objtyp
                             pv_objnam
                             pv_cpdname.

  CASE 'X'.
    WHEN rb_fugr OR rb_func.
      IF rb_fugr IS NOT INITIAL.
        pv_objtyp = 'FUGR'.
      ELSE.
        pv_objtyp = 'FUNC'.
      ENDIF.
      READ TABLE gi_tfdir ASSIGNING <fs_tfdir> WITH KEY inclname = pv_objnam
                                      BINARY SEARCH.
      IF sy-subrc = 0.
        pv_objnam = <fs_tfdir>-funcname.
      ENDIF.
    WHEN rb_clas.
      pv_objtyp = 'CLAS'.
      READ TABLE gi_cls_incl INTO gs_cls_incl WITH KEY incname = pv_objnam
                              BINARY SEARCH.
      IF sy-subrc = 0.
        pv_objnam = gs_cls_incl-cpdkey-clsname.
        pv_cpdname = gs_cls_incl-cpdkey-cpdname.
      ENDIF.
  ENDCASE.

ENDFORM.                    " F_GET_OBJNAME
*&---------------------------------------------------------------------*
*&      Form  F_GET_OBJNAM_REVERSE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*      -->P_LS_FINAL_OBJNAM  text
*----------------------------------------------------------------------*
FORM f_get_objnam_reverse  CHANGING    pv_objnam
                                       pv_cpdname.
  CASE 'X'.
    WHEN rb_fugr OR rb_func.
      READ TABLE gi_tfdir_tmp ASSIGNING <fs_tfdir> WITH KEY funcname = pv_objnam
                                      BINARY SEARCH.
      IF sy-subrc = 0.
        pv_objnam = <fs_tfdir>-inclname.
      ENDIF.
    WHEN rb_clas.
      READ TABLE gi_cls_incl_tmp INTO gs_cls_incl WITH KEY cpdkey-clsname = pv_objnam
                                                           cpdkey-cpdname = pv_cpdname
                                                           BINARY SEARCH.
      IF sy-subrc = 0.
        pv_objnam = gs_cls_incl-incname.
      ENDIF.
  ENDCASE.

ENDFORM.                    " F_GET_OBJNAM_REVERSE
*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCAT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM build_fieldcat_data .
  wa_fieldcat-fieldname = 'OBJTYP'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Object Type'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'OBJNAM'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Object Name'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'CPDNAME'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Method name'(010).
  IF rb_clas IS INITIAL.
    wa_fieldcat-no_out = 'X'.
  ENDIF.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'LINE'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-hotspot   = 'X'.
  wa_fieldcat-seltext_m = 'Line Number'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'ERRCOD'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Error Code'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'ERRDSC'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Error Description'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-fieldname = 'RECSOL'.
  wa_fieldcat-tabname   = 'GI_FINAL'.
  wa_fieldcat-seltext_m = 'Recommended Solution'.
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.
ENDFORM.                    " BUILD_FIELDCAT_DATA

FORM set_pf_status ##called
                   USING rt_extab TYPE slis_t_extab ##needed.

  SET PF-STATUS 'ZAUTO'.

ENDFORM.                    " SET_PF_STATUS

FORM hyperlink_field USING r_ucomm     LIKE sy-ucomm ##called ##needed
                        rs_selfield TYPE slis_selfield ##needed.

  DATA: lt_final TYPE STANDARD TABLE OF zhana_arch_final,
        wa_final TYPE                   zhana_arch_final.

  IF r_ucomm = '&IC1'.

    DATA: ls_final TYPE t_final_alv.

    READ TABLE gi_final INTO ls_final INDEX rs_selfield-tabindex.
    IF sy-subrc = 0.
      PERFORM f_get_objnam_reverse CHANGING ls_final-objnam
                                            ls_final-cpdname.

      CASE rs_selfield-fieldname.
        WHEN 'LINE'.
          CALL FUNCTION 'EDITOR_PROGRAM'
            EXPORTING
              appid   = 'PG'
              display = 'X'
              program = ls_final-objnam
              line    = ls_final-line
              topline = ls_final-line.

      ENDCASE.
    ENDIF.
  ELSEIF r_ucomm = 'AUTO'.

    SORT gi_final BY objtyp objnam ASCENDING
                         line DESCENDING.

    LOOP AT gi_final INTO gs_final WHERE flag = 'X'.
      PERFORM f_get_objnam_reverse CHANGING gs_final-objnam
                                            gs_final-cpdname.

      PERFORM  auto_correction.

    ENDLOOP.
    IF sy-subrc EQ 0.
      REFRESH: gi_final, gi_config.

      PERFORM f_get_config_data.
      IF s_objnam IS NOT INITIAL.
        SELECT name FROM trdir
          INTO TABLE gi_trdir WHERE name IN s_objnam AND
                              dbapl <> 'S' AND
                              fixpt = 'X'.
        IF sy-subrc = 0.
          LOOP AT gi_trdir INTO gs_trdir.
            gv_prog = gs_trdir-name.
            PERFORM f_fill_alv_prog USING    gv_prog
                                             gi_keywords
                                    CHANGING gi_final.
          ENDLOOP.
        ENDIF.
      ENDIF.
      rs_selfield-refresh    = 'X'.
      rs_selfield-col_stable = 'X' .
      rs_selfield-row_stable = 'X' .
      MESSAGE 'Auto Correction successfully Completed' TYPE 'S'.
    ELSE.
      MESSAGE 'Please select atleast one entry' TYPE 'W'.
    ENDIF.
  ELSEIF r_ucomm = 'EPDF'.
    LOOP AT gi_final INTO ls_final.
      MOVE-CORRESPONDING ls_final TO wa_final.
      APPEND wa_final TO lt_final.
    ENDLOOP.

    CALL FUNCTION 'ZHANA_EXPORT_PDF'
      EXPORTING
        im_repid = sy-repid
      CHANGING
        output   = lt_final.

  ENDIF.
ENDFORM.                    " HYPERLINK_TABLE

FORM auto_correction .

  DATA: lv_locked  TYPE trparflag,
        lt_objects TYPE tr_objects,
        lv_objname TYPE trobj_name,
        lv_req TYPE TRKORR,
        ls_objects TYPE e071,
        lv_task    TYPE trkorr.

  READ REPORT gs_final-objnam INTO gi_content.
***  IF gs_final-objnam EQ gv_prv_objnam AND gv_flag = 'X' AND gs_final-line GE gv_line.
***    ADD 1 TO gv_cnt.
***    gs_final-line = gs_final-line + gv_cnt.
***  ELSE.
***    gv_cnt = 0.
***  ENDIF.

  READ TABLE gi_content INTO gs_content INDEX gs_final-line.
  IF sy-subrc = 0 AND gs_content-line CS 'DB_EXISTS_INDEX'
                   OR gs_content-line CS 'DD_INDEX_NAME'.

    CLEAR gv_fn.
    MOVE '* Begin of Changes made by HANA Smart Tool.' TO gv_fn.
    INSERT gv_fn INTO gi_content INDEX gs_final-line .
    gv_index =  gs_final-line + 1.
    DO 10 TIMES.
      READ TABLE gi_content INTO gs_content INDEX gv_index.
      IF sy-subrc = 0 .
        SHIFT gs_content-line RIGHT BY 3 PLACES.
        gs_content-line+0(1) = '*'.
        MODIFY gi_content FROM gs_content INDEX gv_index.
        SEARCH gs_content FOR '...'.
        IF sy-subrc EQ 0.
          MOVE '* End of Changes made by HANA Smart Tool.' TO gv_fn.
          INSERT gv_fn INTO gi_content INDEX gv_index + 1 .
          INSERT REPORT gs_final-objnam FROM gi_content UNICODE ENABLING 'X'.
          EXIT.
        ELSE.
          gv_index = gv_index + 1.
        ENDIF.
      ENDIF.
    ENDDO.
    CLEAR: gv_flag.
  ENDIF.
  IF sy-subrc = 0 AND gs_content-line CS 'READ TABLE'.
    keyword = 'READ'.
    APPEND keyword TO i_keywords.
    SCAN ABAP-SOURCE gs_content-line
    TOKENS     INTO i_tokens
    STATEMENTS INTO i_statements
    LEVELS     INTO i_levels
    KEYWORDS   FROM i_keywords
    WITH INCLUDES
    WITH ANALYSIS.

    LOOP AT i_tokens INTO token.

      IF sy-tabix = 3.
        gv_ch1 = token-str.
        SHIFT: gv_ch1 LEFT DELETING LEADING space.
      ENDIF.
      IF token-str = '='.
        gv_ch2 = gv_str.
        SHIFT: gv_ch2 LEFT DELETING LEADING space.
      ENDIF.
      gv_str = token-str.

      CLEAR token.
    ENDLOOP.
    MOVE '* Begin of Changes made by HANA Smart Tool.' TO gv_fn.
    INSERT gv_fn INTO gi_content INDEX gs_final-line.
    CONCATENATE 'SORT'
                 gv_ch1
                 'BY'
                 gv_ch2
                 '.'
                 INTO gv_fn
                 SEPARATED BY space.
    SHIFT gv_fn RIGHT BY 5 PLACES.
    INSERT gv_fn INTO gi_content INDEX gs_final-line + 1.
    MOVE '* End of Changes made by HANA Smart Tool.' TO gv_fn.
    INSERT gv_fn INTO gi_content INDEX gs_final-line + 3.
    INSERT REPORT gs_final-objnam FROM gi_content UNICODE ENABLING 'X'.
    CLEAR: lv_locked, lv_task, lv_req, ls_objects.
    lv_objname = gs_final-objnam.
    CALL FUNCTION 'TR_CHECK_OBJECT_LOCK'
      EXPORTING
        wi_pgmid             = 'R3TR'
        wi_object            = 'PROG'
        wi_objname           = lv_objname
      IMPORTING
        we_locked            = lv_locked
        we_lock_task         = lv_req
        WE_POSSIBLE_USER_EDIT_TASK = lv_task
      EXCEPTIONS
        empty_key            = 1
        no_systemname        = 2
        no_systemtype        = 3
        unallowed_lock_order = 4
        OTHERS               = 5.
    IF sy-subrc = 0.
      IF lv_locked IS NOT INITIAL AND lv_task IS NOT INITIAL.
        ls_objects-trkorr = lv_task.
        ls_objects-pgmid = 'R3TR'.
        ls_objects-object = 'PROG'.
        ls_objects-obj_name = gs_final-objnam.
        APPEND ls_objects TO lt_objects.
        CALL FUNCTION 'TR_REQUEST_CHOICE'
          EXPORTING
            iv_suppress_dialog   = 'X'
            iv_request_types     = 'K'
            iv_request           = lv_req
            it_e071              = lt_objects
          EXCEPTIONS
            invalid_request      = 1
            invalid_request_type = 2
            user_not_owner       = 3
            no_objects_appended  = 4
            enqueue_error        = 5
            cancelled_by_user    = 6
            recursive_call       = 7
            OTHERS               = 8.
      ELSE.
        ls_objects-pgmid = 'R3TR'.
        ls_objects-object = 'PROG'.
        ls_objects-obj_name = gs_final-objnam.
        APPEND ls_objects TO lt_objects.
*        CALL FUNCTION 'TR_REQUEST_CHOICE'
*          EXPORTING
*            iv_suppress_dialog   = ' '
*            iv_request_types     = 'K'
**            iv_request           = lv_req
*            it_e071              = lt_objects
*          EXCEPTIONS
*            invalid_request      = 1
*            invalid_request_type = 2
*            user_not_owner       = 3
*            no_objects_appended  = 4
*            enqueue_error        = 5
*            cancelled_by_user    = 6
*            recursive_call       = 7
*            OTHERS               = 8.
      ENDIF.
    ENDIF.

    MOVE 'X' TO gv_flag.
    CLEAR: gv_ch1, gv_ch2.
  ENDIF.
  gv_prv_objnam = gs_final-objnam.
  gv_line = gs_final-line.
  CLEAR gs_final.

ENDFORM.                    " AUTO_CORRECTION