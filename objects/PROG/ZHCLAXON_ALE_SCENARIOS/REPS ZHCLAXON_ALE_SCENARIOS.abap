*&---------------------------------------------------------------------*
*& Report  ZHCLAXON_ALE_SCENARIOS
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*

REPORT ZHCLAXON_ALE_SCENARIOS.
**********************************************************************
* Types Declarations                                                 *
**********************************************************************
TYPE-POOLS : slis.

TYPES : BEGIN OF t_output_count,
         mestyp  TYPE edipmestyp,
         descrp  TYPE edi_text60,
         in      TYPE i,
         out     TYPE i,
         local   TYPE i,
        END OF t_output_count.

TYPES : BEGIN OF t_output,
         logsys	 TYPE logsys,
         mestyp  TYPE edipmestyp,
         descrp  TYPE edi_text60,
         direct  TYPE char10,
        END OF t_output.

**********************************************************************
* Data Declarations                                                  *
**********************************************************************
DATA : gi_tbdls        TYPE STANDARD TABLE OF tbdls,
       gi_t000         TYPE STANDARD TABLE OF t000,
       gi_t000_delta   TYPE STANDARD TABLE OF t000,
       gi_edp21        TYPE STANDARD TABLE OF edp21,
       gi_edp13        TYPE STANDARD TABLE OF edp13,
       gi_output_count TYPE STANDARD TABLE OF t_output_count,
       gi_edimsgt      TYPE STANDARD TABLE OF edimsgt,
       gi_fieldcat     TYPE slis_t_fieldcat_alv,
       gi_output       TYPE STANDARD TABLE OF t_output.

DATA : gs_tbdls        TYPE tbdls,
       gs_t000         TYPE t000,
       gs_edp21        TYPE edp21,
       gs_edp13        TYPE edp13,
       gs_output_count TYPE t_output_count,
       gs_edimsgt      TYPE edimsgt,
       gs_layout       TYPE slis_layout_alv,
       gs_fieldcat     TYPE slis_fieldcat_alv,
       gs_output       TYPE t_output.

DATA : gw_logsys       TYPE logsys,
       gw_count        TYPE i,
       gw_count_in     TYPE i,
       gw_count_out    TYPE i,
       gw_count_local  TYPE i,
       gw_count_sum    TYPE i,
       gw_msg          TYPE edi_text60,
       gw_pos          TYPE i.

FIELD-SYMBOLS : <fs_output_count> TYPE t_output_count.

CONSTANTS : k_logsys    TYPE fieldname VALUE 'LOGSYS',
            k_mestyp    TYPE fieldname VALUE 'MESTYP',
            k_descrp    TYPE fieldname VALUE 'DESCRP',
            k_direct    TYPE fieldname VALUE 'DIRECT'.

**********************************************************************
* Main Program                                                       *
**********************************************************************
START-OF-SELECTION.
* To set PF Status
  SET PF-STATUS 'ALE'.

* To get Logical Systems
  SELECT * INTO TABLE gi_tbdls FROM tbdls.
  IF sy-subrc EQ 0.
    SORT gi_tbdls BY logsys ASCENDING.
  ENDIF.

* To get clients and system details linked to Logical Systems
  IF gi_tbdls[] IS NOT INITIAL.
    SELECT * INTO TABLE gi_t000 FROM t000
      FOR ALL ENTRIES IN gi_tbdls
      WHERE logsys EQ gi_tbdls-logsys.
    IF sy-subrc EQ 0.
      SORT gi_t000 BY mandt ASCENDING logsys ASCENDING.
    ENDIF.
  ENDIF.

* To get Partner Profile - Inbound : EDP21
  SELECT * INTO TABLE gi_edp21 FROM edp21
    WHERE sndprt EQ 'LS'.
  IF sy-subrc EQ 0.
    SORT gi_edp21 BY mestyp ASCENDING sndprn ASCENDING.
  ENDIF.

* To get Partner Profile - Outbound : EDP13
  SELECT * INTO TABLE gi_edp13 FROM edp13
    WHERE rcvprt EQ 'LS'.
  IF sy-subrc EQ 0.
    SORT gi_edp13 BY mestyp ASCENDING rcvprn ASCENDING.
  ENDIF.

* To get the Descriptions
  SELECT * INTO TABLE gi_edimsgt FROM edimsgt
    FOR ALL ENTRIES IN gi_edp21
    WHERE ( langua EQ sy-langu OR langua EQ 'E' ) AND
          mestyp EQ gi_edp21-mestyp.
  IF sy-subrc EQ 0.
    SORT gi_edimsgt BY langua ASCENDING mestyp ASCENDING.
  ENDIF.

* To get the Descriptions
  SELECT * APPENDING TABLE gi_edimsgt FROM edimsgt
    FOR ALL ENTRIES IN gi_edp13
    WHERE ( langua EQ sy-langu OR langua EQ 'E' ) AND
          mestyp EQ gi_edp13-mestyp.
  IF sy-subrc EQ 0.
    SORT gi_edimsgt BY langua ASCENDING mestyp ASCENDING.
  ENDIF.

