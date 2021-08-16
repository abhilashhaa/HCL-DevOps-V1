INTERFACE if_ngc_core_conv_logger
  PUBLIC.

  CONSTANTS gc_logtype_auto TYPE upgba_logtype VALUE 99 ##NO_TEXT.

  METHODS init_logger
    IMPORTING
      !iv_appl_name TYPE if_shdb_pfw_def=>tv_pfw_appl_name
      !iv_logtype   TYPE upgba_logtype DEFAULT gc_logtype_auto.

  METHODS init_logger_pp
    IMPORTING
      !iv_appl_name TYPE if_shdb_pfw_def=>tv_pfw_appl_name.

  METHODS log_message
    IMPORTING
      !iv_id       TYPE string
      !iv_type     TYPE string
      !iv_number   TYPE string
      !iv_severity TYPE symsgty OPTIONAL
      !iv_param1   TYPE string OPTIONAL
      !iv_param2   TYPE string OPTIONAL
      !iv_param3   TYPE string OPTIONAL
      !iv_param4   TYPE string OPTIONAL.

  METHODS log_error
    IMPORTING
      !ix_root TYPE REF TO cx_root.

  METHODS trace_process_messages
    IMPORTING
      !iv_processid TYPE upgba_pid.

  METHODS close.
ENDINTERFACE.