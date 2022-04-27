*&---------------------------------------------------------------------*
*& Report  ZHCL_IMPACT_DEPOOLING
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zhcl_impact_depooling.

*** Type pools decalarations ***
TYPE-POOLS: slis, icon.

TYPES: BEGIN OF ty_final,
         flag         TYPE flag,
         tabclas      TYPE tabclass,
         tabname      TYPE tabname,
         tabdesc      TYPE as4text,
         sqltab       TYPE sqltable,
         error(60)    TYPE c,
         recomend(60) TYPE c,
       END OF ty_final,

       BEGIN OF ty_status,
         status  TYPE char4,
         tabclas TYPE tabclass,
         tabname TYPE tabname,
         tabdesc TYPE as4text,
         sqltab  TYPE sqltable,
         message TYPE char30,
       END OF ty_status.

DATA: it_final   TYPE STANDARD TABLE OF ty_final,
      it_status  TYPE STANDARD TABLE OF ty_status,
      it_dd02l   TYPE STANDARD TABLE OF dd02l,
      it_dd02t   TYPE STANDARD TABLE OF dd02t,
      wa_final   TYPE                   ty_final,
      wa_status  TYPE                   ty_status,
      wa_dd02l   TYPE                   dd02l,
      wa_dd02t   TYPE                   dd02t,
      it_bdcdata TYPE STANDARD TABLE OF bdcdata,
      it_messtab TYPE STANDARD TABLE OF bdcmsgcoll,
      wa_bdcdata TYPE                   bdcdata.

*data declarations for ALV Main list
DATA : wa_layout      TYPE slis_layout_alv,
       it_fieldcat    TYPE slis_t_fieldcat_alv,
       wa_fieldcat    TYPE slis_fieldcat_alv,
       it_fieldcat_st TYPE slis_t_fieldcat_alv.

DATA: it_fcode TYPE TABLE OF sy-ucomm,
      wa_fcode TYPE          sy-ucomm.

*** Global Variable declarations ***
DATA : v_repid LIKE sy-repid.

*Start of selection event
START-OF-SELECTION.
*fetch data into table
  PERFORM fetch_data.
** Build Field catalogue
  PERFORM build_fieldcat_data.
*ALV display for output
  PERFORM alv_output.

*&---------------------------------------------------------------------*
*&      Form  FETCH_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM fetch_data .

  REFRESH: it_dd02l, it_dd02t, it_final.

  SELECT *
         FROM dd02l
         INTO TABLE it_dd02l
         WHERE tabname LIKE 'Z%'
         AND ( tabclass = 'CLUSTER'
         OR    tabclass = 'POOL' ).

  IF it_dd02l IS NOT INITIAL.
    SELECT *
           FROM dd02t
           INTO TABLE it_dd02t
           FOR ALL ENTRIES IN it_dd02l
           WHERE tabname = it_dd02l-tabname
           AND ddlanguage = sy-langu.
  ENDIF.

  LOOP AT it_dd02l INTO wa_dd02l.
    wa_final-tabname = wa_dd02l-tabname.
    wa_final-sqltab  = wa_dd02l-sqltab.
    wa_final-tabclas = wa_dd02l-tabclass.
    READ TABLE it_dd02t INTO wa_dd02t WITH KEY tabname = wa_dd02l-tabname.
    IF sy-subrc = 0.
      wa_final-tabdesc = wa_dd02t-ddtext.
    ENDIF.
    wa_final-error    = text-001.
    wa_final-recomend = text-002.
    APPEND wa_final TO it_final.
    CLEAR: wa_final, wa_dd02t, wa_dd02t.
  ENDLOOP.

ENDFORM.                    " FETCH_DATA

*&---------------------------------------------------------------------*
*&      Form  BUILD_FIELDCAT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM build_fieldcat_data .

  wa_fieldcat-col_pos   = 1.
  wa_fieldcat-fieldname = 'TABCLAS'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Table Type'(003).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 2.
  wa_fieldcat-fieldname = 'TABNAME'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-hotspot   = 'X'.
  wa_fieldcat-seltext_m = 'Table Name'(004).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 3.
  wa_fieldcat-fieldname = 'TABDESC'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Table Description'(005).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 4.
  wa_fieldcat-fieldname = 'SQLTAB'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'SQL Table'(009).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 5.
  wa_fieldcat-fieldname = 'ERROR'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Error Description'(006).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 6.
  wa_fieldcat-fieldname = 'RECOMEND'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Recommended Solution'(007).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

