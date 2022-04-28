*&---------------------------------------------------------------------*
*& Report  ZHCLAXON_IDOC_EDI_USAGE
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZHCLAXON_IDOC_EDI_USAGE.
**********************************************************************
* Types Declarations                                                 *
**********************************************************************
TYPE-POOLS : slis.

TYPES : BEGIN OF t_tmsg1_delta,
          mandt	  TYPE edi_mandt,
          mestyp  TYPE edi_mestyp,
          mescod  TYPE edi_mescod,
          mesfct  TYPE edi_mesfct,
          evcoda  TYPE edi_evcoda,
          gentyp  TYPE edi_gentyp,
          gencod  TYPE edi_gencod,
          genfct  TYPE edi_genfct,
          flag    TYPE c,
        END OF t_tmsg1_delta.

TYPES : BEGIN OF t_count,
          mestyp    TYPE edi_mestyp,
          in_count  TYPE i,
          out_count TYPE i,
        END OF t_count.

**********************************************************************
* Data Declarations                                                  *
**********************************************************************
DATA : gw_msgtyp         TYPE edi_mestyp,
       gw_count          TYPE i,
       gw_pos            TYPE i,
       gw_text           TYPE slis_text40.

DATA : gs_tmsg1          TYPE tmsg1,
       gs_tmsg2          TYPE tmsg2,
       gs_count          TYPE t_count,
       gs_layout         TYPE slis_layout_alv,
       gs_fieldcat       TYPE slis_fieldcat_alv.

DATA : gi_edmsg          TYPE STANDARD TABLE OF edmsg,
       gi_tmsg1          TYPE STANDARD TABLE OF tmsg1,
       gi_tmsg2          TYPE STANDARD TABLE OF tmsg2,
       gi_tmsg1_delta    TYPE STANDARD TABLE OF t_tmsg1_delta,
       gi_count          TYPE STANDARD TABLE OF t_count,
       gi_fieldcat_tmsg1 TYPE slis_t_fieldcat_alv,
       gi_fieldcat_tmsg2 TYPE slis_t_fieldcat_alv,
       gi_events         TYPE slis_t_event.

FIELD-SYMBOLS : <fs_tmsg1_delta>    TYPE t_tmsg1_delta.

**********************************************************************
* Constants Declarations                                             *
**********************************************************************
CONSTANTS : k_x           TYPE c         VALUE 'X',
            k_mestyp      TYPE fieldname VALUE 'MESTYP',
            k_mescod      TYPE fieldname VALUE 'MESCOD',
            k_mesfct      TYPE fieldname VALUE 'MESFCT',
            k_evcoda      TYPE fieldname VALUE 'EVCODA',
            k_evcode      TYPE fieldname VALUE 'EVCODE',
            k_gentyp      TYPE fieldname VALUE 'GENTYP',
            k_gencod      TYPE fieldname VALUE 'GENCOD',
            k_genfct      TYPE fieldname VALUE 'GENFCT'.

**********************************************************************
* Selection Screen                                                   *
**********************************************************************
* Message Type
* Direction
SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE text-t01.
SELECT-OPTIONS : s_msgtyp FOR gw_msgtyp.
SELECTION-SCREEN END OF BLOCK b1.

**********************************************************************
* Validations                                                        *
**********************************************************************
* Message Type
IF s_msgtyp IS NOT INITIAL.
  SELECT * INTO TABLE gi_edmsg FROM edmsg
    WHERE msgtyp IN s_msgtyp.
  IF sy-subrc EQ 0.
    SORT gi_edmsg BY msgtyp ASCENDING.
  ELSE.
* Error message
  ENDIF.
ENDIF.

**********************************************************************
* Main Program                                                       *
**********************************************************************
START-OF-SELECTION.
* To set PF Status
  SET PF-STATUS 'ZIDOC'.

* Inbound IDoc/EDI Processing
* Retrieved Message Types
  IF gi_edmsg[] IS NOT INITIAL.
* To get inbound IDoc/EDI message types
    SELECT * INTO TABLE gi_tmsg2 FROM tmsg2
      FOR ALL ENTRIES IN gi_edmsg
      WHERE mestyp EQ gi_edmsg-msgtyp.
    IF sy-subrc EQ 0.
      SORT gi_tmsg2 BY mestyp ASCENDING.
      DELETE gi_tmsg2 WHERE mestyp EQ space.
    ENDIF.
* No input criteria
  ELSE.
* To get inbound IDoc/EDI message types
    SELECT * INTO TABLE gi_tmsg2 FROM tmsg2
    WHERE mestyp IN s_msgtyp.
    IF sy-subrc EQ 0.
      SORT gi_tmsg2 BY mestyp ASCENDING.
      DELETE gi_tmsg2 WHERE mestyp EQ space.
    ENDIF.
  ENDIF.

* Outbound IDoc/EDI Processing
* Retrieved Message Types
  IF gi_edmsg[] IS NOT INITIAL.
* To get outbound IDoc/EDI message types
    SELECT * INTO TABLE gi_tmsg1 FROM tmsg1
     FOR ALL ENTRIES IN gi_edmsg
      WHERE mestyp EQ gi_edmsg-msgtyp.
    IF sy-subrc EQ 0.
      SORT gi_tmsg1 BY mestyp ASCENDING.
      DELETE gi_tmsg1 WHERE mestyp EQ space.
    ENDIF.
