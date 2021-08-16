CLASS zcl_abapgit_persist_factory DEFINITION
  PUBLIC
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_abapgit_persist_injector .

  PUBLIC SECTION.

    CLASS-METHODS get_repo
      RETURNING
        VALUE(ri_repo) TYPE REF TO zif_abapgit_persist_repo .