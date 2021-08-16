CLASS zcl_abapgit_default_transport DEFINITION
  PUBLIC
  CREATE PRIVATE .

  PUBLIC SECTION.
    CLASS-METHODS:
      get_instance
        RETURNING
          VALUE(ro_instance) TYPE REF TO zcl_abapgit_default_transport
        RAISING
          zcx_abapgit_exception.

    METHODS:
      constructor
        RAISING
          zcx_abapgit_exception,

      set
        IMPORTING
          iv_transport TYPE trkorr
        RAISING
          zcx_abapgit_exception,

      reset
        RAISING
          zcx_abapgit_exception,
      get
        RETURNING
          VALUE(rs_default_task) TYPE e070use
        RAISING
          zcx_abapgit_exception .