* To delete duplicate Message Type descriptions
  DELETE ADJACENT DUPLICATES FROM gi_edimsgt COMPARING ALL FIELDS.

* To get assocaited current clients Logical Systems
  gi_t000_delta[] = gi_t000[].
  DELETE gi_t000_delta WHERE mandt NE sy-mandt.

  LOOP AT gi_edp21 INTO gs_edp21.
    CLEAR : gw_logsys.
    gs_output_count-mestyp = gs_edp21-mestyp.
* To check Logical System as Current System
    gw_logsys = gs_edp21-sndprn.
* Begin of Changes made by HANA Smart Tool.
     SORT GI_T000_DELTA BY LOGSYS .
* End of Changes made by HANA Smart Tool.
    READ TABLE gi_t000_delta TRANSPORTING NO FIELDS
    WITH KEY logsys = gw_logsys BINARY SEARCH.
    IF sy-subrc EQ 0.
      gs_output_count-local = 1.
    ELSE.
      gs_output_count-in = 1.
    ENDIF.

* To get descriptions
    READ TABLE gi_edimsgt INTO gs_edimsgt
    WITH KEY langua = sy-langu
             mestyp = gs_output_count-mestyp BINARY SEARCH.
    IF sy-subrc NE 0.
      READ TABLE gi_edimsgt INTO gs_edimsgt
      WITH KEY langua = sy-langu
               mestyp = gs_output_count-mestyp BINARY SEARCH.
      IF sy-subrc EQ 0.
        gs_output_count-descrp = gs_edimsgt-descrp.
      ENDIF.
    ELSE.
      gs_output_count-descrp = gs_edimsgt-descrp.
    ENDIF.
    COLLECT gs_output_count INTO gi_output_count.

* To form final output table
    gs_output-logsys = gs_edp21-sndprn.
    gs_output-mestyp = gs_edp21-mestyp.
    gs_output-descrp = gs_output_count-descrp.
    gs_output-direct = text-002.
    APPEND gs_output TO gi_output.
    CLEAR : gs_output, gs_output_count..
  ENDLOOP.

  LOOP AT gi_edp13 INTO gs_edp13.
    CLEAR : gw_logsys.
    gs_output_count-mestyp = gs_edp21-mestyp.

    READ TABLE gi_output_count ASSIGNING <fs_output_count>
    WITH KEY mestyp = gs_edp13-mestyp.
    IF sy-subrc EQ 0.
* To check Logical System as Current System
      gw_logsys = gs_edp13-rcvprn.
      READ TABLE gi_t000_delta TRANSPORTING NO FIELDS
      WITH KEY logsys = gw_logsys BINARY SEARCH.
      IF sy-subrc EQ 0.
        <fs_output_count>-local = <fs_output_count>-local + 1.
      ELSE.
        <fs_output_count>-out = <fs_output_count>-out + 1.
      ENDIF.

    ELSE.
* To check Logical System as Current System
      gw_logsys = gs_edp13-rcvprn.
      READ TABLE gi_t000_delta TRANSPORTING NO FIELDS
      WITH KEY logsys = gw_logsys BINARY SEARCH.
      IF sy-subrc EQ 0.
        gs_output_count-local = 1.
      ELSE.
        gs_output_count-out = 1.
      ENDIF.
      gs_output_count-in = 0.
* To get descriptions
      READ TABLE gi_edimsgt INTO gs_edimsgt
      WITH KEY langua = sy-langu
               mestyp = gs_output_count-mestyp BINARY SEARCH.
      IF sy-subrc NE 0.
        READ TABLE gi_edimsgt INTO gs_edimsgt
        WITH KEY langua = sy-langu
                 mestyp = gs_output_count-mestyp BINARY SEARCH.
        IF sy-subrc EQ 0.
          gs_output_count-descrp = gs_edimsgt-descrp.
        ENDIF.
      ELSE.
        gs_output_count-descrp = gs_edimsgt-descrp.
      ENDIF.
      COLLECT gs_output_count INTO gi_output_count.
    ENDIF.
* To form final output table
    gs_output-logsys = gs_edp13-rcvprn.
    gs_output-mestyp = gs_edp13-mestyp.
    IF gs_output_count-descrp IS NOT INITIAL.
      gs_output-descrp = gs_output_count-descrp.
    ELSE.
      gs_output-descrp = <fs_output_count>-descrp.
    ENDIF.
    gs_output-direct = text-003.
    APPEND gs_output TO gi_output.
    CLEAR : gs_output, gs_output_count.
  ENDLOOP.

  IF gi_output[] IS NOT INITIAL.
    SORT gi_output BY logsys ASCENDING mestyp ASCENDING
         direct ASCENDING.
  ENDIF.

