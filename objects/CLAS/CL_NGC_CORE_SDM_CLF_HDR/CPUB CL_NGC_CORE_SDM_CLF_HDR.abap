CLASS cl_ngc_core_sdm_clf_hdr DEFINITION
  PUBLIC
  INHERITING FROM cl_sdm_package_migration
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS if_sdm_migration~get_package_size
        REDEFINITION .
    METHODS if_sdm_migration~get_prerequisites
        REDEFINITION .
    METHODS if_sdm_migration~get_selective_field
        REDEFINITION .
    METHODS if_sdm_migration~get_status_field
        REDEFINITION .
    METHODS if_sdm_migration~get_status_value_done
        REDEFINITION .
    METHODS if_sdm_migration~get_table_name
        REDEFINITION .
    METHODS if_sdm_migration~migrate_data
        REDEFINITION .
    METHODS if_sdm_migration~migrate_data_finished
        REDEFINITION .
    METHODS if_sdm_migration~must_run
        REDEFINITION .