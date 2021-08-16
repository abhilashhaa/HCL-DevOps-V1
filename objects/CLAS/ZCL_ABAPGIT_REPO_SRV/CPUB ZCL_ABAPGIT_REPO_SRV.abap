CLASS zcl_abapgit_repo_srv DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_repo_srv .
    INTERFACES zif_abapgit_repo_listener .

    ALIASES get_repo_from_package
      FOR zif_abapgit_repo_srv~get_repo_from_package .

    CLASS-METHODS get_instance
      RETURNING
        VALUE(ri_srv) TYPE REF TO zif_abapgit_repo_srv .