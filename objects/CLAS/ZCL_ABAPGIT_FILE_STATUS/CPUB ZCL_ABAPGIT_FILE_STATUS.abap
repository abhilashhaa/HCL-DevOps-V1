CLASS zcl_abapgit_file_status DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS status
      IMPORTING io_repo           TYPE REF TO zcl_abapgit_repo
                ii_log            TYPE REF TO zif_abapgit_log OPTIONAL
      RETURNING VALUE(rt_results) TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING   zcx_abapgit_exception.