************************************************************

  wa_fieldcat-col_pos   = 1.
  wa_fieldcat-fieldname = 'STATUS'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Status'(010).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 2.
  wa_fieldcat-fieldname = 'TABCLAS'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Table Type'(003).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 3.
  wa_fieldcat-fieldname = 'TABNAME'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Table Name'(004).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 4.
  wa_fieldcat-fieldname = 'TABDESC'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Table Description'(005).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 5.
  wa_fieldcat-fieldname = 'SQLTAB'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'SQL Table'(009).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 6.
  wa_fieldcat-fieldname = 'MESSAGE'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Status Description'(011).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

ENDFORM.                    " BUILD_FIELDCAT_DATA

*&---------------------------------------------------------------------*
*&      Form  ALV_OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM alv_output .

  v_repid = sy-repid.
  wa_layout-zebra = 'X'.
  wa_layout-colwidth_optimize = 'X'.
  wa_layout-box_fieldname     = 'FLAG'.

  IF it_final IS NOT INITIAL.

    SORT it_final BY tabclas tabname.

*** Display of output data ***
    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
      EXPORTING
        i_callback_program       = v_repid
        i_callback_pf_status_set = 'SET_PF_STATUS'
        i_callback_user_command  = 'HYPERLINK_TABLE'
        is_layout                = wa_layout
        it_fieldcat              = it_fieldcat
      TABLES
        t_outtab                 = it_final
      EXCEPTIONS
        ##FM_SUBRC_OK
        program_error            = 1
        OTHERS                   = 2.

  ELSE.
    MESSAGE 'No entries found'(008) TYPE 'S' DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.

ENDFORM.                    " ALV_OUTPUT

*&---------------------------------------------------------------------*
*&      Form  SET_PF_STATUS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_pf_status ##CALLED
                   USING rt_extab TYPE slis_t_extab ##NEEDED.

  SET PF-STATUS 'ZCLUSTER'.

ENDFORM.                    " SET_PF_STATUS

*&---------------------------------------------------------------------*
*&      Form  SET_PF_STATUS1
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM set_pf_status1 ##CALLED
                   USING rt_extab TYPE slis_t_extab ##NEEDED.

  wa_fcode = 'WHER'. APPEND wa_fcode TO it_fcode.
  wa_fcode = 'CONV'. APPEND wa_fcode TO it_fcode.
  wa_fcode = 'PDFD'. APPEND wa_fcode TO it_fcode.

  SET PF-STATUS: 'ZCLUSTER' EXCLUDING it_fcode.

ENDFORM.                    " SET_PF_STATUS1

*&---------------------------------------------------------------------*
*&      Form  HYPERLINK_TABLE
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM hyperlink_table USING r_ucomm     LIKE sy-ucomm ##CALLED ##NEEDED
                        rs_selfield TYPE slis_selfield ##NEEDED.

  REFRESH: it_bdcdata, it_status.

