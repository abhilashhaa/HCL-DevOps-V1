  PRIVATE SECTION.

    TYPES:
      BEGIN OF lts_pfw,
        application_name TYPE shdb_pfw_appl_name,
        pfw              TYPE REF TO if_ngc_core_conv_pfw,
      END OF lts_pfw.
    TYPES: ltt_pfw TYPE STANDARD TABLE OF lts_pfw WITH EMPTY KEY.

    CLASS-DATA:
      gt_pfw TYPE ltt_pfw,
      go_package_provider TYPE REF TO if_shdb_pfw_package_provider.
