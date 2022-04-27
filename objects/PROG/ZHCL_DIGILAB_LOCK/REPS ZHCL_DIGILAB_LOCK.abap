*&---------------------------------------------------------------------*
*& Report ZHCL_DIGILAB_LOCK
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZHCL_DIGILAB_LOCK.
*********types declaration
TYPE-POOLS :ABAP,SLIS,TRUXS.
TYPES: BEGIN OF TY_LOG,
         MANDT     TYPE MANDT,
         BNAME     TYPE XUBNAME,
         NAME_TEXT TYPE AD_NAMETXT,
         GLTGV     TYPE XUGLTGV,
         GLTGB     TYPE XUGLTGB,
         CLASS     TYPE XUCLASS,
         TRDAT     TYPE XULDATE,
         UNAME     TYPE UNAME,
         AEDAT     TYPE AEDAT,
         MESSAGE   TYPE BAPI_MSG,
         TYPE      TYPE BAPI_MTYPE,
         RFCDEST   TYPE RFCDEST,
         STATUS    TYPE CHAR255,
       END OF TY_LOG.
TYPES: BEGIN OF TY_FINAL,
         BNAME     TYPE XUBNAME,
         GLTGV     TYPE XUGLTGV,
         GLTGB     TYPE XUGLTGB,
         CLASS     TYPE XUCLASS,
         TRDAT     TYPE XULDATE,
         NAME_TEXT TYPE AD_NAMETXT,
         UNAME     TYPE UNAME,
         AEDAT     TYPE AEDAT,
         USTYP     TYPE XUUSTYP,
         USTPDES   TYPE CHAR255,
       END OF TY_FINAL .

*****internal table & wa declaration
DATA: IT_USER  TYPE STANDARD TABLE OF USR02,
      WA_USER  TYPE USR02,
      IT_ADDR  TYPE STANDARD TABLE OF USER_ADDR,
      WA_ADDR  TYPE USER_ADDR,
      IT_FINAL TYPE STANDARD TABLE OF TY_FINAL,
      WA_FINAL TYPE TY_FINAL.
DATA :
  LV_ID   TYPE CHAR1,
  INDXKEY TYPE INDX-SRTFD.

DATA: LV_DATE        TYPE SY-DATUM,
      IT_DD07V_TAB_N TYPE STANDARD TABLE OF DD07V,
      IT_DD07V_TAB_A TYPE STANDARD TABLE OF DD07V,
      WA_DD07V_TAB_A TYPE DD07V.

START-OF-SELECTION.
  PERFORM DOMAIN_VALUE.
  PERFORM GET_DATA.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM GET_DATA .

  REFRESH IT_USER.
  LV_DATE = SY-DATUM - 30.                                       "Calculate Date

**********************Fetch Logon Data from 'USR02' table
  SELECT BNAME GLTGV GLTGB USTYP CLASS TRDAT
  FROM USR02
  INTO CORRESPONDING FIELDS OF TABLE IT_USER
  WHERE TRDAT LE LV_DATE
  AND USTYP EQ 'A'                                              "Dialog User
  AND UFLAG IN (0, 128).                                        "Unlocked User

  IF IT_USER[] IS NOT INITIAL.

***********************Fetch User Name
    SELECT BNAME NAME_TEXTC
    FROM USER_ADDR
    INTO CORRESPONDING FIELDS OF TABLE IT_ADDR
    FOR ALL ENTRIES IN IT_USER
    WHERE BNAME = IT_USER-BNAME.

    PERFORM PREPARE_DATA.
  ELSE.
*    MESSAGE S000 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DOMAIN_VALUE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM DOMAIN_VALUE .
  CALL FUNCTION 'DD_DOMA_GET'
    EXPORTING
      DOMAIN_NAME   = 'XUUSTYP'
      LANGU         = SY-LANGU
      WITHTEXT      = 'X'
    TABLES
      DD07V_TAB_A   = IT_DD07V_TAB_A
      DD07V_TAB_N   = IT_DD07V_TAB_N
    EXCEPTIONS
      ILLEGAL_VALUE = 1
      OP_FAILURE    = 2
      OTHERS        = 3.
  IF SY-SUBRC <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form PREPARE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM PREPARE_DATA .
  DATA: LV_INDEX  TYPE SY-INDEX,
        LV_ANSWER TYPE C.
  SORT: IT_ADDR BY BNAME,
       IT_DD07V_TAB_A BY DOMVALUE_L.
  LOOP AT IT_USER INTO WA_USER.
    LV_INDEX = SY-TABIX.

    MOVE WA_USER-BNAME TO WA_FINAL-BNAME.
    MOVE WA_USER-GLTGV TO WA_FINAL-GLTGV.
    MOVE WA_USER-GLTGB TO WA_FINAL-GLTGB.
    MOVE WA_USER-CLASS TO WA_FINAL-CLASS.
    MOVE WA_USER-USTYP TO WA_FINAL-USTYP.
    MOVE WA_USER-TRDAT TO WA_FINAL-TRDAT.

    READ TABLE  IT_DD07V_TAB_A INTO WA_DD07V_TAB_A WITH KEY DOMVALUE_L = WA_USER-USTYP BINARY SEARCH.
    IF SY-SUBRC = 0.
      MOVE WA_DD07V_TAB_A-DDTEXT TO WA_FINAL-USTPDES.
    ENDIF.

    READ TABLE IT_ADDR INTO WA_ADDR WITH KEY BNAME = WA_USER-BNAME BINARY SEARCH.
    IF SY-SUBRC IS INITIAL.
      MOVE WA_ADDR-NAME_TEXTC TO WA_FINAL-NAME_TEXT.
    ENDIF.

    MOVE SY-UNAME TO WA_FINAL-UNAME.
    MOVE SY-DATUM TO WA_FINAL-AEDAT.
    APPEND WA_FINAL TO IT_FINAL.
  ENDLOOP.

