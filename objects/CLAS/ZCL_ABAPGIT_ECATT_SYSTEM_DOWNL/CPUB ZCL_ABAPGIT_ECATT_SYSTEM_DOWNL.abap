CLASS zcl_abapgit_ecatt_system_downl DEFINITION
  PUBLIC
  INHERITING FROM cl_apl_ecatt_systems_download
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_ecatt_download.

    METHODS:
      download REDEFINITION.
