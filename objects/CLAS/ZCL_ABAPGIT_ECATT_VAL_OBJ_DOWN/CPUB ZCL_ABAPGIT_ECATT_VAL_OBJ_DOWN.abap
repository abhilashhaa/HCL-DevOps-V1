CLASS zcl_abapgit_ecatt_val_obj_down DEFINITION
  PUBLIC
  INHERITING FROM cl_apl_ecatt_download
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_ecatt_download.

    METHODS:
      download REDEFINITION.
