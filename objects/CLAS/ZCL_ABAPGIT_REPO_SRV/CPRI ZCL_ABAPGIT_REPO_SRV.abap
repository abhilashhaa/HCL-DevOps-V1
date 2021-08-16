  PRIVATE SECTION.

    ALIASES delete
      FOR zif_abapgit_repo_srv~delete .
    ALIASES get
      FOR zif_abapgit_repo_srv~get .
    ALIASES list
      FOR zif_abapgit_repo_srv~list .
    ALIASES validate_package
      FOR zif_abapgit_repo_srv~validate_package .

    CLASS-DATA gi_ref TYPE REF TO zif_abapgit_repo_srv .
    DATA mv_init TYPE abap_bool VALUE abap_false ##NO_TEXT.
    DATA mt_list TYPE zif_abapgit_definitions=>ty_repo_ref_tt .

    METHODS refresh
      RAISING
        zcx_abapgit_exception .
    METHODS is_sap_object_allowed
      RETURNING
        VALUE(rv_allowed) TYPE abap_bool .
    METHODS instantiate_and_add
      IMPORTING
        !is_repo_meta  TYPE zif_abapgit_persistence=>ty_repo
      RETURNING
        VALUE(ro_repo) TYPE REF TO zcl_abapgit_repo
      RAISING
        zcx_abapgit_exception .
    METHODS add
      IMPORTING
        !io_repo TYPE REF TO zcl_abapgit_repo
      RAISING
        zcx_abapgit_exception .
    METHODS reinstantiate_repo
      IMPORTING
        !iv_key  TYPE zif_abapgit_persistence=>ty_repo-key
        !is_meta TYPE zif_abapgit_persistence=>ty_repo_xml
      RAISING
        zcx_abapgit_exception .
    METHODS validate_sub_super_packages
      IMPORTING
        !iv_package    TYPE devclass
        !it_repos      TYPE zif_abapgit_persistence=>tt_repo
        !iv_ign_subpkg TYPE abap_bool DEFAULT abap_false
      EXPORTING
        VALUE(eo_repo) TYPE REF TO zcl_abapgit_repo
        !ev_reason     TYPE string
      RAISING
        zcx_abapgit_exception .