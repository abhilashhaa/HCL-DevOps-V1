*&---------------------------------------------------------------------*
*& Report  ZHCL_IMPACT_INDEX
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT zhcl_impact_index.

TABLES: dd02l.
*** Type pools decalarations ***
TYPE-POOLS: slis, icon.

TYPES: BEGIN OF ty_final,
         flag      TYPE flag,
         tabname   TYPE tabname,
         tabdesc   TYPE as4text,
         secindxn  TYPE indexid,
         secindxd  TYPE ddtext,
         error(60) TYPE c,
         recomend  TYPE char30,
       END OF ty_final,

       BEGIN OF ty_status,
         status   TYPE char4,
         tabname  TYPE tabname,
         tabdesc  TYPE as4text,
         secindxn TYPE indexid,
         secindxd TYPE ddtext,
         message  TYPE char30,
       END OF ty_status.

DATA: it_final   TYPE STANDARD TABLE OF ty_final,
      it_status  TYPE STANDARD TABLE OF ty_status,
      it_dd12l   TYPE STANDARD TABLE OF dd12l,
      it_dd12t   TYPE STANDARD TABLE OF dd12t,
      it_dd02t   TYPE STANDARD TABLE OF dd02t,
      it_bdcdata TYPE STANDARD TABLE OF bdcdata,
      wa_final   TYPE                   ty_final,
      wa_status  TYPE                   ty_status,
      wa_dd12l   TYPE                   dd12l,
      wa_dd12t   TYPE                   dd12t,
      wa_dd02t   TYPE                   dd02t,
      wa_bdcdata TYPE                   bdcdata.

*data declarations for ALV Main list
DATA : wa_layout      TYPE slis_layout_alv,
       it_fieldcat    TYPE slis_t_fieldcat_alv,
       wa_fieldcat    TYPE slis_fieldcat_alv,
       it_fieldcat_st TYPE slis_t_fieldcat_alv.

*** Global Variable declarations ***
DATA : v_repid TYPE sy-repid,
       v_subrc TYPE sy-subrc.

DATA: it_fcode TYPE TABLE OF sy-ucomm,
      wa_fcode TYPE          sy-ucomm.

SELECTION-SCREEN BEGIN OF BLOCK selection WITH FRAME TITLE text-010.
SELECTION-SCREEN BEGIN OF BLOCK b1.
SELECT-OPTIONS : s_table FOR dd02l-tabname.
SELECTION-SCREEN END OF BLOCK b1.
SELECTION-SCREEN END OF BLOCK selection.

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

  REFRESH: it_dd12l, it_dd12t, it_dd02t, it_final.

  SELECT *
         FROM dd12l
         INTO TABLE it_dd12l
         WHERE sqltab IN s_table
         AND as4user <> 'SAP'.
  IF sy-subrc = 0.
    SELECT *
           FROM dd12t
           INTO TABLE it_dd12t
           FOR ALL ENTRIES IN it_dd12l
           WHERE sqltab = it_dd12l-sqltab
           AND   indexname = it_dd12l-indexname
           AND   ddlanguage = sy-langu.
    SELECT *
           FROM dd02t
           INTO TABLE it_dd02t
           FOR ALL ENTRIES IN it_dd12l
           WHERE tabname = it_dd12l-sqltab
           AND ddlanguage = sy-langu.
  ENDIF.

  LOOP AT it_dd12l INTO wa_dd12l.
    READ TABLE it_dd02t INTO wa_dd02t WITH KEY tabname = wa_dd12l-sqltab.
    IF sy-subrc = 0.
      wa_final-tabdesc  = wa_dd02t-ddtext.
    ENDIF.
    READ TABLE it_dd12t INTO wa_dd12t WITH KEY sqltab    = wa_dd12l-sqltab
                                               indexname = wa_dd12l-indexname.
    IF sy-subrc = 0.
      wa_final-secindxd = wa_dd12t-ddtext.
    ENDIF.
    wa_final-tabname   = wa_dd12l-sqltab.
    wa_final-secindxn  = wa_dd12l-indexname.
    wa_final-error     = 'SECONDARY INDEXES ARE NOT SUPPORTED IN HANA ENVIRONMENT'(001).
    wa_final-recomend  = 'DELETE THE SECONDARY INDEX'(002).
    APPEND wa_final TO it_final.
    CLEAR: wa_final, wa_dd02t, wa_dd12t.
  ENDLOOP.

ENDFORM.                    " FETCH_DATA

