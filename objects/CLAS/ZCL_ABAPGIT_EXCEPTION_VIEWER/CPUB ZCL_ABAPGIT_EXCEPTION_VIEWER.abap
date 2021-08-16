CLASS zcl_abapgit_exception_viewer DEFINITION
  PUBLIC
  CREATE PUBLIC.


  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING
          ix_error TYPE REF TO zcx_abapgit_exception,

      goto_source
        RAISING
          zcx_abapgit_exception,

      goto_message
        RAISING
          zcx_abapgit_exception,

      show_callstack
        RAISING
          zcx_abapgit_exception.
