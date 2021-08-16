  PRIVATE SECTION.

    TYPES:
      BEGIN OF ty_repo_config,
        url              TYPE zif_abapgit_persistence=>ty_repo-url,
        login            TYPE string,
        git_user         TYPE zif_abapgit_definitions=>ty_git_user,
        last_change_seen TYPE string,
      END OF ty_repo_config .
    TYPES:
      ty_repo_config_tt TYPE STANDARD TABLE OF ty_repo_config WITH DEFAULT KEY .
    TYPES:
      BEGIN OF ty_user,
        default_git_user TYPE zif_abapgit_definitions=>ty_git_user,
        repo_show        TYPE zif_abapgit_persistence=>ty_repo-key,
        hide_files       TYPE abap_bool,
        changes_only     TYPE abap_bool,
        diff_unified     TYPE abap_bool,
        favorites        TYPE tt_favorites,
        repo_config      TYPE ty_repo_config_tt,
        settings         TYPE zif_abapgit_definitions=>ty_s_user_settings,
      END OF ty_user .

    DATA mv_user TYPE xubname .
    CLASS-DATA gi_current_user TYPE REF TO zif_abapgit_persist_user .

    METHODS from_xml
      IMPORTING
        !iv_xml        TYPE string
      RETURNING
        VALUE(rs_user) TYPE ty_user
      RAISING
        zcx_abapgit_exception .
    METHODS read
      RETURNING
        VALUE(rs_user) TYPE ty_user
      RAISING
        zcx_abapgit_exception .
    METHODS read_repo_config
      IMPORTING
        !iv_url               TYPE zif_abapgit_persistence=>ty_repo-url
      RETURNING
        VALUE(rs_repo_config) TYPE ty_repo_config
      RAISING
        zcx_abapgit_exception .
    METHODS to_xml
      IMPORTING
        !is_user      TYPE ty_user
      RETURNING
        VALUE(rv_xml) TYPE string .
    METHODS update
      IMPORTING
        !is_user TYPE ty_user
      RAISING
        zcx_abapgit_exception .
    METHODS update_repo_config
      IMPORTING
        !iv_url         TYPE zif_abapgit_persistence=>ty_repo-url
        !is_repo_config TYPE ty_repo_config
      RAISING
        zcx_abapgit_exception .