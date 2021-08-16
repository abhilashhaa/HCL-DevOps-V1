CLASS zcl_abapgit_injector DEFINITION
  PUBLIC
  CREATE PRIVATE.

  PUBLIC SECTION.

    CLASS-METHODS set_tadir
      IMPORTING
        !ii_tadir TYPE REF TO zif_abapgit_tadir .
    CLASS-METHODS set_sap_package
      IMPORTING
        !iv_package     TYPE devclass
        !ii_sap_package TYPE REF TO zif_abapgit_sap_package .
    CLASS-METHODS set_code_inspector
      IMPORTING
        !iv_package        TYPE devclass
        !ii_code_inspector TYPE REF TO zif_abapgit_code_inspector .
    CLASS-METHODS set_stage_logic
      IMPORTING
        !ii_logic TYPE REF TO zif_abapgit_stage_logic .
    CLASS-METHODS set_cts_api
      IMPORTING
        !ii_cts_api TYPE REF TO zif_abapgit_cts_api .
    CLASS-METHODS set_environment
      IMPORTING
        !ii_environment TYPE REF TO zif_abapgit_environment .
    CLASS-METHODS set_longtexts
      IMPORTING
        !ii_longtexts TYPE REF TO zif_abapgit_longtexts .
    CLASS-METHODS set_http_agent
      IMPORTING
        !ii_http_agent TYPE REF TO zif_abapgit_http_agent .