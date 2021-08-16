CLASS zcl_abapgit_git_tag DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS add_tag_prefix
      IMPORTING
        !iv_text       TYPE csequence
      RETURNING
        VALUE(rv_text) TYPE string .
    CLASS-METHODS remove_tag_prefix
      IMPORTING
        !iv_text       TYPE string
      RETURNING
        VALUE(rv_text) TYPE string .