*&---------------------------------------------------------------------*
*&      Form  build_fieldcat_data
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM build_fieldcat_data .

  wa_fieldcat-col_pos   = 1.
  wa_fieldcat-fieldname = 'TABNAME'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Table Name'(003).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 2.
  wa_fieldcat-fieldname = 'TABDESC'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Table Description'(004).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 3.
  wa_fieldcat-fieldname = 'SECINDXN'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-hotspot   = 'X'.
  wa_fieldcat-seltext_m = 'Secondary Index'(005).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 4.
  wa_fieldcat-fieldname = 'SECINDXD'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Secondary Index Desc.'(006).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 5.
  wa_fieldcat-fieldname = 'ERROR'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Error Description'(007).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 6.
  wa_fieldcat-fieldname = 'RECOMEND'.
  wa_fieldcat-tabname   = 'IT_FINAL'.
  wa_fieldcat-seltext_m = 'Recommended Solution'(008).
  APPEND wa_fieldcat TO it_fieldcat.
  CLEAR: wa_fieldcat.

**************************************************************************

  wa_fieldcat-col_pos   = 1.
  wa_fieldcat-fieldname = 'STATUS'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Status'(011).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 2.
  wa_fieldcat-fieldname = 'TABNAME'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Table Name'(003).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 3.
  wa_fieldcat-fieldname = 'TABDESC'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Table Description'(004).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 4.
  wa_fieldcat-fieldname = 'SECINDXN'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Secondary Index'(005).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 5.
  wa_fieldcat-fieldname = 'SECINDXD'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Secondary Index Desc.'(006).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

  wa_fieldcat-col_pos   = 6.
  wa_fieldcat-fieldname = 'MESSAGE'.
  wa_fieldcat-tabname   = 'IT_STATUS'.
  wa_fieldcat-seltext_m = 'Status Description'(012).
  APPEND wa_fieldcat TO it_fieldcat_st.
  CLEAR: wa_fieldcat.

ENDFORM.                    " build_fieldcat_data

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
    MESSAGE 'No entries found'(009) TYPE 'S' DISPLAY LIKE 'E'.
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

  SET PF-STATUS 'ZINDEX'.

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

  wa_fcode = 'EXEC'. APPEND wa_fcode TO it_fcode.
  wa_fcode = 'PDFD'. APPEND wa_fcode TO it_fcode.

  SET PF-STATUS 'ZINDEX' EXCLUDING it_fcode.

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

  IF r_ucomm = '&IC1'.

***Reading the selected data into a variable
    READ TABLE it_final INTO wa_final INDEX rs_selfield-tabindex.
    IF sy-subrc = 0 AND wa_final-tabname IS NOT INITIAL.
      PERFORM bdc_dynpro      USING 'SAPLSD_ENTRY' '1000'.
      PERFORM bdc_field       USING 'RSRD1-TBMA'
                                    'X'.
      PERFORM bdc_field       USING 'RSRD1-TBMA_VAL'
                                    wa_final-tabname.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_DISPLAY'.
      PERFORM bdc_dynpro      USING 'SAPLSD41' '2200'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'DD02D-DBTABNAME'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=INDX'.
      PERFORM bdc_dynpro      USING 'SAPLSEDD_APPEND_LIST' '0100'.
      PERFORM bdc_field       USING 'BDC_CURSOR'
                                    'DD03D-INDXFIELD(10)'.
      PERFORM bdc_dynpro      USING 'SAPLSD41' '2200'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_BACK'.
      PERFORM bdc_dynpro      USING 'SAPLSD_ENTRY' '1000'.
      PERFORM bdc_field       USING 'BDC_OKCODE'
                                    '=WB_BACK'.
      CALL TRANSACTION 'SE11' USING it_bdcdata
                 MODE   'E'
                 UPDATE 'L'.
    ENDIF.

  ELSEIF r_ucomm = 'EXEC'.
    LOOP AT it_final INTO wa_final WHERE flag = 'X'.
      CALL FUNCTION 'DD_INDX_DEL'
        EXPORTING
          sqltab    = wa_final-tabname
          indexname = wa_final-secindxn
          del_state = 'M'
        IMPORTING
          rc        = v_subrc.
      IF v_subrc = 0.
        wa_status-status  = icon_green_light. "'@09@'."
        wa_status-message = 'Index deleted successfully'(013).
      ELSE.
        wa_status-status  = icon_red_light. "'@0A@'."
        wa_status-message = 'Index deletion failed'(014).
      ENDIF.
      MOVE-CORRESPONDING wa_final TO wa_status.
      APPEND wa_status TO it_status.
      CLEAR: wa_status, wa_final.
    ENDLOOP.
    IF sy-subrc = 0.
*fetch data into table
      PERFORM fetch_data.
      rs_selfield-refresh = 'X'.
      PERFORM display_status.
    ELSE.
      MESSAGE 'Please select atleast one entry'(015) TYPE 'W'.
    ENDIF.
  ENDIF.

  IF r_ucomm = 'PDFD'.

    CALL FUNCTION 'ZHANA_EXPORT_PDF'
      EXPORTING
        im_repid = sy-repid
      CHANGING
        output   = it_final.

*    CALL FUNCTION '/1BCDWB/SF00000003'
*      TABLES
*        input_index = it_final.

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