***Reading the selected data into a variable
  READ TABLE it_final INTO wa_final INDEX rs_selfield-tabindex.
  IF sy-subrc = 0 AND wa_final-tabname IS NOT INITIAL.

    IF r_ucomm = '&IC1'.

      PERFORM bdc_dynpro      USING 'SAPLSD_ENTRY' '1000'.
      PERFORM bdc_field       USING 'RSRD1-TBMA'
                                    'X'.
      PERFORM bdc_field       USING 'RSRD1-TBMA_VAL'
                                    wa_final-tabname.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_DISPLAY'.
      PERFORM bdc_dynpro      USING 'SAPLSD_ENTRY' '1000'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_BACK'.
      CALL TRANSACTION 'SE11' USING it_bdcdata
                 MODE   'E'
                 UPDATE 'L'
                 MESSAGES INTO it_messtab.

    ELSEIF r_ucomm = 'WHER'.

      CALL FUNCTION 'RS_TOOL_ACCESS' ##FM_SUBRC_OK
        EXPORTING
          operation           = 'CROSSREF'
          object_name         = wa_final-tabname
          object_type         = 'SQLT'
        EXCEPTIONS
          not_executed        = 1
          invalid_object_type = 2
          OTHERS              = 3.
    ENDIF.

  ENDIF.

  IF r_ucomm = 'CONV'.

    LOOP AT it_final INTO wa_final WHERE flag = 'X'.

      PERFORM bdc_dynpro      USING 'SAPLSD_ENTRY' '1000'.
      PERFORM bdc_field       USING 'RSRD1-TBMA_VAL'
                                    wa_final-tabname.
      PERFORM bdc_field       USING 'RSRD1-TBMA'
                                    'X'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_EDIT'.
      PERFORM bdc_dynpro      USING 'SAPLSD41' '2200'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=TCC'.
      PERFORM bdc_dynpro      USING 'SAPLSED2' '0010'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=GOON'.
      PERFORM bdc_field       USING 'FLAG1'
                                    'X'.
      PERFORM bdc_dynpro      USING 'SAPLSD41' '2200'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=DBUT'.
      PERFORM bdc_dynpro      USING 'SAPLSPO1' '0300'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=YES'.
      PERFORM bdc_dynpro      USING 'SAPMSGTB' '0400'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=CNV'.
      PERFORM bdc_field       USING 'RSGTB-SUB'
                                    'X'.
      PERFORM bdc_field       USING 'RSGTB-SDATA'
                                    'X'.
      PERFORM bdc_dynpro      USING 'SAPLSPO1' '0400'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=YES'.
      PERFORM bdc_dynpro      USING 'SAPMSGTB' '0400'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '/EBACK'.

      CALL TRANSACTION 'SE11' USING it_bdcdata
                 MODE   'N'
                 UPDATE 'A'
                 MESSAGES INTO it_messtab.

      READ TABLE it_messtab WITH KEY msgtyp = 'E' TRANSPORTING NO FIELDS.
      IF sy-subrc <> 0.
        wa_status-status  = icon_green_light. "'@09@'."
        wa_status-message = 'Table converted successfully'(012).
      ELSE.
        wa_status-status  = icon_red_light. "'@0A@'."
        wa_status-message = 'Table convertion failed'(013).
      ENDIF.
      MOVE-CORRESPONDING wa_final TO wa_status.
      APPEND wa_status TO it_status.
      CLEAR: wa_status, wa_final.
      REFRESH: it_bdcdata, it_messtab.
    ENDLOOP.

    IF sy-subrc = 0.
**fetch data into table
      PERFORM fetch_data.
      rs_selfield-refresh = 'X'.
      PERFORM display_status.
    ELSE.
      MESSAGE 'Please select atleast one entry'(014) TYPE 'W'.
    ENDIF.
  ENDIF.

  IF r_ucomm = 'PDFD'.
    CALL FUNCTION 'ZHANA_EXPORT_PDF'
      EXPORTING
        im_repid = sy-repid
      CHANGING
        output   = it_final.

*    CALL FUNCTION '/1BCDWB/SF00000002'
**      EXPORTING
*      TABLES
*        input_depooling = it_final.
  ENDIF.

ENDFORM.                    " HYPERLINK_TABLE

*----------------------------------------------------------------------*
*        Start new screen                                              *
*----------------------------------------------------------------------*
FORM bdc_dynpro USING program TYPE bdc_prog
                      dynpro  TYPE bdc_dynr.
  wa_bdcdata-program  = program.
  wa_bdcdata-dynpro   = dynpro.
  wa_bdcdata-dynbegin = 'X'.
  APPEND wa_bdcdata TO it_bdcdata.
  CLEAR: wa_bdcdata.
ENDFORM.

*----------------------------------------------------------------------*
*        Insert field                                                  *
*----------------------------------------------------------------------*
FORM bdc_field USING fnam TYPE any
                     fval TYPE any.
  IF fval IS NOT INITIAL.
    wa_bdcdata-fnam = fnam.
    wa_bdcdata-fval = fval.
    APPEND wa_bdcdata TO it_bdcdata.
    CLEAR: wa_bdcdata.
  ENDIF.
ENDFORM.

*&---------------------------------------------------------------------*
*&      Form  DISPLAY_STATUS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM display_status .

  wa_layout-box_fieldname = ''.

*** Display of output data ***
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = v_repid
      i_callback_pf_status_set = 'SET_PF_STATUS1'
      is_layout                = wa_layout
      it_fieldcat              = it_fieldcat_st
    TABLES
      t_outtab                 = it_status
    EXCEPTIONS
      ##FM_SUBRC_OK
      program_error            = 1
      OTHERS                   = 2.

ENDFORM.                    " DISPLAY_STATUS