  PRIVATE SECTION.

    CONSTANTS:
      BEGIN OF c_action,
        delete TYPE string VALUE 'delete',
      END OF c_action .

    CLASS-METHODS delete
      IMPORTING
        !is_key TYPE zif_abapgit_persistence=>ty_content
      RAISING
        zcx_abapgit_exception.
    METHODS explain_content
      IMPORTING
        !is_data       TYPE zif_abapgit_persistence=>ty_content
      RETURNING
        VALUE(rv_text) TYPE string
      RAISING
        zcx_abapgit_exception .