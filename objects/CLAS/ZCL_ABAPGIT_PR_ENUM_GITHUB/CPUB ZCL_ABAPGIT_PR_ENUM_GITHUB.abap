CLASS zcl_abapgit_pr_enum_github DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_abapgit_pr_enum_provider .

    METHODS constructor
      IMPORTING
        !iv_user_and_repo TYPE string
        !ii_http_agent    TYPE REF TO zif_abapgit_http_agent
      RAISING
        zcx_abapgit_exception.