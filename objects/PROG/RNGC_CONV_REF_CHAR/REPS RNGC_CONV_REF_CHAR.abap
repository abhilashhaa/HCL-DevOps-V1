*&---------------------------------------------------------------------*
*& Report RNGC_CONV_REF_CHAR
*&---------------------------------------------------------------------*
*& Cloud introduction: 1711  On-premise introduction: 1809
*&---------------------------------------------------------------------*
REPORT rngc_conv_ref_char.

  CONSTANTS:
    gc_appl_name     TYPE if_shdb_pfw_def=>tv_pfw_appl_name VALUE sy-repid.

  DATA:
    lv_exit          TYPE boole_d,
    lo_refchar       TYPE REF TO CL_NGC_CORE_CONV_REF_CHAR.

  PARAMETERS:
    language         LIKE sy-langu    DEFAULT '',
    rework           TYPE boole_d     DEFAULT abap_false.

INITIALIZATION.

  cl_ngc_core_conv_ref_char=>init_logger( gc_appl_name ).

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

  lo_refchar = NEW #( iv_appl_name = gc_appl_name  iv_language = language  iv_rework = rework ).

  " do some pre-checks before the conversion
  lv_exit = lo_refchar->before_conversion( ).
  IF ( lv_exit = abap_true ).
    EXIT.
  ENDIF.

  " start conversion in the current client
  lo_refchar->convert( ).

  " finish conversion
  lo_refchar->after_conversion( ).