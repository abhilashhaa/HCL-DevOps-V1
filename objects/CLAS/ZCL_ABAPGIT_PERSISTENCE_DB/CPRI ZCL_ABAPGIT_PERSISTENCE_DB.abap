  PRIVATE SECTION.

    CLASS-DATA go_db TYPE REF TO zcl_abapgit_persistence_db .
    DATA mv_update_function TYPE funcname .

    METHODS get_update_function
      RETURNING
        VALUE(rv_funcname) TYPE funcname .
    METHODS validate_and_unprettify_xml
      IMPORTING
        !iv_xml       TYPE string
      RETURNING
        VALUE(rv_xml) TYPE string
      RAISING
        zcx_abapgit_exception .