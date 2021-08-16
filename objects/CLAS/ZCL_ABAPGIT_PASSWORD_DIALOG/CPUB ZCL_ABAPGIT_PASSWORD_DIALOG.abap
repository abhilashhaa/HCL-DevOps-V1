CLASS zcl_abapgit_password_dialog DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS popup
      IMPORTING
        !iv_repo_url TYPE string
      CHANGING
        !cv_user     TYPE string
        !cv_pass     TYPE string .