interface IF_NGC_BIL_CLF
  public .


  interfaces IF_NGC_BIL_CLF_TRANSACTIONAL .

  aliases CLEANUP
    for IF_NGC_BIL_CLF_TRANSACTIONAL~CLEANUP .
  aliases FINALIZE
    for IF_NGC_BIL_CLF_TRANSACTIONAL~FINALIZE .
  aliases SAVE
    for IF_NGC_BIL_CLF_TRANSACTIONAL~SAVE .

  types:
  " new type set
    BEGIN OF ts_obj,
      BEGIN OF lock,
        s_input TYPE STRUCTURE FOR LOCK              i_clfnobjecttp,
        t_input TYPE TABLE     FOR LOCK              i_clfnobjecttp,
      END OF lock,

      BEGIN OF create_by,
        BEGIN OF _objectclass,
          s_input TYPE STRUCTURE FOR CREATE        i_clfnobjecttp\_objectclass,
          t_input TYPE TABLE     FOR CREATE        i_clfnobjecttp\_objectclass,
        END OF _objectclass,
      END OF create_by,

      BEGIN OF read,
        s_input  TYPE STRUCTURE FOR READ IMPORT       i_clfnobjecttp,
        s_result TYPE STRUCTURE FOR READ RESULT       i_clfnobjecttp,

        t_input  TYPE TABLE     FOR READ IMPORT       i_clfnobjecttp,
        t_result TYPE TABLE     FOR READ RESULT       i_clfnobjecttp,
      END OF read,

      BEGIN OF read_by,
        BEGIN OF _objectclass,
          s_input  TYPE STRUCTURE FOR READ IMPORT   i_clfnobjecttp\_objectclass,
          s_result TYPE STRUCTURE FOR READ RESULT   i_clfnobjecttp\_objectclass,
          s_link   TYPE STRUCTURE FOR READ LINK     i_clfnobjecttp\_objectclass,

          t_input  TYPE TABLE FOR READ IMPORT   i_clfnobjecttp\_objectclass,
          t_result TYPE TABLE FOR READ RESULT   i_clfnobjecttp\_objectclass,
          t_link   TYPE TABLE FOR READ LINK     i_clfnobjecttp\_objectclass,
        END OF _objectclass,
        BEGIN OF _objectcharc,
          s_input  TYPE STRUCTURE FOR READ IMPORT   i_clfnobjecttp\_objectcharc,
          s_result TYPE STRUCTURE FOR READ RESULT   i_clfnobjecttp\_objectcharc,
          s_link   TYPE STRUCTURE FOR READ LINK     i_clfnobjecttp\_objectcharc,

          t_input  TYPE TABLE FOR READ IMPORT   i_clfnobjecttp\_objectcharc,
          t_result TYPE TABLE FOR READ RESULT   i_clfnobjecttp\_objectcharc,
          t_link   TYPE TABLE FOR READ LINK     i_clfnobjecttp\_objectcharc,
        END OF _objectcharc,
      END OF read_by,

      BEGIN OF action,
        BEGIN OF setrefdata,
          s_input TYPE STRUCTURE FOR ACTION IMPORT     i_clfnobjecttp~setrefdata,
          t_input TYPE TABLE     FOR ACTION IMPORT     i_clfnobjecttp~setrefdata,
        END OF setrefdata,
        BEGIN OF checkconsistency,
          s_input TYPE STRUCTURE FOR ACTION IMPORT     i_clfnobjecttp~checkconsistency,
          t_input TYPE TABLE     FOR ACTION IMPORT     i_clfnobjecttp~checkconsistency,
        END OF checkconsistency,
      END OF action,

      BEGIN OF response,
        s_failed   TYPE STRUCTURE FOR FAILED   i_clfnobjecttp,
        s_reported TYPE STRUCTURE FOR REPORTED i_clfnobjecttp,

        t_failed   TYPE TABLE FOR FAILED   i_clfnobjecttp,
        t_reported TYPE TABLE FOR REPORTED i_clfnobjecttp,
      END OF response,

    END OF ts_obj .
  types:
    BEGIN OF ts_objclass,
      BEGIN OF create,
        s_input TYPE STRUCTURE FOR CREATE        i_clfnobjectclasstp,
        t_input TYPE TABLE     FOR CREATE        i_clfnobjectclasstp,
      END OF create,

      BEGIN OF read,
        s_input  TYPE STRUCTURE FOR READ IMPORT   i_clfnobjectclasstp,
        s_result TYPE STRUCTURE FOR READ RESULT   i_clfnobjectclasstp,

        t_input  TYPE TABLE FOR READ IMPORT   i_clfnobjectclasstp,
        t_result TYPE TABLE FOR READ RESULT   i_clfnobjectclasstp,
      END OF read,

      BEGIN OF delete,
        s_input TYPE STRUCTURE FOR DELETE        i_clfnobjectclasstp,
        t_input TYPE TABLE     FOR DELETE        i_clfnobjectclasstp,
      END OF delete,

      BEGIN OF response,
        s_mapped   TYPE STRUCTURE FOR MAPPED   i_clfnobjectclasstp,
        s_failed   TYPE STRUCTURE FOR FAILED   i_clfnobjectclasstp,
        s_reported TYPE STRUCTURE FOR REPORTED i_clfnobjectclasstp,

        t_mapped   TYPE TABLE FOR MAPPED   i_clfnobjectclasstp,
        t_failed   TYPE TABLE FOR FAILED   i_clfnobjectclasstp,
        t_reported TYPE TABLE FOR REPORTED i_clfnobjectclasstp,
      END OF response,

    END OF ts_objclass .
  types:
    BEGIN OF ts_objcharc,
      BEGIN OF create_by,
        BEGIN OF _objectcharcvalue,
          s_input TYPE STRUCTURE FOR CREATE         i_clfnobjectcharctp\_objectcharcvalue,
          t_input TYPE TABLE     FOR CREATE         i_clfnobjectcharctp\_objectcharcvalue,
        END OF _objectcharcvalue,
      END OF create_by,

      BEGIN OF read,
        s_input  TYPE STRUCTURE FOR READ IMPORT i_clfnobjectcharctp,
        s_result TYPE STRUCTURE FOR READ RESULT i_clfnobjectcharctp,

        t_input  TYPE TABLE FOR READ IMPORT i_clfnobjectcharctp,
        t_result TYPE TABLE FOR READ RESULT i_clfnobjectcharctp,
      END OF read,

      BEGIN OF read_by,
        BEGIN OF _objectcharcvalue,
          s_input  TYPE STRUCTURE FOR READ IMPORT   i_clfnobjectcharctp\_objectcharcvalue,
          s_result TYPE STRUCTURE FOR READ RESULT   i_clfnobjectcharctp\_objectcharcvalue,
          s_link   TYPE STRUCTURE FOR READ LINK     i_clfnobjectcharctp\_objectcharcvalue,

          t_input  TYPE TABLE FOR READ IMPORT   i_clfnobjectcharctp\_objectcharcvalue,
          t_result TYPE TABLE FOR READ RESULT   i_clfnobjectcharctp\_objectcharcvalue,
          t_link   TYPE TABLE FOR READ LINK     i_clfnobjectcharctp\_objectcharcvalue,
        END OF _objectcharcvalue,
      END OF read_by,

      BEGIN OF response,
        s_failed   TYPE STRUCTURE FOR FAILED   i_clfnobjectcharctp,
        s_reported TYPE STRUCTURE FOR REPORTED i_clfnobjectcharctp,

        t_failed   TYPE TABLE FOR FAILED   i_clfnobjectcharctp,
        t_reported TYPE TABLE FOR REPORTED i_clfnobjectcharctp,
      END OF response,

    END OF ts_objcharc .
  types:
    BEGIN OF ts_objcharcval,
      BEGIN OF create,
        s_input TYPE STRUCTURE FOR CREATE      i_clfnobjectcharcvaluetp,
        t_input TYPE TABLE     FOR CREATE      i_clfnobjectcharcvaluetp,
      END OF create,

      BEGIN OF update,
        s_input TYPE STRUCTURE FOR UPDATE      i_clfnobjectcharcvaluetp,
        t_input TYPE TABLE     FOR UPDATE      i_clfnobjectcharcvaluetp,
      END OF update,

      BEGIN OF delete,
        s_input TYPE STRUCTURE FOR DELETE      i_clfnobjectcharcvaluetp,
        t_input TYPE TABLE     FOR DELETE      i_clfnobjectcharcvaluetp,
      END OF delete,

      BEGIN OF read,
        s_input  TYPE STRUCTURE FOR READ IMPORT i_clfnobjectcharcvaluetp,
        s_result TYPE STRUCTURE FOR READ RESULT i_clfnobjectcharcvaluetp,

        t_input  TYPE TABLE FOR READ IMPORT i_clfnobjectcharcvaluetp,
        t_result TYPE TABLE FOR READ RESULT i_clfnobjectcharcvaluetp,
      END OF read,

      BEGIN OF response,
        s_mapped   TYPE STRUCTURE FOR MAPPED   i_clfnobjectcharcvaluetp,
        s_failed   TYPE STRUCTURE FOR FAILED   i_clfnobjectcharcvaluetp,
        s_reported TYPE STRUCTURE FOR REPORTED i_clfnobjectcharcvaluetp,

        t_mapped   TYPE TABLE FOR MAPPED   i_clfnobjectcharcvaluetp,
        t_failed   TYPE TABLE FOR FAILED   i_clfnobjectcharcvaluetp,
        t_reported TYPE TABLE FOR REPORTED i_clfnobjectcharcvaluetp,
      END OF response,

    END OF ts_objcharcval .
  types:
    ts_mapped        TYPE RESPONSE FOR MAPPED        i_clfnobjecttp .
  types:
    ts_failed        TYPE RESPONSE FOR FAILED        i_clfnobjecttp .
  types:
    ts_reported      TYPE RESPONSE FOR REPORTED      i_clfnobjecttp .
  types:
    ts_mapped_late   TYPE RESPONSE FOR MAPPED LATE   i_clfnobjecttp .
  types:
    ts_failed_late   TYPE RESPONSE FOR FAILED LATE   i_clfnobjecttp .
  types:
    ts_reported_late TYPE RESPONSE FOR REPORTED LATE i_clfnobjecttp .

  " new method set
  methods CREATE_OBJ_OBJCLASS
    importing
      !IT_INPUT type TS_OBJ-CREATE_BY-_OBJECTCLASS-T_INPUT
    exporting
      !ES_MAPPED type TS_MAPPED
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods CREATE_OBJCLASS
    importing
      !IT_INPUT type TS_OBJCLASS-CREATE-T_INPUT
    exporting
      !ES_MAPPED type TS_MAPPED
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods CREATE_OBJCHARC_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARC-CREATE_BY-_OBJECTCHARCVALUE-T_INPUT
    exporting
      !ES_MAPPED type TS_MAPPED
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods CREATE_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARCVAL-CREATE-T_INPUT
    exporting
      !ES_MAPPED type TS_MAPPED
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJ
    importing
      !IT_INPUT type TS_OBJ-READ-T_INPUT
    exporting
      !ET_RESULT type TS_OBJ-READ-T_RESULT
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJ_OBJCLASS
    importing
      !IT_INPUT type TS_OBJ-READ_BY-_OBJECTCLASS-T_INPUT
    exporting
      !ET_RESULT type TS_OBJ-READ_BY-_OBJECTCLASS-T_RESULT
      !ET_LINK type TS_OBJ-READ_BY-_OBJECTCLASS-T_LINK
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJ_OBJCHARC
    importing
      !IT_INPUT type TS_OBJ-READ_BY-_OBJECTCHARC-T_INPUT
    exporting
      !ET_RESULT type TS_OBJ-READ_BY-_OBJECTCHARC-T_RESULT
      !ET_LINK type TS_OBJ-READ_BY-_OBJECTCHARC-T_LINK
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJCLASS
    importing
      !IT_INPUT type TS_OBJCLASS-READ-T_INPUT
    exporting
      !ET_RESULT type TS_OBJCLASS-READ-T_RESULT
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJCHARC
    importing
      !IT_INPUT type TS_OBJCHARC-READ-T_INPUT
    exporting
      !ET_RESULT type TS_OBJCHARC-READ-T_RESULT
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJCHARC_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARC-READ_BY-_OBJECTCHARCVALUE-T_INPUT
    exporting
      !ET_RESULT type TS_OBJCHARC-READ_BY-_OBJECTCHARCVALUE-T_RESULT
      !ET_LINK type TS_OBJCHARC-READ_BY-_OBJECTCHARCVALUE-T_LINK
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods READ_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARCVAL-READ-T_INPUT
    exporting
      !ET_RESULT type TS_OBJCHARCVAL-READ-T_RESULT
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods UPDATE_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARCVAL-UPDATE-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods DELETE_OBJCLASS
    importing
      !IT_INPUT type TS_OBJCLASS-DELETE-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods DELETE_OBJCHARCVAL
    importing
      !IT_INPUT type TS_OBJCHARCVAL-DELETE-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods EXEC_OBJ_SETREFDATA
    importing
      !IT_INPUT type TS_OBJ-ACTION-SETREFDATA-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods EXEC_OBJ_CHECKCONSISTENCY
    importing
      !IT_INPUT type TS_OBJ-ACTION-CHECKCONSISTENCY-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
  methods LOCK_OBJ
    importing
      !IT_INPUT type TS_OBJ-LOCK-T_INPUT
    exporting
      !ES_FAILED type TS_FAILED
      !ES_REPORTED type TS_REPORTED .
endinterface.