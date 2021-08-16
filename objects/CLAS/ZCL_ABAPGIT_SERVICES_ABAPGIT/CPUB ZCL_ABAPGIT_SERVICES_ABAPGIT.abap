CLASS zcl_abapgit_services_abapgit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS: c_abapgit_repo     TYPE string   VALUE 'https://github.com/abapGit/abapGit'     ##NO_TEXT,
               c_abapgit_homepage TYPE string   VALUE 'https://www.abapgit.org'                ##NO_TEXT,
               c_abapgit_wikipage TYPE string   VALUE 'https://docs.abapgit.org'               ##NO_TEXT,
               c_dotabap_homepage TYPE string   VALUE 'https://dotabap.org'               ##NO_TEXT,
               c_abapgit_package  TYPE devclass VALUE '$ABAPGIT'                              ##NO_TEXT,
               c_abapgit_url      TYPE string   VALUE 'https://github.com/abapGit/abapGit.git' ##NO_TEXT,
               c_abapgit_class    TYPE tcode    VALUE `ZCL_ABAPGIT_REPO`                      ##NO_TEXT.

    CLASS-METHODS open_abapgit_homepage
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS open_abapgit_wikipage
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS open_dotabap_homepage
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS open_abapgit_changelog
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS install_abapgit
      RAISING
        zcx_abapgit_exception .
    CLASS-METHODS is_installed
      RETURNING
        VALUE(rv_devclass) TYPE tadir-devclass .
    CLASS-METHODS prepare_gui_startup
      RAISING
        zcx_abapgit_exception .