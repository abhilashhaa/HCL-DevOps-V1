CLASS zcl_abapgit_zip DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS export
      IMPORTING
        !io_repo       TYPE REF TO zcl_abapgit_repo
        !iv_show_log   TYPE abap_bool DEFAULT abap_true
        !it_filter     TYPE zif_abapgit_definitions=>ty_tadir_tt OPTIONAL
      RETURNING
        VALUE(rv_xstr) TYPE xstring
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS export_object
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS export_package
      EXPORTING
        !ev_xstr    TYPE xstring
        !ev_package TYPE devclass
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS load
      IMPORTING
        !iv_xstr        TYPE xstring
      RETURNING
        VALUE(rt_files) TYPE zif_abapgit_definitions=>ty_files_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS save_binstring_to_localfile
      IMPORTING iv_filename  TYPE string
                iv_binstring TYPE xstring
      RAISING   zcx_abapgit_exception.
