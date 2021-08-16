CLASS zcl_abapgit_persist_injector DEFINITION
  PUBLIC
  CREATE PRIVATE
  FOR TESTING .

  PUBLIC SECTION.

    CLASS-METHODS set_repo
      IMPORTING
        !ii_repo TYPE REF TO zif_abapgit_persist_repo .