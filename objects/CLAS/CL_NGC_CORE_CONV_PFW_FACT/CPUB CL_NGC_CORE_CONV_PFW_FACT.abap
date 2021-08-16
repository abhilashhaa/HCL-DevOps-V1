CLASS cl_ngc_core_conv_pfw_fact DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  GLOBAL FRIENDS th_ngc_core_conv_pfw_fact_inj.

  PUBLIC SECTION.

    CLASS-METHODS:
      get_pfw
        IMPORTING
          iv_application_name TYPE shdb_pfw_appl_name
        RETURNING
          VALUE(ro_instance)  TYPE REF TO if_ngc_core_conv_pfw
        RAISING
          cx_shdb_pfw_exception,

      get_new_package_provider
        RETURNING
          VALUE(ro_instance) TYPE REF TO if_shdb_pfw_package_provider
        RAISING
          cx_shdb_pfw_exception.
