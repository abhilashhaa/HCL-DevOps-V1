*&---------------------------------------------------------------------*
*& Report RNGC_CONV_REF_CHAR_CLEANUP_OP
*&---------------------------------------------------------------------*
*& Cloud introduction: -  On-premise introduction: On-Demand only
*&---------------------------------------------------------------------*
REPORT rngc_conv_ref_char_cleanup_op.

TABLES: inob.

  CONSTANTS:
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_refchar_clnup TYPE REF TO cl_ngc_core_conv_refchar_clnup.

  PARAMETERS:
    language         LIKE sy-langu    DEFAULT '',
    log2file         TYPE boole_d     DEFAULT ' ',
    testmode         TYPE boole_d.

SELECT-OPTIONS: objek FOR inob-objek.

INITIALIZATION.

  IF language EQ ''.
    CALL 'C_SAPGPARAM' ID 'NAME'  FIELD 'zcsa/system_language'
                       ID 'VALUE' FIELD language.
    IF language EQ ''.
      language = sy-langu.
      IF language EQ ''.
        language = 'E'.
      ENDIF.
    ENDIF.
  ENDIF.

START-OF-SELECTION.

  " We must log at least a single message under all conditions (execution skipped, error, success, no data found for processing, ...).
  " No message is interpreted as cancelled program (RABAX) and therefore causes the system upgrade to stop!

  lo_refchar_clnup = NEW #(
    iv_appl_name = gc_appl_name
    iv_language  = language
    iv_lock      = abap_true
    iv_log2file  = log2file
    iv_testmode  = testmode
    itr_objek    = objek[]
  ).

  " do some pre-checks before the conversion
  lv_exit = lo_refchar_clnup->before_conversion( ).
  IF lv_exit = abap_true.
    EXIT.
  ENDIF.

  " start conversion in the current client
  lo_refchar_clnup->convert( ).

  " finish conversion
  lo_refchar_clnup->after_conversion( ).