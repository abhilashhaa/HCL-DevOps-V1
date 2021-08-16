CLASS zcl_abapgit_ecatt_script_downl DEFINITION
  PUBLIC
  INHERITING FROM cl_apl_ecatt_script_download
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_ecatt_download.

    METHODS:
      download REDEFINITION.
