CLASS zcl_abapgit_http_agent DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES zif_abapgit_http_agent .

    CLASS-METHODS create
      RETURNING
        VALUE(ri_instance) TYPE REF TO zif_abapgit_http_agent .

    METHODS constructor.
