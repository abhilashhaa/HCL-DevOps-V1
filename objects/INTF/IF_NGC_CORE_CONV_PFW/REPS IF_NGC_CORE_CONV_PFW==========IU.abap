INTERFACE if_ngc_core_conv_pfw
  PUBLIC.

  METHODS add_phase
    IMPORTING
      iv_phase    TYPE if_shdb_pfw_def=>tv_pfw_phase
      iv_class    TYPE if_shdb_pfw_def=>tv_pfw_classname OPTIONAL
      ir_instance TYPE REF TO if_serializable_object OPTIONAL
      iv_method   TYPE if_shdb_pfw_def=>tv_pfw_methodname OPTIONAL
      iv_function TYPE if_shdb_pfw_def=>tv_pfw_function OPTIONAL
      ir_params   TYPE REF TO cl_shdb_pfw_params OPTIONAL
    RAISING
      cx_shdb_pfw_exception.

  METHODS run
    RAISING
      cx_shdb_pfw_exception.

  METHODS status.

  METHODS cleanup
    RAISING
      cx_shdb_pfw_exception.
ENDINTERFACE.