***********************LOCKING WITHOUT POPUP***************

  PERFORM CALL_BAPI.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form CALL_BAPI
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM CALL_BAPI .

  DATA: IT_RETURN TYPE STANDARD TABLE OF BAPIRET2,
        WA_RETURN TYPE BAPIRET2,
        IT_LOG    TYPE STANDARD TABLE OF TY_LOG,
        WA_LOG    TYPE TY_LOG.

  LOOP AT IT_FINAL INTO WA_FINAL.
    CLEAR: IT_RETURN.
    REFRESH: IT_RETURN.

    CALL FUNCTION 'BAPI_USER_LOCK'
      EXPORTING
        USERNAME = WA_FINAL-BNAME
      TABLES
        RETURN   = IT_RETURN.

    READ TABLE IT_RETURN TRANSPORTING NO FIELDS WITH KEY TYPE = 'E'.
    IF SY-SUBRC IS NOT INITIAL.
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          WAIT = 'X'.
    ENDIF.

    LOOP AT IT_RETURN INTO WA_RETURN.
      CLEAR: WA_LOG.
      MOVE SY-MANDT TO WA_LOG-MANDT.
      MOVE WA_FINAL-BNAME TO WA_LOG-BNAME.
      MOVE WA_FINAL-NAME_TEXT TO WA_LOG-NAME_TEXT.
      MOVE WA_FINAL-GLTGV TO WA_LOG-GLTGV.
      MOVE WA_FINAL-GLTGB TO WA_LOG-GLTGB.
      MOVE WA_FINAL-CLASS TO WA_LOG-CLASS.
      CONCATENATE 'Locked User'  WA_FINAL-BNAME INTO WA_LOG-STATUS SEPARATED BY SPACE.
      MOVE WA_FINAL-TRDAT TO WA_LOG-TRDAT.
      MOVE SY-UNAME TO WA_LOG-UNAME.
      MOVE SY-DATUM TO WA_LOG-AEDAT.
      MOVE WA_RETURN-MESSAGE TO WA_LOG-MESSAGE.
      MOVE WA_RETURN-TYPE TO WA_LOG-TYPE.
      APPEND WA_LOG TO IT_LOG.
    ENDLOOP.

  ENDLOOP.

  IF IT_LOG[] IS NOT INITIAL.
******************Save Locked User in ZLUSR table
    PERFORM SAVE_DB TABLES IT_LOG.
*    PERFORM DISPLAY_LOG_ALV TABLES IT_LOG.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SAVE_DB
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> IT_LOG
*&---------------------------------------------------------------------*
FORM SAVE_DB  TABLES   P_IT_LOG.
  DATA: P_IT_LOG1 TYPE STANDARD TABLE OF TY_LOG.

  P_IT_LOG1[] = P_IT_LOG[].
  DELETE P_IT_LOG1 WHERE TYPE NE 'S'.

  IF P_IT_LOG1[] IS NOT INITIAL.
    MODIFY ZHCL_LUSR FROM TABLE P_IT_LOG1.
  ENDIF.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_LOG_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*&      --> IT_LOG
*&---------------------------------------------------------------------*
FORM DISPLAY_LOG_ALV  TABLES   P_IT_LOG.
  DATA: IS_LAYOUT   TYPE  SLIS_LAYOUT_ALV,
        IT_FIELDCAT TYPE SLIS_T_FIELDCAT_ALV,
        WA_FIELDCAT TYPE SLIS_FIELDCAT_ALV.

  MOVE 'BNAME' TO WA_FIELDCAT-FIELDNAME.
  MOVE TEXT-007 TO WA_FIELDCAT-SELTEXT_M.
  APPEND WA_FIELDCAT TO IT_FIELDCAT.

  MOVE 'MESSAGE' TO WA_FIELDCAT-FIELDNAME.
  MOVE TEXT-014 TO WA_FIELDCAT-SELTEXT_M.
  APPEND WA_FIELDCAT TO IT_FIELDCAT.


  MOVE 'X' TO IS_LAYOUT-COLWIDTH_OPTIMIZE.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      I_CALLBACK_PROGRAM     = SY-REPID
      IS_LAYOUT              = IS_LAYOUT
      IT_FIELDCAT            = IT_FIELDCAT
      I_CALLBACK_TOP_OF_PAGE = 'TOP-OF-PAGE'  "see FORM
    TABLES
      T_OUTTAB               = P_IT_LOG
    EXCEPTIONS
      PROGRAM_ERROR          = 1
      OTHERS                 = 2.
  IF SY-SUBRC <> 0.
    SY-MSGTY = 'S'.
    MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
    WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4 DISPLAY LIKE 'E'.
    LEAVE LIST-PROCESSING.
  ENDIF.



ENDFORM.