CLASS zcl_abapgit_persistence_repo DEFINITION
  PUBLIC
  CREATE PROTECTED
  GLOBAL FRIENDS zcl_abapgit_persist_factory .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_persist_repo .

    METHODS constructor .