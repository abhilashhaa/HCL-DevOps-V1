*&---------------------------------------------------------------------*
*& Report  ZHCLAXON_RFC_CONNECTIONS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZHCLAXON_RFC_CONNECTIONS.
**********************************************************************
* Types Declarations                                                 *
**********************************************************************
TYPE-POOLS : slis.

TYPES : BEGIN OF t_rfcdes,
         rfctype  TYPE rfctype_d,
         rfcdest  TYPE rfcdest,
        END OF t_rfcdes.

TYPES : BEGIN OF t_rfctyp_count,
         rfctype  TYPE rfctype_d,
         count    TYPE i,
        END OF t_rfctyp_count.

TYPES : BEGIN OF t_output,
         rfctype       TYPE rfctype_d,
         type_text(60) TYPE c,
         rfcdest       TYPE rfcdest,
         rfcdoc1       TYPE rfcdoc_d,
         rfcdoc2       TYPE rfcdoc_d,
         rfcdoc3       TYPE rfcdoc_d,
        END OF t_output.

**********************************************************************
* Data Declarations                                                  *
**********************************************************************
DATA : gw_rfctype          TYPE rfctype_d,
       gw_pos              TYPE i,
       gw_rfctype_total    TYPE i.

DATA : gs_rfcdes           TYPE t_rfcdes,
       gs_rfcdoc           TYPE rfcdoc,
       gs_rfctyp_count     TYPE t_rfctyp_count,
       gs_output           TYPE t_output,
       gs_layout           TYPE slis_layout_alv,
       gs_fieldcat         TYPE slis_fieldcat_alv.

DATA : gi_rfctype          TYPE STANDARD TABLE OF rfctype,
       gi_rfcdes           TYPE STANDARD TABLE OF t_rfcdes,
       gi_rfcdoc           TYPE STANDARD TABLE OF rfcdoc,
       gi_rfctyp_count     TYPE STANDARD TABLE OF t_rfctyp_count,
       gi_output           TYPE STANDARD TABLE OF t_output,
       gi_fieldcat         TYPE slis_t_fieldcat_alv.

**********************************************************************
* Constants Declarations                                             *
**********************************************************************
CONSTANTS : k_lan_eng       TYPE sy-langu    VALUE 'E',
            k_x             TYPE c           VALUE 'X',
            k_type_text     TYPE fieldname   VALUE 'TYPE_TEXT',
            k_rfcdest       TYPE fieldname   VALUE 'RFCDEST',
            k_rfcdoc1       TYPE fieldname   VALUE 'RFCDOC1',
            k_rfcdoc2       TYPE fieldname   VALUE 'RFCDOC2',
            k_rfcdoc3       TYPE fieldname   VALUE 'RFCDOC3'.

**********************************************************************
* Selection Screen                                                   *
**********************************************************************
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
SELECT-OPTIONS : s_type FOR gw_rfctype.
SELECTION-SCREEN END OF BLOCK b1.

**********************************************************************
* Validations                                                        *
**********************************************************************
IF s_type[] IS NOT INITIAL.
  SELECT * INTO TABLE gi_rfctype FROM rfctype
   WHERE rfctype IN s_type.
  IF sy-subrc EQ 0.
    SORT gi_rfctype BY rfctype ASCENDING.
  ELSE.
* Error message
  ENDIF.
ENDIF.

**********************************************************************
* Main Program                                                       *
**********************************************************************
START-OF-SELECTION.

* To set PF Status
  SET PF-STATUS 'ZRFC'.

  IF gi_rfctype[] IS NOT INITIAL.
* To get validate RFC Destinations
    SELECT rfctype rfcdest INTO TABLE gi_rfcdes
      FROM rfcdes FOR ALL ENTRIES IN gi_rfctype       "#EC CI_SGLSELECT
      WHERE rfctype EQ gi_rfctype-rfctype.
    IF sy-subrc EQ 0.
      SORT gi_rfcdes BY rfctype ASCENDING rfcdest ASCENDING.
    ENDIF.
  ELSE.
* To get all RFC Destinations
    SELECT rfctype rfcdest INTO TABLE gi_rfcdes
     FROM rfcdes WHERE rfctype IN s_type.             "#EC CI_SGLSELECT
    IF sy-subrc EQ 0.
      SORT gi_rfcdes BY rfctype ASCENDING rfcdest ASCENDING.
    ENDIF.
  ENDIF.

* To RFC Destinations descriptions
  IF gi_rfcdes[] IS NOT INITIAL.
* To RFC Destinations descriptions
    SELECT * INTO TABLE gi_rfcdoc FROM rfcdoc         "#EC CI_SGLSELECT
      FOR ALL ENTRIES IN gi_rfcdes
      WHERE ( rfclang EQ sy-langu OR rfclang EQ k_lan_eng )  AND
            rfcdest EQ gi_rfcdes-rfcdest.
    IF sy-subrc EQ 0.
      SORT gi_rfcdoc BY rfclang ASCENDING rfcdest ASCENDING.
      DELETE ADJACENT DUPLICATES FROM gi_rfcdoc COMPARING ALL FIELDS.
    ENDIF.
  ENDIF.

* To form the Output data
  LOOP AT gi_rfcdes INTO gs_rfcdes.
* RFC Connection Type count
    gs_rfctyp_count-rfctype = gs_rfcdes-rfctype.
    gs_rfctyp_count-count   = 1.
    COLLECT gs_rfctyp_count INTO gi_rfctyp_count.
    CLEAR : gs_rfctyp_count.

* RFC Connection Type
    gs_output-rfctype = gs_rfcdes-rfctype.
    CASE gs_rfcdes-rfctype.