**********************************************************************
* List Processing                                                    *
**********************************************************************
END-OF-SELECTION.
  WRITE sy-uline(173).
  NEW-LINE.
  FORMAT COLOR COL_HEADING ON.
  WRITE sy-vline(1).
  WRITE AT 2(40) text-001.
  WRITE sy-vline(1).
  WRITE AT 44(60) text-008.
  WRITE sy-vline(1).
  WRITE AT 106(15) text-002.
  WRITE sy-vline(1).
  WRITE AT 123(15) text-003.
  WRITE sy-vline(1).
  WRITE AT 140(15) text-004.
  WRITE sy-vline(1).
  WRITE AT 157(15) text-005.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE AT 2(40) text-000.
  WRITE sy-vline(1).
  WRITE AT 44(60) text-000.
  WRITE sy-vline(1).
  WRITE AT 106(15) text-007.
  WRITE sy-vline(1).
  WRITE AT 123(15) text-007.
  WRITE sy-vline(1).
  WRITE AT 140(15) text-007.
  WRITE sy-vline(1).
  WRITE AT 157(15) text-007.
  WRITE sy-vline(1).
  NEW-LINE.
  WRITE sy-uline(173).
  FORMAT COLOR OFF.

  SORT gi_output_count BY mestyp ASCENDING.
  FORMAT COLOR COL_NORMAL ON.
  LOOP AT gi_output_count INTO gs_output_count.
    NEW-LINE.
    WRITE sy-vline(1).
    WRITE AT 2(40) gs_output_count-mestyp.
    WRITE sy-vline(1).
    WRITE AT 44(60) gs_output_count-descrp.
    WRITE sy-vline(1).
    WRITE AT 106(15) gs_output_count-in.
    gw_count_in = gw_count_in + gs_output_count-in.
    WRITE sy-vline(1).
    WRITE AT 123(15) gs_output_count-out.
    gw_count_out = gw_count_out + gs_output_count-out.
    WRITE sy-vline(1).
    WRITE AT 140(15) gs_output_count-local.
    gw_count_local = gw_count_local + gs_output_count-local.
    WRITE sy-vline(1).
    gw_count = gs_output_count-in + gs_output_count-out +
               gs_output_count-local.
    gw_count_sum = gw_count_sum + gw_count.
    WRITE AT 157(15) gw_count.
    WRITE sy-vline(1).
    WRITE sy-uline(173).
    CLEAR : gw_count, gw_msg.
  ENDLOOP.
  FORMAT COLOR OFF.

  FORMAT COLOR COL_TOTAL ON.
  NEW-LINE.
  WRITE sy-vline(1).
  WRITE AT 2(40) text-006.
  WRITE sy-vline(1).
  WRITE AT 44(60) gw_msg.
  WRITE sy-vline(1).
  WRITE AT 106(15) gw_count_in.
  WRITE sy-vline(1).
  WRITE AT 123(15) gw_count_out.
  WRITE sy-vline(1).
  WRITE AT 140(15) gw_count_local.
  WRITE sy-vline(1).
  gw_count = gs_output_count-in + gs_output_count-out +
             gs_output_count-local.
  WRITE AT 157(15) gw_count_sum.
  WRITE sy-vline(1).
  WRITE sy-uline(173).
  FORMAT COLOR OFF.

**********************************************************************
* User Command                                                       *
**********************************************************************
AT USER-COMMAND.
  CASE sy-ucomm.
    WHEN 'DETAIL'.
* To create fieldcatlog
      IF gi_fieldcat[] IS INITIAL.
* Logical System
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_logsys.
        gs_fieldcat-seltext_l = text-c01.
        gs_fieldcat-seltext_m = text-c01.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* Message
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_mestyp.
        gs_fieldcat-seltext_l = text-c02.
        gs_fieldcat-seltext_m = text-c02.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* Desription
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_descrp.
        gs_fieldcat-seltext_l = text-c03.
        gs_fieldcat-seltext_m = text-c03.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* Direction
        gw_pos = gw_pos + 1.
        gs_fieldcat-col_pos   = gw_pos.
        gs_fieldcat-fieldname = k_direct.
        gs_fieldcat-seltext_l = text-c04.
        gs_fieldcat-seltext_m = text-c04.
        APPEND gs_fieldcat TO gi_fieldcat.
        CLEAR : gs_fieldcat.

* To create layout properties
        gs_layout-zebra             = 'X'.
        gs_layout-colwidth_optimize = 'X'.
      ENDIF.

* To display ALV
      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program = sy-repid
          i_grid_title       = text-001
          is_layout          = gs_layout
          it_fieldcat        = gi_fieldcat
        TABLES
          t_outtab           = gi_output
        EXCEPTIONS
          program_error      = 1
          OTHERS             = 2.
      IF sy-subrc <> 0.
        MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
                WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
      ENDIF.

  ENDCASE.