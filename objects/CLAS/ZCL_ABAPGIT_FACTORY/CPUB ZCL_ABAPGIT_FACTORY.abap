CLASS zcl_abapgit_factory DEFINITION
  PUBLIC
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_abapgit_injector .

  PUBLIC SECTION.

    CLASS-METHODS get_tadir
      RETURNING
        VALUE(ri_tadir) TYPE REF TO zif_abapgit_tadir .
    CLASS-METHODS get_sap_package
      IMPORTING
        !iv_package           TYPE devclass
      RETURNING
        VALUE(ri_sap_package) TYPE REF TO zif_abapgit_sap_package .
    CLASS-METHODS get_code_inspector
      IMPORTING
        !iv_package              TYPE devclass
      RETURNING
        VALUE(ri_code_inspector) TYPE REF TO zif_abapgit_code_inspector
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_branch_overview
      IMPORTING
        !io_repo                  TYPE REF TO zcl_abapgit_repo_online
      RETURNING
        VALUE(ri_branch_overview) TYPE REF TO zif_abapgit_branch_overview
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS get_stage_logic
      RETURNING
        VALUE(ri_logic) TYPE REF TO zif_abapgit_stage_logic .
    CLASS-METHODS get_cts_api
      RETURNING
        VALUE(ri_cts_api) TYPE REF TO zif_abapgit_cts_api .
    CLASS-METHODS get_environment
      RETURNING
        VALUE(ri_environment) TYPE REF TO zif_abapgit_environment .
    CLASS-METHODS get_longtexts
      RETURNING
        VALUE(ri_longtexts) TYPE REF TO zif_abapgit_longtexts .
    CLASS-METHODS get_http_agent
      RETURNING
        VALUE(ri_http_agent) TYPE REF TO zif_abapgit_http_agent .