  PRIVATE SECTION.
    TYPES: BEGIN OF ty_settings_to_migrate,
             name  TYPE string,
             value TYPE string,
           END OF ty_settings_to_migrate,
           tty_settings_to_migrate TYPE STANDARD TABLE OF ty_settings_to_migrate
                                        WITH NON-UNIQUE DEFAULT KEY.

    CONSTANTS c_text TYPE string VALUE 'Generated by abapGit' ##NO_TEXT.

    CLASS-METHODS table_create
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS table_exists
      RETURNING
        VALUE(rv_exists) TYPE abap_bool .
    CLASS-METHODS lock_create
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS lock_exists
      RETURNING
        VALUE(rv_exists) TYPE abap_bool .
    CLASS-METHODS migrate_settings
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS migrate_setting
      IMPORTING
        iv_name                TYPE string
      CHANGING
        ct_settings_to_migrate TYPE tty_settings_to_migrate
        ci_document            TYPE REF TO if_ixml_document.
    CLASS-METHODS distribute_settings_to_users
      IMPORTING
        it_settings_to_migrate TYPE tty_settings_to_migrate
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS update_global_settings
      IMPORTING
        ii_document TYPE REF TO if_ixml_document
      RAISING
        zcx_abapgit_exception.
    CLASS-METHODS read_global_settings_xml
      RETURNING
        VALUE(rv_global_settings_xml) TYPE string
      RAISING
        zcx_abapgit_not_found.
    CLASS-METHODS get_global_settings_document
      RETURNING
        VALUE(ri_global_settings_dom) TYPE REF TO if_ixml_document
      RAISING
        zcx_abapgit_not_found.
