CLASS zcl_abapgit_folder_logic DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS package_to_path
      IMPORTING
        !iv_top        TYPE devclass
        !io_dot        TYPE REF TO zcl_abapgit_dot_abapgit
        !iv_package    TYPE devclass
      RETURNING
        VALUE(rv_path) TYPE string
      RAISING
        zcx_abapgit_exception .
    METHODS path_to_package
      IMPORTING
        !iv_top                  TYPE devclass
        !io_dot                  TYPE REF TO zcl_abapgit_dot_abapgit
        !iv_path                 TYPE string
        !iv_create_if_not_exists TYPE abap_bool DEFAULT abap_true
      RETURNING
        VALUE(rv_package)        TYPE devclass
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_instance
      RETURNING
        VALUE(ro_instance) TYPE REF TO zcl_abapgit_folder_logic .