* No input criteria
  ELSE.
* To get outbound IDoc/EDI message types
    SELECT * INTO TABLE gi_tmsg1 FROM tmsg1
     WHERE mestyp IN s_msgtyp.
    IF sy-subrc EQ 0.
      SORT gi_tmsg1 BY mestyp ASCENDING.
      DELETE gi_tmsg1 WHERE mestyp EQ space.
    ENDIF.
  ENDIF.

* To move Outbound processing to delta table
  gi_tmsg1_delta[] = gi_tmsg1[].

* To form count table
  LOOP AT gi_tmsg2 INTO gs_tmsg2.
* Message Type
    gs_count-mestyp   = gs_tmsg2-mestyp.
* Inbound count
    gs_count-in_count = 1.

* To get Outbound count
    AT END OF mestyp.
      CLEAR: gw_count.
      LOOP AT gi_tmsg1_delta ASSIGNING <fs_tmsg1_delta>
      WHERE mestyp = gs_tmsg2-mestyp.
* To set deletion flag
        <fs_tmsg1_delta>-flag = 'X'.
        gw_count = gw_count + 1.
      ENDLOOP.
* Outbound count
      gs_count-out_count = gw_count.
    ENDAT.
    COLLECT gs_count INTO gi_count.
    CLEAR : gs_count.
  ENDLOOP.

* To delete processed outbound message types
  DELETE gi_tmsg1_delta WHERE flag EQ 'X'.

* To process outbound message types
  LOOP AT gi_tmsg1_delta INTO gs_tmsg1.
* Message Type
    gs_count-mestyp    = gs_tmsg2-mestyp.
* Inbound Count
    gs_count-in_count  = 0.
* Outbound Count
    gs_count-out_count = 1.
    COLLECT gs_count INTO gi_count.
  ENDLOOP.

**********************************************************************
* List Processing                                                    *
**********************************************************************
END-OF-SELECTION.
  SKIP 1.
  NEW-LINE.

  FORMAT COLOR COL_HEADING ON.
  WRITE sy-uline(129).
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE 2(30) text-d01.
  WRITE sy-vline(1).
  WRITE 34(30) text-d02.
  WRITE sy-vline(1).
  WRITE 66(30) text-d03.
  WRITE sy-vline(1).
  WRITE 98(30) text-d04.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(129).
  FORMAT COLOR OFF.

  LOOP AT gi_count INTO gs_count.
    NEW-LINE.
    WRITE sy-vline(1).
    WRITE 2(30) gs_count-mestyp.
    WRITE sy-vline(1).
    WRITE 34(30) gs_count-in_count.
    WRITE sy-vline(1).
    WRITE 66(30) gs_count-out_count.
    gw_count = gs_count-in_count + gs_count-out_count.
    WRITE sy-vline(1).
    WRITE 98(30) gw_count.
    WRITE sy-vline(1).
    NEW-LINE.
    WRITE sy-uline(129).
  ENDLOOP.

**********************************************************************
* User Command                                                       *
**********************************************************************
AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'DETAIL'.

* To create fieldcatlog
      IF gi_fieldcat_tmsg1[] IS INITIAL OR
         gi_fieldcat_tmsg2[] IS INITIAL.
* Message Type
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_mestyp.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h01.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Message Variant
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-fieldname = k_mescod.
        gs_fieldcat-seltext_l = text-h02.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Message Function
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_mesfct.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h03.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Process Code
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_evcoda.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h04.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        gs_fieldcat-fieldname = k_evcode.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Flag Message Types
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_gentyp.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h05.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Flag Message Codes
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_gencod.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h06.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* Flag Message Functions
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_genfct.
        gs_fieldcat-outputlen = 30.
        gs_fieldcat-seltext_l = text-h07.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg1.
        APPEND gs_fieldcat TO gi_fieldcat_tmsg2.
        CLEAR : gs_fieldcat.

* To create layout properties
        gs_layout-zebra             = k_x.

      ENDIF.

* To initialize of Block List Output
      CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_INIT'
        EXPORTING
          i_callback_program = sy-repid.

      gw_text = text-h08.
* To append Simple List in Block Mode
      CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
        EXPORTING
          is_layout                  = gs_layout
          it_fieldcat                = gi_fieldcat_tmsg1
          i_tabname                  = 'GI_TMSG1'
          it_events                  = gi_events
          i_text                     = 'Hari' "gw_text
        TABLES
          t_outtab                   = gi_tmsg1
        EXCEPTIONS
          program_error              = 1
          maximum_of_appends_reached = 2
          OTHERS                     = 3.
      IF sy-subrc NE 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

      gw_text = text-h09.
* To append Simple List in Block Mode
      CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_APPEND'
        EXPORTING
          is_layout                  = gs_layout
          it_fieldcat                = gi_fieldcat_tmsg2
          i_tabname                  = 'GI_TMSG2'
          it_events                  = gi_events
          i_text                     = 'Gajula' "gw_text
        TABLES
          t_outtab                   = gi_tmsg2
        EXCEPTIONS
          program_error              = 1
          maximum_of_appends_reached = 2
          OTHERS                     = 3.
      IF sy-subrc NE 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

* To display block table
      CALL FUNCTION 'REUSE_ALV_BLOCK_LIST_DISPLAY'
        EXCEPTIONS
          program_error = 1
          OTHERS        = 2.
      IF sy-subrc NE 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

  ENDCASE.