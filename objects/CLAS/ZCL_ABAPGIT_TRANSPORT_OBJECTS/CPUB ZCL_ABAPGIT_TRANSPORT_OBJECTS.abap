CLASS zcl_abapgit_transport_objects DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !it_transport_objects TYPE zif_abapgit_definitions=>ty_tadir_tt .
    METHODS to_stage
      IMPORTING
        !io_stage           TYPE REF TO zcl_abapgit_stage
        !is_stage_objects   TYPE zif_abapgit_definitions=>ty_stage_files
        !it_object_statuses TYPE zif_abapgit_definitions=>ty_results_tt
      RAISING
        zcx_abapgit_exception .