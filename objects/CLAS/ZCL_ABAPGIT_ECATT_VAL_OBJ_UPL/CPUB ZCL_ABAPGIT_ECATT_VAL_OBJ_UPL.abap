CLASS zcl_abapgit_ecatt_val_obj_upl DEFINITION
  PUBLIC
  INHERITING FROM cl_apl_ecatt_upload
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES:
      zif_abapgit_ecatt_upload.

    METHODS:
      upload REDEFINITION.
