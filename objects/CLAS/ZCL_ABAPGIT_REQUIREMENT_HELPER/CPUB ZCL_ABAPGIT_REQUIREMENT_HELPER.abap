CLASS zcl_abapgit_requirement_helper DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_requirement_status,
        met               TYPE abap_bool,
        component         TYPE dlvunit,
        description       TYPE cvers_sdu-desc_text,
        installed_release TYPE saprelease,
        installed_patch   TYPE sappatchlv,
        required_release  TYPE saprelease,
        required_patch    TYPE sappatchlv,
      END OF ty_requirement_status .
    TYPES:
      ty_requirement_status_tt TYPE STANDARD TABLE OF ty_requirement_status WITH DEFAULT KEY .

    CLASS-METHODS requirements_popup
      IMPORTING
        !it_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS is_requirements_met
      IMPORTING
        !it_requirements TYPE zif_abapgit_dot_abapgit=>ty_requirement_tt
      RETURNING
        VALUE(rv_status) TYPE zif_abapgit_definitions=>ty_yes_no
      RAISING
        zcx_abapgit_exception .