* ABAP Connections
      WHEN '3'.
        gs_output-type_text = text-d01.
* TCP/IP Connections
      WHEN 'T'.
        gs_output-type_text = text-d02.
* Connections via ABAP Driver
      WHEN 'X'.
        gs_output-type_text = text-d03.
* Internal Connections
      WHEN 'I'.
        gs_output-type_text = text-d04.
* HTTP Connections to External Server
      WHEN 'G'.
        gs_output-type_text = text-d05.
* HTTP Connections to ABAP System
      WHEN 'H'.
        gs_output-type_text = text-d06.
* Logical Connections
      WHEN 'L'.
        gs_output-type_text = text-d07.
    ENDCASE.

* RFC Destination
    gs_output-rfcdest = gs_rfcdes-rfcdest.
* To get RFC Connection description in system language
    READ TABLE gi_rfcdoc INTO gs_rfcdoc
    WITH KEY rfclang = sy-langu
             rfcdest = gs_rfcdes-rfcdest BINARY SEARCH.
    IF sy-subrc EQ 0.
      gs_output-rfcdoc1 = gs_rfcdoc-rfcdoc1.
      gs_output-rfcdoc2 = gs_rfcdoc-rfcdoc2.
      gs_output-rfcdoc3 = gs_rfcdoc-rfcdoc3.
    ELSE.
* To get RFC Connection description in English language
      READ TABLE gi_rfcdoc INTO gs_rfcdoc
      WITH KEY rfclang = k_lan_eng
      rfcdest = gs_rfcdes-rfcdest BINARY SEARCH.
      IF sy-subrc EQ 0.
        gs_output-rfcdoc1 = gs_rfcdoc-rfcdoc1.
        gs_output-rfcdoc2 = gs_rfcdoc-rfcdoc2.
        gs_output-rfcdoc3 = gs_rfcdoc-rfcdoc3.
      ENDIF.
    ENDIF.
    APPEND gs_output TO gi_output.
    CLEAR : gs_output, gs_rfcdoc.
  ENDLOOP.

**********************************************************************
* List Processing                                                    *
**********************************************************************
END-OF-SELECTION.
***** Overview of RFC Connections in system environment *****
  SKIP 1.

  WRITE sy-uline(80).
* Column Heading Line - 1
  NEW-LINE.
  WRITE sy-vline(1).
  FORMAT COLOR COL_HEADING ON.
  FORMAT INTENSIFIED ON.
  WRITE 3(40) text-c01.

  WRITE sy-vline(1).
  WRITE 45(34) text-c02.
  WRITE sy-vline(1).
  FORMAT COLOR OFF.

  NEW-LINE.
  WRITE sy-uline(80).

* ABAP Connections
  NEW-LINE.
  WRITE sy-vline(1).
  FORMAT COLOR COL_NORMAL ON.
  FORMAT COLOR  COL_NORMAL ON.
  WRITE 3(40) text-d01.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = '3' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* TCP/IP Connections
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d02.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'T' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* Connections via ABAP Driver
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d03.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'X' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* Internal Connections
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d04.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'I' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* HTTP Connections to External Server
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d05.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'G' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* HTTP Connections to ABAP System
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d06.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'H' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* Logical Connections
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d07.
  WRITE sy-vline(1).
* No. of Connections
  READ TABLE gi_rfctyp_count INTO gs_rfctyp_count
  WITH KEY rfctype = 'L' BINARY SEARCH.
  IF sy-subrc EQ 0.
    WRITE 45(34) gs_rfctyp_count-count.
  ELSE.
    CLEAR : gs_rfctyp_count.
    WRITE 45(34) gs_rfctyp_count-count.
  ENDIF.
* Total
  gw_rfctype_total = gw_rfctype_total + gs_rfctyp_count-count.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

* Total
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 3(40) text-d08 COLOR COL_TOTAL ON.
  WRITE sy-vline(1).
* No. of Connections
  IF gw_rfctype_total NE 0.
    WRITE 45(34) gw_rfctype_total COLOR COL_TOTAL ON.
  ELSE.
    CLEAR : gw_rfctype_total.
    WRITE 45(34) gw_rfctype_total COLOR COL_TOTAL ON.
  ENDIF.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(80).

**********************************************************************
* User Command                                                       *
**********************************************************************
AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'DETAIL'.
* To create fieldcatlog
      IF gi_fieldcat[] IS INITIAL.
* RFC Connection Type
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_type_text.
        gs_fieldcat-seltext_l = text-h01.
        gs_fieldcat-seltext_m = text-h01.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* RFC Connection
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_rfcdest.
        gs_fieldcat-seltext_l = text-h02.
        gs_fieldcat-seltext_m = text-h02.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* RFC Description 1
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_rfcdoc1.
        gs_fieldcat-seltext_l = text-h03.
        gs_fieldcat-seltext_m = text-h03.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* RFC Description 2
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_rfcdoc2.
        gs_fieldcat-seltext_l = text-h04.
        gs_fieldcat-seltext_m = text-h04.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* RFC Description 3
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_rfcdoc3.
        gs_fieldcat-seltext_l = text-h05.
        gs_fieldcat-seltext_m = text-h05.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* To create layout properties
        gs_layout-zebra             = k_x.
        gs_layout-colwidth_optimize = k_x.

      ENDIF.

* To display output list
      CALL FUNCTION 'REUSE_ALV_LIST_DISPLAY'
        EXPORTING
          is_layout     = gs_layout
          it_fieldcat   = gi_fieldcat
        TABLES
          t_outtab      = gi_output
        EXCEPTIONS
          program_error = 1
          OTHERS        = 2.
* Error in ALV display
      IF sy-subrc NE 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

  ENDCASE.