CLASS zcl_abapgit_user_master_record DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE .

  PUBLIC SECTION.

    CLASS-METHODS:
      get_instance
        IMPORTING
          !iv_user       TYPE sy-uname
        RETURNING
          VALUE(ro_user) TYPE REF TO zcl_abapgit_user_master_record.

    METHODS:
      constructor
        IMPORTING
          !iv_user TYPE sy-uname,

      get_name
        RETURNING
          VALUE(rv_name) TYPE zif_abapgit_definitions=>ty_git_user-name,

      get_email
        RETURNING
          VALUE(rv_email) TYPE zif_abapgit_definitions=>ty_git_user-email.
