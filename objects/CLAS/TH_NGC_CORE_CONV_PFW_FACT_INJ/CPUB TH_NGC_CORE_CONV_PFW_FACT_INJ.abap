CLASS th_ngc_core_conv_pfw_fact_inj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC
  FOR TESTING.

  PUBLIC SECTION.

    CLASS-METHODS inject_pfw
      IMPORTING
        iv_application_name TYPE shdb_pfw_appl_name
        io_instance         TYPE REF TO if_ngc_core_conv_pfw.

    CLASS-METHODS inject_package_provider
      IMPORTING
        io_instance TYPE REF TO if_shdb_pfw_package_provider.
