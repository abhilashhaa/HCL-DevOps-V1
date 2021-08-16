CLASS zcl_abapgit_repo_offline DEFINITION
  PUBLIC
  INHERITING FROM zcl_abapgit_repo
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS get_name
        REDEFINITION .
    METHODS has_remote_source
        REDEFINITION .