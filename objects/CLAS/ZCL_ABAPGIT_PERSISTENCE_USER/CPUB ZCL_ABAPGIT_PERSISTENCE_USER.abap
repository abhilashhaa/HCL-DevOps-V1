CLASS zcl_abapgit_persistence_user DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_persist_user.

    TYPES tt_favorites TYPE zif_abapgit_persistence=>tt_repo_keys .

    CLASS-METHODS get_instance
      IMPORTING
        !iv_user       TYPE xubname DEFAULT sy-uname
      RETURNING
        VALUE(ri_user) TYPE REF TO zif_abapgit_persist_user .
    METHODS constructor
      IMPORTING
        !iv_user TYPE xubname DEFAULT sy-uname .